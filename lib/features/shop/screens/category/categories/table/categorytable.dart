import 'package:arilo_admin/features/shop/screens/category/categories/table/categoryrows.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/table/peginated_datatable.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class Categorytable extends StatelessWidget {
  const Categorytable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, 
      child: AriloPaginatedDataTable(
        minWidth: 700,
        tableHeight: 450, 
        columns: const [
          DataColumn2(label: Text('Category'), size: ColumnSize.L),
          DataColumn2(label: Text('Parent Category'), size: ColumnSize.M),
          DataColumn2(label: Text('Featured'), size: ColumnSize.S),
          DataColumn2(label: Text('Data'), size: ColumnSize.M),
          DataColumn2(label: Text('Actions'), size: ColumnSize.S),
        ],
        source: CategoryRows(),
      ),
    );
  }
}
