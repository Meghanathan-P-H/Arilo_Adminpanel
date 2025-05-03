import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/categoryrows.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categorytable extends StatelessWidget {
  const Categorytable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return SizedBox(
      height: 500,
      child: Obx(() {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());

        return AriloPaginatedDataTable(
          sortAscending: controller.sortAcending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          tableHeight: 450,
          columns: [
            DataColumn2(
              label: const Text('Category'),
              size: ColumnSize.L,
              onSort:
                  (columnIndex, ascending) =>
                      controller.sortByName(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Featured'), size: ColumnSize.S),
            const DataColumn2(label: Text('Data'), size: ColumnSize.M),
            const DataColumn2(label: Text('Actions'), size: ColumnSize.S),
          ],
          source: CategoryRows(),
        );
      }),
    );
  }
}
