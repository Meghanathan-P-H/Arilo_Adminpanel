import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/banner/create_%20banners/responsive_banner/createbanner_desktop.dart';
import 'package:arilo_admin/features/shop/screens/banner/create_%20banners/responsive_banner/createbanner_mobile.dart';
import 'package:arilo_admin/features/shop/screens/banner/create_%20banners/responsive_banner/createbanner_tablet.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(desktop: CreatebannerDesktopScreen(),tablet: CreatebannerTabletScreen(),mobile: CreatebannerMobileScreen(),);
  }
}
