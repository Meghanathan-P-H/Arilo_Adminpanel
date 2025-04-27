import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/media/screen/widgets/folder_down.dart';
import 'package:arilo_admin/features/media/screen/widgets/media_page.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/popups/animation_loder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImageS)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Select Folder',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 16),
                  MediaFolderDropDown(
                    onChanged: (MediaCategory? newValue) {
                      if (newValue != null) {
                        controller.selectedPath.value = newValue;
                        controller.getMediaImages();

                        List<ImageModel> images = _getSelectedFolderImages(
                          controller,
                        );
                        print("Images count: ${images.length}");
                        print(
                          "Sample URLs: ${images.take(3).map((e) => e.url).toList()}",
                        );
                      }
                    },
                  ),
                ],
              ),
              if (allowSelection) buildAddSelectedImageButton(),
            ],
          ),
          SizedBox(height: 32),

          Obx(() {
            List<ImageModel> images = _getSelectedFolderImages(controller);

            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null &&
                  alreadySelectedUrls!.isNotEmpty) {
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);
                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

            if (controller.loading.value && images.isEmpty) {
              return const CircularProgressIndicator();
            }

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children:
                      images
                          .map(
                            (image) => GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ImagePopup(image: image),
                                );
                              },
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    allowSelection
                                        ? _buildListWithCheckBox(image)
                                        : _buildSimpleList(image),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          image.filename,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),

                if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: const Text('Load More'),
                            icon: const Icon(Iconsax.arrow_down),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images =
          controller.allBannerImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images =
          controller.allBrandImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images =
          controller.allCategoryImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images =
          controller.allProductImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images =
          controller.allUserImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24 * 3),
      child: AriloAnimationLoaderWidget(
        width: 300,
        height: 300,
        animation: 'assets/logos/loding.json',
        text: 'Selected Your Desired Folder',
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return Column(
      children: [
        AriloRoundedImage(
          width: 140,
          height: 120,
          padding: 8,
          image: image.url,
          imageType: ImageType.network,
          margin: 8,
          backgroundColor: AriloColors.textSecondary,
        ),
      ],
    );
  }

  Widget _buildListWithCheckBox(ImageModel image) {
    return Stack(
      children: [
        AriloRoundedImage(
          width: 140,
          height: 140,
          padding: 8,
          imageType: ImageType.network,
          margin: 8,
          backgroundColor: AriloColors.textSecondary,
        ),

        Positioned(
          top: 16,
          right: 16,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  if (!allowMultipleSelection) {
                    for (var otherImage in selectedImages) {
                      if (otherImage != image) {
                        otherImage.isSelected.value = false;
                      }
                    }
                    selectedImages.clear();
                  }
                  image.isSelected.value = selected;
                  if (selected) {
                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddSelectedImageButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            label: Text('Close'),
            icon: const Icon(Iconsax.close_circle),
            onPressed: () => Get.back(),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
          ),
        ),
      ],
    );
  }
}
