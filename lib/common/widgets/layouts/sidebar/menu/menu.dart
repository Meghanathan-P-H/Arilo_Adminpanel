// import 'package:arilo_admin/common/widgets/layouts/sidebar/sidebar_controller.dart';
// import 'package:arilo_admin/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AriloMenu extends StatelessWidget {
//   const AriloMenu({
//     super.key,
//     required this.route,
//     required,
//     required this.icon,
//     required this.itemName,
//   });

//   final String route;
//   final IconData icon;
//   final String itemName;

//   @override
//   Widget build(BuildContext context) {
//     final menuController = Get.put(SidebarController());

//     return InkWell(
//       onTap: () => menuController.menuOnTap(route),
//       onHover:
//           (hovering) =>
//               hovering
//                   ? menuController.changeHoverItem(route)
//                   : menuController.changeHoverItem(''),
//       child: Obx(
//         () => Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: Container(
//             decoration: BoxDecoration(
//               color:
//                   menuController.isHovering(route) ||
//                           menuController.isActive(route)
//                       ? AriloColors.iconPrimary
//                       : Colors.transparent,
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 24,
//                     top: 16,
//                     bottom: 16,
//                     right: 6,
//                   ),
//                   child:
//                       menuController.isActive(route)
//                           ? Icon(icon, color: Colors.white)
//                           : Icon(
//                             icon,
//                             size: 22,
//                             color:
//                                 menuController.isHovering(route)
//                                     ? AriloColors.iconSecondary
//                                     : AriloColors.iconPrimary,
//                           ),
//                 ),
//                 if(menuController.isHovering(route)||menuController.isActive(route))
//                 Flexible(
//                   child: Text(
//                     itemName,
//                     style: Theme.of(
//                       context,
//                     ).textTheme.bodyMedium!.apply(color: AriloColors.primary),
//                   ),
//                 )
//                 else 
//                  Flexible(
//                   child: Text(
//                     itemName,
//                     style: Theme.of(
//                       context,
//                     ).textTheme.bodyMedium!.apply(color: AriloColors.secondary),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
