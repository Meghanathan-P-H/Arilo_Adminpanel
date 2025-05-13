import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;
  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged:
          (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              AriloRoundedImage(
                width: 50,
                height: 50,
                padding: 8,
                image: brand.image,
                imageType: ImageType.network,
                borderRadius: 8,
                backgroundColor: AriloColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                brand.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  Get.context!,
                ).textTheme.bodyLarge!.apply(color: AriloColors.textPrimary),
              ),
            ],
          ),
        ),

        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 4,
                direction:
                    AriloDeviceUtils.isMobileScreen(Get.context!)
                        ? Axis.vertical
                        : Axis.horizontal,
                children:
                    brand.brandCategories != null
                        ? brand.brandCategories!
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      AriloDeviceUtils.isMobileScreen(
                                            Get.context!,
                                          )
                                          ? 0
                                          : 4,
                                ),
                                child: Chip(
                                  label: Text(e.name),
                                  padding: const EdgeInsets.all(4),
                                ),
                              ),
                            )
                            .toList()
                        : [const SizedBox()],
              ),
            ),
          ),
        ),
        DataCell(brand.isFeatured?const Icon(Iconsax.heart5,color: Colors.red,):const Icon(Iconsax.heart)),
        DataCell(Text(brand.createdAt!=null?brand.formattedDate:'')),
        DataCell(
          TableActionButtons(
            onEditPressed:
                () => Get.toNamed(AriloRoute.editBrand, arguments:brand),
            onDeletePressed: ()=>controller.confirmAndDeleteItem(brand),
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
  int get selectedRowCount => controller.selectedRows.where((selected)=>selected).length;
}
