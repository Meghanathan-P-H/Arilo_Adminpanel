import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/controllers/banner_controller/edit_banner_controller.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/helpers/app_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);
    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(24),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Update Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),

            Column(
              children: [
                Obx(
                  () => AriloRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: AriloColors.textLight,
                    image:
                        controller.imageURL.value.isNotEmpty
                            ? controller.imageURL.value
                            : 'assets/images/imagedefulticon.png',
                    imageType:
                        controller.imageURL.value.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => controller.pickImage(),
                  child: const Text('Select Image'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Make Your Banner Active or InActive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged:
                    (value) => controller.isActive.value = value ?? false,
                child: const Text('Active'),
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => DropdownButton<String>(
                value: controller.targetScreen.value,
                onChanged:
                    (String? newValue) =>
                        controller.targetScreen.value = newValue!,
                items: AppScreens.allAppScreenItems
                    .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16 * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=>controller.updateBanner(banner), child: Text('Update')),
            ),
          ],
        ),
      ),
    );
  }
}
