import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () => Row(
        children: [
          Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 16),
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Single'),
          ), 
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Variable'),
          ), 
        ],
      ),
    );
  }
}