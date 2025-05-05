import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/screens/all_products/table/product_table.dart';
import 'package:arilo_admin/features/products/screens/all_products/widgets/product_table_header.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/animation_loder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),
              const SizedBox(height: 32),
              Obx(() {
                if (controller.isLoding.value) {
                  return const AriloAnimationLoaderWidget(
                    animation: '',
                    text: '',
                  );
                }

                return ARoundedContainer(child: Column(
                  children: [
                    ProductTableHeader(
                      textButton: 'Create New Banner',
                      onPressed: () => Get.toNamed(AriloRoute.createProduct),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 600, 
                      child: ProductTable(),
                    ),
                  ],
                ),);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
