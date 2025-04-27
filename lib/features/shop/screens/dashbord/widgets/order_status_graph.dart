import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/dashboard_controller/dashbord_controller.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return ARoundedContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orders Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          // Pie Chart
          Obx(() {
            if (controller.orderStatusData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections:
                          controller.orderStatusData.entries.map((entry) {
                            final status = entry.key;
                            final count = entry.value;
                            final percentage =
                                (count /
                                        DashboardController.orders.length *
                                        100)
                                    .round();

                            return PieChartSectionData(
                              value: count.toDouble(),
                              color: _getStatusColor(status),
                              title: '$percentage%',
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {},
                        enabled: true,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Orders')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows:
                      controller.orderStatusData.entries.map((entry) {
                        final OrderStatus status = entry.key;
                        final int count = entry.value;
                        final double totalAmount =
                            controller.totalAmouts[status] ?? 0;

                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(status),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(_getStatusName(status))),
                                ],
                              ),
                            ),
                            DataCell(Text(count.toString())),
                            DataCell(
                              Text('\$${totalAmount.toStringAsFixed(2)}'),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.orange;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
