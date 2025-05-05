import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/product_repo.dart';
import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_category_model.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/product_controller/product_controller.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
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

  // final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      BlackCircularProgressIndicator();

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

      // if (selectedBrand.value == null) throw 'Select Brand for this product';

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
      final ProductImageController imagesController =
          ProductImageController.instance;
      if (imagesController.selectedThumblineImageUrl.value == null) {
        throw 'Select Product Thumbnail Image';
      }

      additionalImagesUploader.value = true;

      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImageUrls,
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
    } catch (e) {
      
    }
  }
}
