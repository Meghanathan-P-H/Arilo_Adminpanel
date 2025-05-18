import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/edit_product_controller.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductEditBottomNavigationButtons extends StatelessWidget {
  const ProductEditBottomNavigationButtons({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Discard'),
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => EditProductController.instance.editProduct(product),
              child: Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
