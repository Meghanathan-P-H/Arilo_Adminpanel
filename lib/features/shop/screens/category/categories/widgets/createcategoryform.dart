import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/Image_uploader.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(24),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Create New Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 32),
            
            TextFormField(validator: (value)=>AriloValidator.validateEmptyText('name', value),decoration: const InputDecoration(
              labelText: "Category Name",
              prefixIcon: Icon(Iconsax.category )
            ),),
            SizedBox(height: 16),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: "Parent Category",
                labelText: 'Parent Category',
                prefixIcon: Icon(Iconsax.bezier),
              ),
              onChanged: (newValue) {},
              items: [
                DropdownMenuItem(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text('Item.Name')],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            ImageUploader(
              width: 80,
              height: 80,
              image: 'assets/images/imagedefulticon.png',
              circular: true,
              onIconButtonPressed: () {},
              left: 0,
              top: 0,
            ),

            const SizedBox(height: 16,),

            CheckboxMenuButton(value: true, onChanged: (value){},child: Text('Featured'),),
             const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){}, child: const Text('Create')),
            )
             
          ],
        ),
      ),
    );
  }
}
