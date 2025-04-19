import 'dart:typed_data';

import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/features/media/screen/widgets/folder_down.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/state_manager.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () =>
          controller.showImagesUploaderSection.value
              ? Column(
                children: [
                  ARoundedContainer(
                    height: 250,
                    showBorder: true,
                    borderColor: const Color(0xFFD9D9D9),
                    backgroundColor: Color(0xFFF5F5F5),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              DropzoneView(
                                mime: const ['image/jpeg', 'image/png'],
                                cursor: CursorType.Default,
                                operation: DragOperation.copy,
                                onLoaded: () => print('Zone loaded'),
                                onError: (ev) => print('Zone error:$ev'),
                                onHover: () => print('Zone hovered'),
                                onLeave: () => print('Zone left'),
                                onCreated:
                                    (cntl) =>
                                        controller.dropzoneViewController =
                                            cntl,
                                onDropInvalid:
                                    (ev) => print('Zone invalid MIME:$ev'),
                                onDropMultiple:
                                    (ev) => print('Zone drop Multiple:$ev'),
                                onDrop: (file) async {
                                  if (file != null) {
                                    final bytes = await controller
                                        .dropzoneViewController
                                        .getFileData(file);
                                    final image = ImageModel(
                                      url: '',
                                      file: file,
                                      folder: 'my_folder',
                                      filename: file.name,
                                      localImageToDisplay: Uint8List.fromList(
                                        bytes,
                                      ),
                                      createdAt: DateTime.now(),
                                      mediaCategory: 'gallery',
                                    );

                                    controller.selectedImagesToUpload.add(
                                      image,
                                    );
                                  } else if (file is String) {
                                    print('Zone drop:$file');
                                  } else {
                                    print(
                                      'Zone unknown type: ${file.runtimeType}',
                                    );
                                  }
                                },
                              ),

                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/imagedefulticon.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(height: 16),
                                  Text('Drag and Drop Images here'),
                                  const SizedBox(height: 16),
                                  OutlinedButton(
                                    onPressed: () {
                                      controller.selectLocalImages();
                                    },
                                    child: const Text('Select Images'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (controller.selectedImagesToUpload.isNotEmpty)
                    ARoundedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Select Folder',
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(width: 16),
                                  MediaFolderDropDown(
                                    onChanged: (MediaCategory? newValue) {
                                      if (newValue != null) {
                                        controller.selectedPath.value =
                                            newValue;
                                      }
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  TextButton(
                                    onPressed: ()=>controller.selectedImagesToUpload.clear(),
                                    child: const Text('Remove All'),
                                  ),
                                  const SizedBox(width: 16),
                                  AriloDeviceUtils.isMobileScreen(context)
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                        width: 130,
                                        child: ElevatedButton(
                                          onPressed: ()=>controller.uploadImageConfirmation(),
                                          child: const Text('Upload'),
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                controller.selectedImagesToUpload
                                    .where(
                                      (image) =>
                                          image.localImageToDisplay != null,
                                    )
                                    .map(
                                      (element) => AriloRoundedImage(
                                        width: 90,
                                        height: 90,
                                        padding: 8,
                                        imageType: ImageType.memory,
                                        memoryImage:
                                            element.localImageToDisplay,
                                        backgroundColor:
                                            AriloColors.iconSearchCl,
                                      ),
                                    )
                                    .toList(),
                          ),

                            const SizedBox(height: 32),
                            AriloDeviceUtils.isMobileScreen(context)
                                ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:()=> controller.uploadImageConfirmation(),
                                    child: const Text('Upload'),
                                  ),
                                )
                                : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                ],
              )
              : const SizedBox(),
    );
  }
}