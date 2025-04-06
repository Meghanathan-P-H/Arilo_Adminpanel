import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/common/widgets/containers/section_header.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ADashboardCard extends StatelessWidget {
  const ADashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.stats,
    this.icon = Icons.arrow_upward,
    this.color = Colors.green,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final int stats;
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Heading
          ASectionHeading(
            title: title,
            textColor: AriloColors.textSecondary,
          ),
          const SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              
              /// Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Indicator
                  SizedBox(
                    child: Row(
                       mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: color, size: 16),
                        Text(
                          "$stats%",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .apply(color: color),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Compared to Dec 2023',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
