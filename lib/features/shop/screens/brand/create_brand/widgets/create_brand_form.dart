import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/create_brand_controller.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/widgets/choice_chip.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/Image_uploader.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return ARoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: controller.formKey,
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
              controller: controller.name,
              validator:
                  (value) => AriloValidator.validateEmptyText('Name', value),
              decoration: InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                children: CategoryController.instance.allItems.map(
                  (element) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AriloChoiceChips(
                      text: element.name,
                      selected: controller.selectedCategories.contains(element),
                      onSelected:
                          (value) => controller.toggleSelection(element),
                    ),
                  ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              ()=>ImageUploader(
                width: 80,
                height: 80,
                image: controller.imageUrl.value.isNotEmpty?controller.imageUrl.value:'assets/images/imagedefulticon.png',
                circular: true,
                onIconButtonPressed: () =>controller.pickImage(),
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              ()=> CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value)=>controller.isFeatured.value=value??false,
                child: const Text("Featured"),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>controller.createBrand(),
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
