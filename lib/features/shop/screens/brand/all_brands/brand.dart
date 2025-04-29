import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/responsive_screens/brand_desktop.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/responsive_screens/brand_mobile.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/responsive_screens/brand_tablet.dart';
import 'package:flutter/material.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AriloSiteTemplate(desktop: BrandDesktopScreen(),tablet: BrandTabletScreen(),mobile: BrandMobileScreen(),);
  }
}
