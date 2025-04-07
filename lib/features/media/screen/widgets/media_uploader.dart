import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Column(
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
                          (cntl) => controller.dropzoneViewController = cntl,
                      onDrop: (file) {},
                      onDropInvalid: (ev) => print('Zone invalid MIME:$ev'),
                      onDropMultiple: (ev) async {
                        print('Zone drop Multiple:$ev');
                      },
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
