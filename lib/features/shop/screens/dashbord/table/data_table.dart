

import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: 32*1.2,
      columns: const [
      DataColumn2(label: Text('Order ID')),
      DataColumn2(label: Text('Date')),
      DataColumn2(label: Text('Item')),
      DataColumn2(label: Text('Status')),
      DataColumn2(label: Text('Amount')),

    ], source: OrderRows());
  }
}