import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/dashbord_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: AriloColors.secondary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('5 Items')),
        DataCell(ARoundedContainer(
          radius: 10,
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
          backgroundColor: AriloHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
          child: Text(order.status.name.capitalize.toString(),style: TextStyle(color: AriloHelperFunctions.getOrderStatusColor(order.status),),
        ))),
        DataCell(Text('\$${order.totalAmount}'))

      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
