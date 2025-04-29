import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/create_brand_responsive/create_brand_desktop.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/create_brand_responsive/create_brand_mobile.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/create_brand_responsive/create_brand_tablet.dart';
import 'package:flutter/material.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AriloSiteTemplate(desktop: CreateBrandDesktopScreen(),tablet: CreateBrandTabletScreen(),mobile: CreateBrandMobileScreen(),);
  }
}