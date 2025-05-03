import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/Image_uploader.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';

class Editcategoryform extends StatelessWidget {
  const Editcategoryform({super.key});

  @override
  Widget build(BuildContext context) {
     return ARoundedContainer(
      width: 400,
      padding: const EdgeInsets.all(24),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Update Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),

            ImageUploader(
              width: 120,
              height: 120,
              image: 'assets/images/imagedefulticon.png',
              circular: false,
              onIconButtonPressed: () {},
            ),

            const SizedBox(height: 8),
            const Text(
              'Select Image Icon',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            TextFormField(
              validator: (value) =>
                  AriloValidator.validateEmptyText('name', value),
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
                Checkbox(value: false, onChanged: (value) {}),
                const Text('Active'),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000000), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Update',
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
