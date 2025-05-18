import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/edit_product_controller.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductVisibilityWidget extends StatelessWidget {
  const EditProductVisibilityWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    controller.productVisibility.value =
        product.isFeatured == true ? ProductVisibility.published : ProductVisibility.hidden;

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Obx(
            () => Column(
              children: [
                RadioListTile<ProductVisibility>(
                  title: const Text('Published'),
                  value: ProductVisibility.published,
                  groupValue: controller.productVisibility.value,
                  onChanged: (value) {
                    controller.productVisibility.value = value!;
                  },
                  contentPadding: EdgeInsets.zero,
                ),

                RadioListTile<ProductVisibility>(
                  title: const Text('Hidden'),
                  value: ProductVisibility.hidden,
                  groupValue: controller.productVisibility.value,
                  onChanged: (value) {
                    controller.productVisibility.value = value!;
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
