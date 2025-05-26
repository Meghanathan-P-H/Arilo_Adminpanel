import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/category_widget.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_additional_imgage.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_attribute.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_bottomsheet.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_brand.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_stock_pricing.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_titleanddiscription.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_tumbline_img.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_type_widget.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_variation_widget.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_visibility.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductImageController(isEditMode: false), 
      tag: 'createProductImage'
    );

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [AriloRoute.product, 'Create Product'],
              ),
              const SizedBox(height: 28),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductTitleAndDescription(),
                        const SizedBox(height: 28),
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock & Pricing',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),

                              const ProductTypeWidget(),
                              const SizedBox(height: 16),

                              const ProductStockAndPricing(),
                              const SizedBox(height: 28),

                              const ProductAttributes(),
                              const SizedBox(height: 28),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        const ProductVariations(),
                        const SizedBox(height: 28),
                        const ProductCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const ProductThumbnailImage(),
                        const SizedBox(height: 28),
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),
                              ProductAdditionalImages(
                                additionalProductImagesURLs: controller.additionalProductImageUrls,
                                onTapToAddImages: () => controller.selectMultipleProductImage(),
                                onTapToRemoveImage: (index) => controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        const ProductBrand(),
                        const SizedBox(height: 28),
                        const ProductVisibilityWidget(),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}