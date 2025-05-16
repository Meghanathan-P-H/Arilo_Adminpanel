import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/banner_repo.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/shop/controllers/banner_controller/banner_controller.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:arilo_admin/utils/helpers/app_screens.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  Future<void> createBanner() async {
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

      final newRecord = BannerModel(
        id: '',
        imageUrl: imageURL.value,
        targetScreen: targetScreen.value,
        active: isActive.value,
      );

      newRecord.id = await BannerRepository.instance.createBanner(newRecord);

      BannerController.instance.addItemToLists(newRecord);

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
