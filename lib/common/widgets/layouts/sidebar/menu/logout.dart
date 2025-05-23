import 'package:arilo_admin/common/widgets/layouts/sidebar/sidebar_controller.dart';
import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class LogoutButton extends StatelessWidget {
  final AuthenticationRepo authRepo;

  const LogoutButton({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      onHover:
          (hovering) => Get.find<SidebarController>().changeHoverItem(
            hovering ? 'logout' : '',
          ),
      child: Obx(() {
        final isHovered = Get.find<SidebarController>().isHovering('logout');

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              color: isHovered ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 16,
                    bottom: 16,
                    right: 6,
                  ),
                  child: Icon(
                    Iconsax.logout,
                    size: 22,
                    color: isHovered ? Colors.white : AriloColors.iconPrimary,
                  ),
                ),
                Flexible(
                  child: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: isHovered ? Colors.white : AriloColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Confirm Logout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
                      'assets/logos/logout.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
            const SizedBox(height: 5),
            const Text('Are you sure you want to logout?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await authRepo.logout();
              } catch (e) {
                Get.snackbar('Error', 'Failed to logout: $e');
              }
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
}
