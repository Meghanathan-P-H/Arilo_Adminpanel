import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/screen/widgets/folder_down.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(width: 16),
              MediaFolderDropDown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 32),

          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              AriloRoundedImage(
                width: 90,
                height: 90,
                padding: 8,
                imageType: ImageType.asset,
                image: 'assets/images/shoes.png',
                backgroundColor: AriloColors.bdGrey,
              ),
              AriloRoundedImage(
                width: 90,
                height: 90,
                padding: 8,
                imageType: ImageType.asset,
                image: 'assets/images/shoes.png',
                backgroundColor: AriloColors.bdGrey,
              ),
              AriloRoundedImage(
                width: 90,
                height: 90,
                padding: 8,
                imageType: ImageType.asset,
                image: 'assets/images/shoes.png',
                backgroundColor: AriloColors.bdGrey,
              ),
              AriloRoundedImage(
                width: 90,
                height: 90,
                padding: 8,
                imageType: ImageType.asset,
                image: 'assets/images/shoes.png',
                backgroundColor: AriloColors.bdGrey,
              ),
            ],
          ),

          Padding(padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(onPressed: (){}, label:const Text('Load More'),
                  icon: const Icon(Iconsax.arrow_down),),
                )
              ],
            ),),

        ],
      ),
    );
  }
}
