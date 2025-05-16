import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductImageController controller = Get.put(ProductImageController());

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Thumbnail',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          ARoundedContainer(
            height: 300,
            backgroundColor: AriloColors.iconSearchCl,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => AriloRoundedImage(
                            height: 220,
                            width: 220,
                            image:
                                controller.selectedThumblineImageUrl.value ??
                                'assets/images/imagedefulticon.png',//tumbnail image if u want change it
                            imageType:
                                controller.selectedThumblineImageUrl.value ==
                                        null
                                    ? ImageType.asset
                                    : ImageType.network,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () => controller.selectThumbnailImage(),
                      child: const Text('Add Thumbnail'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
