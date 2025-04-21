import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
  @override
  @override
DataRow? getRow(int index) {
  return DataRow2(
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
                imageType: ImageType.network,
                borderRadius: 8,
                backgroundColor: AriloColors.iconSearchCl,
              ),
              SizedBox(width: 16),
              Flexible( 
                child: Text(
                  'Name',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: AriloColors.secondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
     
      DataCell(Text('Parent')),
      DataCell(Icon(Iconsax.heart5, color: AriloColors.iconSearchCl)),
      DataCell(Text(DateTime.now().toString())),
      DataCell(
        TableActionButtons(
          onEditPressed: () => Get.toNamed(AriloRoute.editCategory, arguments: 'category'),
          onDeletePressed: () {
            
          },
        ),
      ),
    ],
  );
}

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
