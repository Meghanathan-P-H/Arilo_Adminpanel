import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/widgets/choice_chip.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/Image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(24),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Create New Brand',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AriloChoiceChips(
                  text: 'Shoes',
                  selected: true,
                  onSelected: (value) {},
                ),
                AriloChoiceChips(
                  text: 'Track Suits',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            ImageUploader(
              width: 80,
              height: 80,
              image: 'assets/images/imagedefulticon.png',
              onIconButtonPressed: () {},
            ),
            const SizedBox(height: 16),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text("Featured"),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
