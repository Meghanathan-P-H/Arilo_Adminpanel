import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? const Column(
                children: [
                  Divider(color: AriloColors.lightshow),
                  SizedBox(height: 32),
                ],
              )
              : const SizedBox.shrink();
        }),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),

        // Form to add new attribute
        Form(
          key: attributeController.attributesFormKey,
          child:
              AriloDeviceUtils.isDesktopScreen(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributeName(attributeController)),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildAttributes(attributeController),
                      ),
                      const SizedBox(width: 16),
                      _buildAttributeButton(attributeController),
                    ],
                  )
                  : Column(
                    children: [
                      _buildAttributeName(attributeController),
                      const SizedBox(height: 16),
                      _buildAttributes(attributeController),
                      const SizedBox(height: 16),
                      _buildAttributeButton(attributeController),
                    ],
                  ),
        ),
        const SizedBox(height: 32),
        Text(
          'All Attributes,',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),

        ARoundedContainer(
          backgroundColor: AriloColors.primary,
          child: Obx(
            () =>
                attributeController.productAttributes.isNotEmpty
                    ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: attributeController.productAttributes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AriloColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              attributeController
                                      .productAttributes[index]
                                      .name ??
                                  '',
                            ),
                            subtitle: Text(
                              attributeController
                                  .productAttributes[index]
                                  .values!
                                  .map((e) => e.trim())
                                  .toString(),
                            ),
                            trailing: IconButton(
                              onPressed:
                                  () => attributeController.removeAttribute(
                                    index,
                                    context,
                                  ),
                              icon: const Icon(
                                Iconsax.trash,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    : const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AriloRoundedImage(
                              width: 150,
                              height: 80,
                              imageType: ImageType.asset,
                              image: 'assets/images/imagedefulticon.png',//square colors are here need to change
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Text('There are no attributes added for this product'),
                      ],
                    ),
          ),
        ),

        Obx(
          () =>
              productController.productType.value == ProductType.variable &&
                      variationController.productVariations.isEmpty
                  ? Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(
                          icon: const Icon(Iconsax.activity),
                          label: const Text('Generate Variations'),
                          onPressed:
                              () => variationController
                                  .generateVariationsConfirmation(context),
                        ), 
                      ), 
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }

  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator:
          (value) => AriloValidator.validateEmptyText('Attribute Name', value),
      decoration: InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors,Size,Material',
      ),
    );
  }

  SizedBox _buildAttributes(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator:
            (value) =>
                AriloValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes Sepreated by | Example : Green,Blue,Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  SizedBox _buildAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellowAccent, 
          side: const BorderSide(color: AriloColors.iconSearchCl),
        ),
        label: Text('Add'),
      ),
    );
  }
}
