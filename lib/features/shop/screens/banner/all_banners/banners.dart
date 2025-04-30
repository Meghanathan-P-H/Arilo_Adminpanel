import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/responsive_banner/desktop_banners.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(desktop:DesktopBannersScreen(),);
  }
}
