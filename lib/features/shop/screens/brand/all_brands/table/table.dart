import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
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
    final controller = Get.put(BrandController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      final lgTable = controller.filteredItems.any(
        (element) => element.brandCategories!.length > 2,
      );

      return AriloPaginatedDataTable(
        minWidth: 700,
        tableHeight: lgTable ? 96 * 11.5 : 760,
        dataRowHeight: lgTable ? 96 : 64,
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
    });
  }
}
