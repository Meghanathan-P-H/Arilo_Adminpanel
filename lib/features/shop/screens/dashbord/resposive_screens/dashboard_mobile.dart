import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/bar_graph.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/card_widget.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/order_status_graph.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

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
              const SizedBox(height: 32),

              ADashboardCard(
                title: 'Sales Total',
                subTitle: '\$356',
                stats: 25,
              ),
              const SizedBox(height: 16),
              ADashboardCard(
                title: 'Average Order Value',
                subTitle: '\$26',
                stats: 15,
              ),
              const SizedBox(height: 16),
              ADashboardCard(
                title: 'Total Order',
                subTitle: '26',
                stats: 44,
              ),
              const SizedBox(height: 16),
              ADashboardCard(
                title: 'Sales Total',
                subTitle: '56,3588',
                stats: 2,
              ),
              const SizedBox(height: 16),


              const BarGraph(),

              const SizedBox(height: 24),

              const ARoundedContainer(
                padding: EdgeInsets.all(16),
                child: Text('Additional Content'),
              ),

              const SizedBox(height: 24),

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
