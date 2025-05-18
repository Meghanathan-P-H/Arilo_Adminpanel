import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/edit_product_controller.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';

class EditProductTitleAndDescription extends StatelessWidget {
  const EditProductTitleAndDescription({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return ARoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: controller.title,
              validator:
                  (value) =>
                      AriloValidator.validateEmptyText('Product Title', value),
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                controller: controller.description,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator:
                    (value) => AriloValidator.validateEmptyText(
                      'Product Description',
                      value,
                    ),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
