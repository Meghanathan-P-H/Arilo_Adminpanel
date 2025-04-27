import 'dart:typed_data';
import 'package:arilo_admin/features/media/controls/mediarepo.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/media/screen/widgets/media_content.dart';
import 'package:arilo_admin/features/media/screen/widgets/media_uploader.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/constants/heper_text.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/dialog.dart';
import 'package:arilo_admin/utils/popups/full_screen_popups.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneViewController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
      );

      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      ALoaders.showErrorSnackBar(
        title: 'Oh Snap',
        message: 'Unable to fletch Images,Something went wrong. Try again',
      );
    }
  }

  loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
        targetList.last.createdAt ?? DateTime.now(),
      );

      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      ALoaders.showErrorSnackBar(
        title: 'Oh Snap',
        message: 'Unable to fletch Images,Something went wrong. Try again',
      );
    }
  }

  Future<void> selectLocalImages() async {
    final files = await dropzoneViewController.pickFiles(
      multiple: true,
      mime: ['image/jpeg', 'image/png'],
    );

    if (files.isNotEmpty) {
      for (final file in files) {
        final bytes = await dropzoneViewController.getFileData(file);
        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImageConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      ALoaders.showWarningSnackBar(
        title: 'Selected Folder',
        message: 'Please select a folder to upload the images.',
      );
      return;
    }

    ADialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
          'Are you sure you want to upload all the images in ${selectedPath.value.name.toUpperCase()} folder?',
    );
  }

  Future<void> uploadImages() async {
    try {
      // Get.back();
      uploadImagesLoader();

      MediaCategory selectedCategory = selectedPath.value;
      RxList<ImageModel> targetList;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;

        final ImageModel uploadImage = await mediaRepository
            .uploadImageFileInStorage(
              file: image,
              path: getSelectedPath(),
              imageName: selectedImage.filename,
            );

        uploadImage.mediaCategory = selectedCategory.name;

        final id = await mediaRepository.uploadImageFileInDatabase(uploadImage);

        uploadImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadImage);
      }
      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();
      ALoaders.showWarningSnackBar(
        title: 'Error Uploading Images',
        message: 'Something went wrong while uploading your Images.',
      );
    }
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Uploading Images'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/imagedefulticon.png',
                    height: 300,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  const Text('Sit Tight,Your images are uploading...'),
                ],
              ),
            ),
          ),
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = ATexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = ATexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = ATexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = ATexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = ATexts.usersStoragePath;
        break;
      default:
        path = '';
    }
    return path;
  }

  void removeCloudImageConfirmation(ImageModel image) {
    ADialogs.defaultDialog(
      context: Get.context!,
      title: 'Delete Image',
      confirmText: 'Delete',
      onConfirm: () {
        removeCloudImage(image);
      },
      content: 'Are you sure you want to delete this Images?',
    );
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();

      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(
          child: SizedBox(
            width: 150,
            height: 150,
            child: BlackCircularProgressIndicator(),
          ),
        ),
      );

      await mediaRepository.deleteFileFromStorage(image);

      RxList<ImageModel> targetList;

      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        default:
          return;
      }

      targetList.remove(image);
      update();

      FullScreenLoader.stopLoading();
      ALoaders.showSuccessSnackBar(
        title: 'Image Deleted',
        message: 'Image successfully deleted from your cloud storage',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFromMedia({
    List<String>? selectedUrls,
    bool allowSelection = true,
    bool multipleSelection = false,
  }) async {
    showImagesUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: AriloColors.secondary,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                MediaUploader(),
                MediaContent(
                  allowSelection: allowSelection,
                  alreadySelectedUrls: selectedUrls ?? [],
                  allowMultipleSelection: multipleSelection,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return selectedImages;
  }
}
