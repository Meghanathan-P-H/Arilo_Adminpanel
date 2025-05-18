import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductThumbnailImage extends StatelessWidget {
  const EditProductThumbnailImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductImageController(isEditMode: true, productModel: product),
      tag: 'createProductImage',
    );

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
                                product.thumbnail,
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
