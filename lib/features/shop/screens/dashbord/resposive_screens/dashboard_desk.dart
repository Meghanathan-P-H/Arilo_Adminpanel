import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/bar_graph.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/card_widget.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/widgets/order_status_graph.dart';
import 'package:flutter/material.dart';
import 'package:arilo_admin/utils/constants/colors.dart';

class DashboardDesk extends StatelessWidget {
  const DashboardDesk({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F5F8),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
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

            // Stats Cards Row
            const Row(
              children: [
                Expanded(
                  child: Row(
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
                      SizedBox(width: 16),
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
                ),
              ],
            ),

            const SizedBox(height: 16),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarGraph(),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: OrderStatusPieChart()
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Second row with a single container
            ARoundedContainer(
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Additional Information'),
                  // Add more content here
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}


