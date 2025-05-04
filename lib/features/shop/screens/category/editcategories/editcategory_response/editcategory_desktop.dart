import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/editcategoryform.dart';
import 'package:flutter/material.dart';

class EditcategoryDesktop extends StatelessWidget {
  const EditcategoryDesktop({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding:   EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Update Category',
                breadcrumbItems: ['Update Category'],
              ),
              SizedBox(height: 32,),
              Editcategoryform(category: category,)
          ],
        ),),
      ),
    );

  }
}
