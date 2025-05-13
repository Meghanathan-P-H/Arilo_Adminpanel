import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/brand_repo.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/features/shop/models/brand_category_model.dart';
import 'package:arilo_admin/features/shop/models/brand_model.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final name = TextEditingController();
  final isFeatured = false.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  void init(BrandModel brand) {
    name.text = brand.name;
    imageUrl.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void resetFiled() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageUrl.value = '';
    selectedCategories.clear();
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl.value = selectedImage.url;
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      BlackCircularProgressIndicator();

      if (!formKey.currentState!.validate()) {
        return;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.context!).pop();
        return;
      }

      bool isBrandUpdated = false;
      if (brand.image != imageUrl.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        brand.image = imageUrl.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        await repository.updateBrand(brand);
      }

      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      if (isBrandUpdated) await updateBrandInProuducts(brand);

      BrandController.instance.updateItemFromList(brand);

      update();

      Navigator.of(Get.context!).pop();
      ALoaders.showSuccessSnackBar(
        title: 'Congratulations',
        message: 'New Record has been updated .',
      );
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


      updateBrandCategories(BrandModel brand) async {
      final brandCategories = await repository.getCategoriesofSpecificBrand(
        brand.id,
      );

      final selectedCategoryIds = selectedCategories.map((e) => e.id);

      final categoriesToRemove =
          brandCategories
              .where(
                (existingCategory) =>
                    !selectedCategoryIds.contains(existingCategory.categoryId),
              )
              .toList();

      for (var categoryToRemove in categoriesToRemove) {
        await BrandRepository.instance.deleteBrandCategory(
          categoryToRemove.id ?? '',
        );
      }

      final newCategoriesToAdd =
          selectedCategories
              .where(
                (newCategory) =>
                    !brandCategories.any(
                      (existingCategory) =>
                          existingCategory.categoryId == newCategory.id,
                    ),
              )
              .toList();

      for (var newCategory in newCategoriesToAdd) {
        var brandCategory = BrandCategoryModel(
          brandId: brand.id,
          categoryId: newCategory.id,
        );
        brandCategory.id = await BrandRepository.instance.createBrandCategory(
          brandCategory,
        );
      }

      brand.brandCategories!.assignAll(selectedCategories);
      BrandController.instance.updateItemFromList(brand);
    }

  updateBrandInProuducts(BrandModel brand) async {}

}
