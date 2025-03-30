import 'package:arilo_admin/utils/constants/size.dart';
import 'package:flutter/material.dart';

class AriloResponsiveWidget extends StatelessWidget {
  const AriloResponsiveWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= AriloSizee.desktopScreen) {
          return desktop;
        } else if (constraints.maxWidth < AriloSizee.desktopScreen &&
            constraints.maxWidth >= AriloSizee.tableScreen) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
