import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/brand/edit_brand/edit_brand_responsive/edit_brand_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return AriloSiteTemplate(desktop: EditBrandDesktopScreen(brand:brand));
  }
}
