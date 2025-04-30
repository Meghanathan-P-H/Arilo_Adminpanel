import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(24),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Create New Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),

            Column(
              children: [
                GestureDetector(
                  child: const AriloRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: AriloColors.textLight,
                    imageType: ImageType.asset,
                    image: 'assets/images/imagedefulticon.png',
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(onPressed: (){}, child: const Text('Select Image'))
              ],
            ),
              const SizedBox(height: 16),
              Text('Make Your Banner Active or InActive',style: Theme.of(context).textTheme.bodyMedium,),
              CheckboxMenuButton(value: true, onChanged: (value){}, child: const Text('Active')),
              const SizedBox(height:16,),

              DropdownButton<String>(value: 'search', onChanged: (String? newValue){},items: const [
                DropdownMenuItem<String>(value: 'home',child: Text('Home')),
                DropdownMenuItem<String>(value: 'search',child: Text('Search')),
              ],),
              const SizedBox(height: 16*2,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text('Create')),
              )
          ],
        ),
      ),
    );
  }
}
