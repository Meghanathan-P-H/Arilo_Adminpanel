import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AriloPageHeadingBredCrumb extends StatelessWidget {
  const AriloPageHeadingBredCrumb({
    super.key,
    required this.heading,
    this.rightSideWidget    
  });

  final String heading;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
           style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AriloColors.textPrimary,
                ),
        ),
        rightSideWidget ?? const SizedBox(),
      ],
    );
  }
}
