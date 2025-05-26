import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/products/screens/all_products/table/product_table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/reuse_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTabletScreen extends StatelessWidget {
  const ProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),
              const SizedBox(height: 24),
              
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
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => Get.toNamed(AriloRoute.createProduct),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24, 
                                  vertical: 12
                                ),
                              ),
                               child: Text('Create New Product'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: TextField(
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 500, 
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