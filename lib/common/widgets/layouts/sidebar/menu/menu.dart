import 'package:arilo_admin/common/widgets/layouts/sidebar/sidebar_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AriloMenu extends StatelessWidget {
  const AriloMenu({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());

    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => 
          hovering
              ? menuController.changeHoverItem(route)
              : menuController.changeHoverItem(''),
      child: Obx(
        () {
          final isActiveOrHovered = menuController.isHovering(route) || menuController.isActive(route);
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: isActiveOrHovered ? Colors.black : Colors.transparent,
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
                      icon,
                      size: 22,
                      color: isActiveOrHovered
                          ? Colors.white
                          : AriloColors.iconPrimary,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: isActiveOrHovered
                            ? Colors.white
                            : AriloColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}