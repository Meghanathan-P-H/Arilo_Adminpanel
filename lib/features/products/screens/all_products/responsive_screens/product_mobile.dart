import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/screens/all_products/table/product_table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/reuse_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductMobileScreen extends StatelessWidget {
  const ProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),
              const SizedBox(height: 20),
              
              Obx(() {
                if (controller.isLoding.value) {
                  return Center(
                    child: ReuseAnimation(),
                  );
                }

                return ARoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              onChanged: (query) => controller.searchQuery(query),
                              decoration: InputDecoration(
                                hintText: 'Search products...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, 
                                  vertical: 12
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => Get.toNamed(AriloRoute.createProduct),
                                icon: Icon(Icons.add, size: 20),
                                label: Text('Create New Product'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 400, 
                        child: ProductTable()
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}