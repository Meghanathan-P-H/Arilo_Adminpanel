import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/categorytable.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/widgets/categorytableheader.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesDesktop extends StatelessWidget {
  const CategoriesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Categories',
                breadcrumbItems: ['Categories'],
              ),
              const SizedBox(height: 32),

              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryTableHeader(
                      textButton: 'Create New Category',
                      onPressed: () => Get.toNamed(AriloRoute.createCategory),searchContorller: controller.searchTextController,searchOnChanged:(query)=> controller.searchQuery(query),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 500,
                      child: Obx(() {
                        if (controller.isLoding.value) {
                          return BlackCircularProgressIndicator();
                        }
                        return const Categorytable();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
