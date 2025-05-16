import 'package:arilo_admin/features/shop/controllers/banner_controller/banner_controller.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/table/label_source.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerTable extends StatelessWidget {
  const BannerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return AriloPaginatedDataTable(
        minWidth: 700,
        tableHeight: 900,
        dataRowHeight: 110,
        columns: const [
          DataColumn2(label: Text('Banner')),
          DataColumn2(label: Text('Redirect Screen')),
          DataColumn2(label: Text('Active')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: BannerRows(),
      );
    });
  }
}
