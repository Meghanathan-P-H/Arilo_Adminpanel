import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_attribute.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_stock_pricing.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_titleanddiscription.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_tumbline_img.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_type_widget.dart';
import 'package:arilo_admin/features/products/screens/create_product/widgets/product_variation_widget.dart';
import 'package:arilo_admin/features/shop/controllers/product_controller/product_controller.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImageController());
    return Scaffold(
      // bottomNavigationBar: const ProductBottomNavigationButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [AriloRoute.product, 'Create Product'],
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: AriloDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductTitleAndDescription(),
                        const SizedBox(height: 32),

                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock & Pricing',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),

                              const ProductTypeWidget(),
                              const SizedBox(height: 16),

                              const ProductStockAndPricing(),
                              const SizedBox(height: 32),

                              const ProductAttributes(),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: Column(
                      children: [
                        const ProductThumbnailImage(),
                        const SizedBox(height: 32),
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(height: 16),
                              // ProductAdditionalImages(
                              //   additionalProductImagesURLs:
                              //       controller.additionalProductImagesUrls,
                              //   onTapToAddImages:
                              //       () =>
                              //           controller
                              //               .selectMultipleProductImages(),
                              //   onTapToRemoveImage:
                              //       (index) => controller.removeImage(index),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        
                        // const ProductBrand(),
                        // const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Categories
                        // const ProductCategories(),
                        // const SizedBox(height: 32)

                        // // Product Visibility
                        // const ProductVisibilityWidget(),
                        // const SizedBox(height: 32)
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
