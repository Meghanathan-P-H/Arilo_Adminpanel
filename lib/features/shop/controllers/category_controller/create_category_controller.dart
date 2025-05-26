import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/category_repo.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static int maxCategory = 8;

  Future<void> createCategory() async {
    try {
      BlackCircularProgressIndicator(content: 'Creating category..');
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.context!).pop();
        return;
      }

      if (!formKey.currentState!.validate()) {
        Navigator.of(Get.context!).pop();
        return;
      }

      final getExistingCategory =
          await CategoryRepository.instance.getAllCategories();

      if (getExistingCategory.length >= maxCategory) {
        Navigator.of(Get.context!).pop();
        ALoaders.showErrorSnackBar(
          title: 'Limit Reached',
          message:
              'Maximum $maxCategory categories allowed. Cannot add more categories!',
        );
        return;
      }

      final categoryName = name.text.trim().toLowerCase();
      final isDuplicate = getExistingCategory.any(
        (category) => category.name.toLowerCase() == categoryName,
      );

      if (isDuplicate) {
        Navigator.of(Get.context!).pop();
        ALoaders.showErrorSnackBar(
          title: 'Duplicate Category',
          message:
              'A category with this name already exists. Please choose a different name.',
        );
        return;
      }

      final newRecord = CategoryModel(
        id: '',
        name: name.text.trim(),
        image: imageURL.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      newRecord.id = await CategoryRepository.instance.createCategory(
        newRecord,
      );

      CategoryController.instance.addItemToLists(newRecord);

      resetField();
      ALoaders.showSuccessSnackBar(
        title: 'Congratulations',
        message: 'New Category has been added',
      );
    } catch (e) {
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  void resetField() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }
}
