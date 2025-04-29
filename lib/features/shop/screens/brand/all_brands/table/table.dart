import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/brand.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(
          label: const Text('Brand'),
          fixedWidth:
              AriloDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
        ),
        const DataColumn2(label: Text('Categories')),
        DataColumn2(
          label: const Text('Featured'),
          fixedWidth:
              AriloDeviceUtils.isMobileScreen(Get.context!) ? null : 100,
        ),
        DataColumn2(
          label: const Text('Date'),
          fixedWidth:
              AriloDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
        ),
        DataColumn2(
          label: const Text('Action'),
          fixedWidth:
              AriloDeviceUtils.isMobileScreen(Get.context!) ? null : 100,
        ),
      ],
      source: BrandRows(),
    );
  }
}
