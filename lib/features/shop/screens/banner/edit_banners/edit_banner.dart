import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/banner/edit_banners/edit_responsive/editbanner_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBanner extends StatelessWidget {
  const EditBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return AriloSiteTemplate(desktop: EditbannerDesktopScreen(banner:banner));
  }
}
