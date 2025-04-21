import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  
  final ImageModel image;

  
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Define the shape of the dialog.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ARoundedContainer(
          // Set the width of the rounded container based on the screen size.
          width: AriloDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option to close the dialog.
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container.
                    ARoundedContainer(
                      backgroundColor: AriloColors.lightshow,
                      child: AriloRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: AriloDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ), // TRoundedContainer
                    // Close icon button positioned at the top-right corner.
                    Positioned(top: 0, right: 0, child: IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_circle))),
                  ],
                ),
              ), // SizedBox
              const Divider(),
              const SizedBox(height: 16),

              // Display various metadata about the image.
              // Includes image name, path, type, size, creation and modification dates, and URL.
              // Also provides an option to copy the image URL.
              Row(
                children: [
                  Expanded(child: Text('Image Name:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(flex: 3, child: Text(image.filename, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ), // Row

              // Display the image URL with an option to copy it.
              Row(
                children: [
                  Expanded(child: Text('Image URL:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                    flex: 2,
                    child: Text(image.url, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ), // Expanded
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) => ALoaders.showInfoSnackBar(title: 'Copied', message: 'URL Copied Successfully'));
                      },
                      child: const Text('Copy URL'),
                    ), // OutlinedButton
                  ), // Expanded
                ],
              ), // Row
              const SizedBox(height: 32),

              // Display a button to delete the image.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: (){},
                      child: const Text('Delete Image', style: TextStyle(color: Colors.red)),
                    ), // TextButton
                  ), // SizedBox
                ],
              ), // Row
            ],
          ),
        ),
      ),
    );
  }
}