import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/product_repo.dart';
import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_category_model.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/features/shop/models/brand_model.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final variationsController = Get.put(ProductVariationController());
  final attribuutesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImageController());
  final productRepository = Get.put(ProductRepository());
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> allreadyAddedCategories = <CategoryModel>[];

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  void initProductData(ProductModel product) {
    try {
      isLoading.value = true;

      title.text = product.title;
      description.text = product.description ?? '';
      productType.value =
          product.productType == ProductType.single.toString()
              ? ProductType.single
              : ProductType.variable;

      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      if (product.images != null) {
        imagesController.selectedThumblineImageUrl.value = product.thumbnail;

        imagesController.additionalProductImageUrls.assignAll(
          product.images ?? [],
        );
      }

      attribuutesController.productAttributes.assignAll(
        product.productAttributes ?? [],
      );
      variationsController.productVariations.assignAll(
        product.productVariations ?? [],
      );
      variationsController.initializeVariationControllers(
        product.productVariations ?? [],
      );

      isLoading.value = false;

      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;

    final productCategories = await productRepository.getProductCategories(
      productId,
    );
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories =
        categoriesController.allItems
            .where((element) => categoriesIds.contains(element.id))
            .toList();
    selectedCategories.assignAll(categories);
    allreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  Future<void> editProduct(ProductModel product) async {
    try {
      showProgressDialog();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.context!).pop();
        return;
      }

      if (!titleDescriptionFormKey.currentState!.validate()) {
        Navigator.of(Get.context!).pop();
        return;
      }

      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        Navigator.of(Get.context!).pop();
        return;
      }

      if (selectedBrand.value == null) {
        throw 'Select Brand for this product';
      }

      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product type Variable. Create some variations or change Product type.';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance
            .productVariations
            .any(
              (element) =>
                  element.price.isNaN ||
                  element.price < 0 ||
                  element.salePrice.isNaN ||
                  element.salePrice < 0 ||
                  element.stock.isNaN ||
                  element.stock < 0,
            );
        if (variationCheckFailed) {
          throw 'Variation data  is not accurate.Please recheck variations';
        }
      }

      final imagesController = ProductImageController.instance;
      if (imagesController.selectedThumblineImageUrl.value == null ||
          imagesController.selectedThumblineImageUrl.value!.isEmpty) {
        throw 'Upload Product Thumbnail Image';
      }

      var variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImageUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail =
          imagesController.selectedThumblineImageUrl.value ?? '';
      product.productAttributes =
          ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);

      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        List<String> existingCategoryIds =
            allreadyAddedCategories.map((category) => category.id).toList();

        for (var category in selectedCategories) {
          if (!existingCategoryIds.contains(category.id)) {
            final productCategory = ProductCategoryModel(
              productId: product.id,
              categoryId: category.id,
            );
            await ProductRepository.instance.createProductCategory(
              productCategory,
            );
          }
        }

        for (var existingCategoryId in existingCategoryIds) {
          if (!selectedCategories.any(
            (category) => category.id == existingCategoryId,
          )) {
            await ProductRepository.instance.removeProductCategory(
              product.id,
              existingCategoryId,
            );
          }
        }
      }

      ProductController.instance.updateItemFromList(product);

      Navigator.of(Get.context!).pop();

      showCompletionDialog();
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Editing Product'),
              content: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('', height: 200, width: 200),
                    const SizedBox(height: 16),
                    buildCheckbox('Thumbnail Image', thumbnailUploader),
                    buildCheckbox(
                      'Additional Images',
                      additionalImagesUploader,
                    ),
                    buildCheckbox(
                      'Product Data, Attributes & Variations',
                      productDataUploader,
                    ),
                    buildCheckbox(
                      'Product Categories',
                      categoriesRelationshipUploader,
                    ),
                    const SizedBox(height: 16),
                    const Text('Sit Tight, Your product is uploading...'),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child:
              value.value
                  ? const Icon(
                    CupertinoIcons.checkmark_alt_circle_fill,
                    color: Colors.blue,
                  )
                  : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: 16),
        Text(label),
      ],
    );
  }

  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go to Products'),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('', height: 200, width: 200),
            const SizedBox(height: 16),
            Text(
              'Congratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text('Your Product has been Updated'),
          ],
        ),
      ),
    );
  }
}
