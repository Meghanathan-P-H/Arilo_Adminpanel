import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:get/get.dart';


class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

  Rx<String?> selectedThumblineImageUrl = Rx<String?>(null);

  final RxList<String> additionalProductImageUrls = <String>[].obs;

  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      selectedThumblineImageUrl.value = selectedImage.url;
    }
  }

  void selectMultipleProductImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia(
      multipleSelection: true,
      selectedUrls: additionalProductImageUrls,
    );
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImageUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  Future<void> removeImage(int index) async {
    additionalProductImageUrls.removeAt(index);
  }
}
