import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/responsive_design/categories_desktop.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/responsive_design/categories_mobile.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AriloSiteTemplate(desktop: CategoriesDesktop(),mobile: CategoriesMobile(),tablet: CategoriesMobile(),);
  }
}
