import 'package:arilo_admin/data/repositories/product_repo.dart';
import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/controllers/product_controller/product_controller.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
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

  // final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
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

      // selectedBrand.value = product.brand;
      // brandTextField.text = product.brand?.name ?? '';

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

  
}
