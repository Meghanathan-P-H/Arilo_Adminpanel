import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/create_category_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/Image_uploader.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());

    return ARoundedContainer(
      width: 400,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Create New Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),

            Obx(
              () => ImageUploader(
                width: 120,
                height: 120,
                image:
                    createController.imageURL.value.isNotEmpty
                        ? createController.imageURL.value
                        : 'assets/images/imagedefulticon.png',
                circular: false,
                onIconButtonPressed:
                    () =>
                        createController.pickImage(), //image type if we can add
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'Select Image Icon',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            TextFormField(
              controller: createController.name,
              validator:
                  (value) => AriloValidator.validateEmptyText('name', value),
              decoration: const InputDecoration(
                hintText: 'Category Name',
                filled: true,
                fillColor: Color(0xFFF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: createController.isFeatured.value,
                    onChanged:
                        (value) =>
                            createController.isFeatured.value = value ?? false,
                  ),
                ),
                const Text('Active'),
              ],
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => createController.createCategory(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
