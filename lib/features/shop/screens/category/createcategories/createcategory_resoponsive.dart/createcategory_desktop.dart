import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/createcategoryform.dart';
import 'package:flutter/material.dart';

class CreatecategoryDesktop extends StatelessWidget {
  const CreatecategoryDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Categories',
                breadcrumbItems: ['Categories'],
              ),
              SizedBox(height: 32,),
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
