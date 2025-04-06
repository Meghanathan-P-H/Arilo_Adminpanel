import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/bar_graph.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/card_widget.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/order_status_graph.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AriloColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                      title: 'Sales Total',
                      subTitle: '\$356',
                      stats: 25,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ADashboardCard(
                      title: 'Average Order Value',
                      subTitle: '\$26',
                      stats: 15,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                      title: 'Total Order',
                      subTitle: '26',
                      stats: 44,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ADashboardCard(
                      title: 'Sales Total',
                      subTitle: '56,3588',
                      stats: 2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ✅ Fixed BarGraph container
              SizedBox(
                height: 400,
                child: const BarGraph(),
              ),

              const SizedBox(height: 24),

              const ARoundedContainer(
                padding: EdgeInsets.all(16),
                child: Text('Additional Content'),
              ),

              const SizedBox(height: 24),

              // ✅ Fixed OrderStatusPieChart container
              SizedBox(
                height: 500,
                child: const OrderStatusPieChart(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
