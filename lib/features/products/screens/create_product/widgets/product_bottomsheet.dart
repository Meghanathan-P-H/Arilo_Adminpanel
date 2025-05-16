import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

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
              onPressed: () => CreateProductController.instance.createProduct(),
              child: Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
