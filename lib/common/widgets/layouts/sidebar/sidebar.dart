import 'package:arilo_admin/common/widgets/layouts/sidebar/menu/logout.dart';
import 'package:arilo_admin/common/widgets/layouts/sidebar/menu/menu.dart';
import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AriloSideBar extends StatelessWidget {
  const AriloSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.put(AuthenticationRepo());
    return Drawer(
      shape: const BeveledRectangleBorder(),
      width: 250, 
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
             Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 40,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'ARILO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ), SizedBox(height: 16), 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      'MENU',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  // Sidebar menu items
                  AriloMenu(route: AriloRoute.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                  AriloMenu(route: AriloRoute.media, icon: Iconsax.image, itemName: 'Media'),
                  AriloMenu(route: AriloRoute.categories, icon: Iconsax.category_2, itemName: 'Category'),
                  AriloMenu(route: AriloRoute.brand, icon: Iconsax.dcube, itemName: 'Brands'),
                  AriloMenu(route: AriloRoute.banner, icon: Iconsax.picture_frame, itemName: 'Banner'),
                  AriloMenu(route: AriloRoute.product, icon: Iconsax.bag_2, itemName: 'Product'),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      'OTHER  ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  LogoutButton(authRepo: authRepo),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}