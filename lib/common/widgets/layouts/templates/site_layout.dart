import 'package:arilo_admin/common/widgets/responsive/responsive_design.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/material.dart';

class AriloSiteTemplate extends StatelessWidget {
  const AriloSiteTemplate({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.userLayout = true,
  });

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;
  final bool userLayout;

  @override
  Widget build(BuildContext context) {
    return AriloResponsiveWidget(
      desktop:userLayout? DesktopLayout(body: desktop):desktop?? Container(),
      tablet: userLayout? TabletLayout(body: tablet??desktop):tablet??desktop??Container(),
      mobile: userLayout? MobileLayout(body: mobile??desktop):mobile??desktop??Container(),
    );
  }
}
