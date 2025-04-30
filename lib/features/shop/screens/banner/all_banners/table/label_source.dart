import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannerRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        const DataCell(
          AriloRoundedImage(
            width: 180,
            height: 100,
            padding: 8,
            image: '',
            imageType: ImageType.network,
            borderRadius: 8,
            backgroundColor: AriloColors.textSecondary,
          ),
        ),

        const DataCell(Text('Shop')),
        const DataCell(Icon(Iconsax.eye, color: AriloColors.textLight)),
        DataCell(
          TableActionButtons(
            onEditPressed:
                () => Get.toNamed(
                  AriloRoute.editBanner,
                  arguments: BannerModel(
                    imageUrl:'',
                    targetScreen:'',
                    active:false,
                  ),
                ),

                onDeletePressed: (){},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
