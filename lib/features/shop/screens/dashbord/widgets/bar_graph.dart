import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/dashbord_controller.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarGraph extends StatelessWidget {
  const BarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return ARoundedContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Weekly Sales'),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: Obx(
              () => BarChart(
                BarChartData(
                  titlesData: _buildTitlesData(),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    horizontalInterval: 200,
                  ),
                  barGroups:
                      controller.weeklySales
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value,
                                  width: 22,
                                  color: const Color(0xFFA877FD),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                  groupsSpace: 16,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.white,
                    ),
                    touchCallback:
                        AriloDeviceUtils.isDesktopScreen(context)
                            ? (barTouchEvent, barTouchResponse) {}
                            : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(color: AriloColors.textPrimary, fontSize: 12),
            );
          },
          reservedSize: 40,
          interval: 200,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt();
            return Text(
              index >= 0 && index < days.length ? days[index] : '',
              style: TextStyle(color: AriloColors.textPrimary, fontSize: 12),
            );
          },
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
