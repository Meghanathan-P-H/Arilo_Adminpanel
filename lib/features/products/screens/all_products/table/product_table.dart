import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/screens/all_products/table/product_rows.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return AriloPaginatedDataTable(
        minWidth: 1000,
        sortAscending: controller.sortAcending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(label: const Text('Product'),
          fixedWidth: !AriloDeviceUtils.isDesktopScreen(context)?300:400,
          onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),),
          DataColumn2(label: const Text('Stock'),
          onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending),),
          DataColumn2(label: const Text('Sold'),
          onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending),),
          // DataColumn2(label: const Text('Brand')),
          DataColumn2(label: const Text('Price'),
          onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending),),
           DataColumn2(label: const Text('Date')),
            DataColumn2(label: const Text('Action'),fixedWidth: 100),

        ],
        source: ProductsRows(),
      );
    });
  }
}
