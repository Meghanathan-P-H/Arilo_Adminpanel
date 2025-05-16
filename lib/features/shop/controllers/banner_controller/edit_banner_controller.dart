import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/banner_repo.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/shop/controllers/banner_controller/banner_controller.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  Future<void> updateBanner(BannerModel banner) async {
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

      if (banner.imageUrl != imageURL.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        await repository.updateBanner(banner);
      }


      BannerController.instance.updateItemFromList(banner);

      Navigator.of(Get.context!).pop();
      ALoaders.showSuccessSnackBar(
        title: 'Congratulations',
        message: 'New Record has been updated.',
      );
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
