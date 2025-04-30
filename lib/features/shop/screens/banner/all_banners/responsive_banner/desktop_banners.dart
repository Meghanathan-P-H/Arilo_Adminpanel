import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/table/banner_table.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/table/brand_table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesktopBannersScreen extends StatelessWidget {
  const DesktopBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AriloBreadCrumbs(heading: 'Banners', breadcrumbItems: ['Banners']),
              SizedBox(height: 16),

              ARoundedContainer(
                child: Column(
                  children: [
                    BannerTableHeader(
                      textButton: 'Create New Banner',
                      onPressed: () => Get.toNamed(AriloRoute.createBanner),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 600, 
                      child: BannerTable()
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
