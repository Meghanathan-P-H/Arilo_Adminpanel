import 'package:arilo_admin/common/widgets/responsive/responsive_design.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/resposive_screens/dashboard_desk.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/resposive_screens/dashboard_mobile.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/resposive_screens/dashboard_tab.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloResponsiveWidget(
      desktop: DesktopLayout(body:DashboardDesk()),
      tablet: TabletLayout(body:DashboardTab()),
      mobile: MobileLayout(body:DashboardMobile()),
    );
  }
}
