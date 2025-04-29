import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/brand_header.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandTabletScreen extends StatelessWidget {
  const BrandTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AriloBreadCrumbs(
                heading: 'Brands',
                breadcrumbItems: ['Brands'],
              ),
              const SizedBox(height: 16),
              ARoundedContainer(
                child: Column(
                  children: [
                    BrandTableHeader(
                      textButton: 'Create New Brand',
                      onPressed: () => Get.toNamed(AriloRoute.createBrand),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 500, 
                      child: BrandTable(),
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
