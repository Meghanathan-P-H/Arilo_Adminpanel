import 'package:arilo_admin/common/widgets/layouts/sidebar/menu/menu.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AriloSideBar extends StatelessWidget {
  const AriloSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: AriloColors.primary,
          border: Border(
            right: BorderSide(color: AriloColors.bdGrey, width: 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AssetImage(assetName) i want set image logo of application here
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MENU',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                  ),
                  // AriloMenu(route: '', icon: Iconsax.status, itemName: 'Dashboard'),
                  // AriloMenu(route: '', icon: Iconsax.image, itemName: 'Media'),
                  // AriloMenu(route: '', icon: Iconsax.picture_frame, itemName: 'Banners'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
