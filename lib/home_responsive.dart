import 'package:arilo_admin/common/widgets/responsive/responsive_design.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:arilo_admin/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/material.dart';
import 'package:arilo_admin/home.dart'; // this contains MyWidget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloResponsiveWidget(
      desktop: DesktopLayout(body: MyWidget()),
      tablet: TabletLayout(body: MyWidget()),
      mobile: MobileLayout(body: MyWidget()),
    );
  }
}
