import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/brand_header.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/popups/reuse_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandDesktopScreen extends StatelessWidget {
  const BrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AriloBreadCrumbs(heading: 'Brands', breadcrumbItems: ['Brands']),
              SizedBox(height: 16),

              ARoundedContainer(
                child: Column(
                  children: [
                    BrandTableHeader(
                      textButton: 'Create New Brand',
                      onPressed: () => Get.toNamed(AriloRoute.createBrand),
                      searchOnChanged: (query)=>controller.searchQuery(query),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 600,
                      child: Obx(() {
                        if (controller.isLoding.value) {
                          return const ReuseAnimation();
                        }
                        return BrandTable();
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
