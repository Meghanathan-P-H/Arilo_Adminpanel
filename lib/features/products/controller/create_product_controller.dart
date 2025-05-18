import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/product_repo.dart';
import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_category_model.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/features/shop/models/brand_model.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  // Singleton instance
  static CreateProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
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

      if (selectedBrand.value == null) throw 'Select Brand for this product';

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
                  element.stock < 0 ||
                  element.image.value.isEmpty,
            );

        if (variationCheckFailed) {
          throw 'Variation data is not accurate. Please recheck variations';
        }
      }

      thumbnailUploader.value = true;
      final imagesController = ProductImageController.instance;
      if (imagesController.selectedThumblineImageUrl.value == null) {
        throw 'Select Product Thumbnail Image';
      }

      additionalImagesUploader.value = true;

      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImageUrls.toList(),
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumblineImageUrl.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );

      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
            productId: newRecord.id,
            categoryId: category.id,
          );
          await ProductRepository.instance.createProductCategory(
            productCategory,
          );
        }
      }

      ProductController.instance.addItemToLists(newRecord);
      Navigator.of(Get.context!).pop();

      showCompletionDialog();
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Creating Product'),
              content: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/shoes.png',
                      height: 200,
                      width: 200,
                    ),
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
            Image.asset('assets/images/shoes.png', height: 200, width: 200),
            const SizedBox(height: 16),
            Text(
              'Congratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text('Your Product has been Created'),
          ],
        ),
      ),
    );
  }
}
