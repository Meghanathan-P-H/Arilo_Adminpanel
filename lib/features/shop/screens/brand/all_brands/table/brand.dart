import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              const AriloRoundedImage(
                width: 50,
                height: 50,
                padding: 8,
                imageType: ImageType.asset,
                borderRadius: 8,
                backgroundColor: AriloColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                'Adidas',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  Get.context!,
                ).textTheme.bodyLarge!.apply(color: AriloColors.textSecondary),
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          AriloDeviceUtils.isMobileScreen(Get.context!) ? 0 : 4,
                    ),
                    child: const Chip(
                      label: Text('Shoes'),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          AriloDeviceUtils.isMobileScreen(Get.context!) ? 0 : 4,
                    ),
                    child: const Chip(
                      label: Text('TrackSuits'),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          AriloDeviceUtils.isMobileScreen(Get.context!) ? 0 : 4,
                    ),
                    child: const Chip(
                      label: Text('Joggers'),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const DataCell(Icon(Iconsax.heart5, color: AriloColors.bdGrey)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TableActionButtons(
            onEditPressed:
                () => Get.toNamed(AriloRoute.editBrand, arguments: ''),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
