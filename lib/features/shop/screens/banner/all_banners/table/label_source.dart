import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/controllers/banner_controller/banner_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannerRows extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(AriloRoute.editBanner, arguments: banner),
      onSelectChanged:
          (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          AriloRoundedImage(
            width: 180,
            height: 100,
            padding: 8,
            image: banner.imageUrl,
            imageType: ImageType.network,
            borderRadius: 8,
            backgroundColor: AriloColors.textSecondary,
          ),
        ),

        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell(
          banner.active
              ? const Icon(Iconsax.eye, color: Colors.lightGreen)
              : const Icon(Iconsax.eye_slash),
        ),
        DataCell(
          TableActionButtons(
            onEditPressed:
                () => Get.toNamed(AriloRoute.editBanner, arguments: banner),

            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
