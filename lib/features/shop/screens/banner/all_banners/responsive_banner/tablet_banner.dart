import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/table/banner_table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/reuse_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabletBannersScreen extends StatelessWidget {
  const TabletBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Banners',
                breadcrumbItems: ['Banners'],
              ),
              const SizedBox(height: 24),
              
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => Get.toNamed(AriloRoute.createBanner),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24, 
                                vertical: 12
                              ),
                            ),
                            child: Text('Create New Banner'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search banners...',
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
                    SizedBox(
                      height: 500,
                      child: Obx(() {
                        if (controller.isLoding.value) {
                          return Center(
                            child: ReuseAnimation(),
                          );
                        }
                        return BannerTable();
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