import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/table/banner_table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/reuse_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileBannersScreen extends StatelessWidget {
  const MobileBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                heading: 'Banners',
                breadcrumbItems: ['Banners'],
              ),
              const SizedBox(height: 20),
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          
                          TextField(
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
                          const SizedBox(height: 12),
                           SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => Get.toNamed(AriloRoute.createBanner),
                              icon: Icon(Icons.add, size: 20),
                              label: Text('Create New Banner'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
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