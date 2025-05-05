import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_variation_model.dart';
import 'package:arilo_admin/features/shop/controllers/product_controller/product_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/image_uploader.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;

    return Obx(
      () =>
          CreateProductController.instance.productType.value ==
                  ProductType.variable
              ? ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Variations',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed:
                              () =>
                                  variationController.removeVariations(context),
                          child: const Text('Remove Variations'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (variationController.productVariations.isNotEmpty)
                      ListView.separated(
                        itemCount: variationController.productVariations.length,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (_, index) {
                          final variation =
                              variationController.productVariations[index];
                          return _buildVariationTile(
                            context,
                            index,
                            variation,
                            variationController,
                          );
                        },
                      )
                    else
                      _buildNoVariationsMessage(),
                  ],
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildVariationTile(
    BuildContext context,
    int index,
    ProductVariationModel variation,
    ProductVariationController variationController,
  ) {
    return ExpansionTile(
      backgroundColor: AriloColors.lightshow,
      collapsedBackgroundColor: AriloColors.lightshow,
      childrenPadding: const EdgeInsets.all(16),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        variation.attributeValues.entries
            .map((entry) => '${entry.key}: ${entry.value}')
            .join(', '),
      ),
      children: [
        Obx(
          () => ImageUploader(
            image:
                variation.image.value.isNotEmpty ? variation.image.value : 'assets/images/imagedefulticon.png',
            onIconButtonPressed:
                () => ProductImageController.instance.selectVariationImage(
                  variation,
                ),
          ),
        ),
        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
                controller:
                    variationController.stockControllersList[index][variation],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),

            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                onChanged: (value) => variation.price = double.parse(value),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
                controller:
                    variationController.priceControllersList[index][variation],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller:
                    variationController
                        .salePriceControllersList[index][variation],
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
          ],
        ),

        TextFormField(
          onChanged: (value) => variation.description = value,
          controller:
              variationController.descriptionControllersList[index][variation],
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add description of this variation...',
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AriloRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: 'assets/images/imagedefulticon.png',
            ),
          ],
        ), // Row
        SizedBox(height: 32),
        Text('There are no Variations added for this product'),
      ],
    );
  }
}
