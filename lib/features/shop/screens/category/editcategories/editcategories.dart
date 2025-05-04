import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/shop/screens/category/editcategories/editcategory_response/editcategory_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return AriloSiteTemplate(desktop: EditcategoryDesktop(category: category,));
  }
}
