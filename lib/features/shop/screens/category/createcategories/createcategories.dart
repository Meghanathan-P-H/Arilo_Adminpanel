import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/category/createcategories/createcategory_resoponsive.dart/createcategory_desktop.dart';
import 'package:flutter/material.dart';

class Createcategories extends StatelessWidget {
  const Createcategories({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(desktop: CreatecategoryDesktop());
  }
}
