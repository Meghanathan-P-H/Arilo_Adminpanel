import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;
  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value)=>controller.selectedRows[index]=value ?? false,
      cells: [
        DataCell(
          SizedBox(
            width: 250,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AriloRoundedImage(
                  width: 50,
                  height: 50,
                  padding: 8,
                  image: category.image,
                  imageType: ImageType.network,
                  borderRadius: 8,
                  backgroundColor: AriloColors.iconSearchCl,
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Text(
                    category.name,
                    style: Theme.of(
                      Get.context!,
                    ).textTheme.bodyLarge!.apply(color: AriloColors.secondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),

        DataCell(
          category.isFeatured
              ? const Icon(Iconsax.heart5, color: AriloColors.primary)
              : const Icon(Iconsax.heart),
        ),
        DataCell(Text(category.createdAt==null?'':category.createdFormattedDate)),
        DataCell(
          TableActionButtons(
            onEditPressed:
                () =>
                    Get.toNamed(AriloRoute.editCategory, arguments: category ),
            onDeletePressed: () => controller.confirmAndDeleteCaterogy(category),
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
  int get selectedRowCount => 0;
}
