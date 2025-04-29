import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/brand_header.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/table/table.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandMobileScreen extends StatelessWidget {
  const BrandMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ARoundedContainer(
                child: Column(
                  children: [
                    BrandTableHeader(
                      textButton: 'Create',
                      onPressed: () => Get.toNamed(AriloRoute.createBrand),
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(
                      height: 400, 
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
