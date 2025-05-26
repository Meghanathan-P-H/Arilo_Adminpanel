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
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final name = TextEditingController();
  final isFeatured = false.obs;
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

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

  Future<void> createBrand() async {
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

      final getExistingBrand = await BrandRepository.instance.getAllBrands();

      final brandName = name.text.trim().toLowerCase();
      final isDuplicate = getExistingBrand.any(
        (category) => category.name.toLowerCase() == brandName,
      );

      if (isDuplicate) {
        Navigator.of(Get.context!).pop();
        ALoaders.showErrorSnackBar(
          title: 'Duplicate Brand',
          message:
              'A Brand with this name already exists. Please choose a different name..',
        );
        return;
      }

      final newRecord = BrandModel(
        id: '',
        image: imageUrl.value,
        name: name.text.trim(),
        productsCount: 0,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing relational data.Try again';
        }

        for (var category in selectedCategories) {
          final brandCategory = BrandCategoryModel(
            brandId: newRecord.id,
            categoryId: category.id,
          );
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }
      BrandController.instance.addItemToLists(newRecord);

      resetFiled();

      Navigator.of(Get.context!).pop();
      ALoaders.showSuccessSnackBar(
        title: 'Congratulations',
        message: 'New Record has been added.',
      );
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
