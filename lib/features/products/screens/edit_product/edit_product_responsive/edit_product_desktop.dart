import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_additiona_img.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_bottom_navigation.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_attributes.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_brand.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_categories.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_stock_pricing.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_titleanddiscription.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_tumbnailimg.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_type_widget.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_variation.dart';
import 'package:arilo_admin/features/products/screens/edit_product/widgets/edit_product_visibility.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductDesktopScreen extends StatelessWidget {
  const EditProductDesktopScreen({super.key,required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
  ProductImageController(isEditMode: true, productModel: product), 
  tag: 'createProductImage'
);


    return Scaffold(
      bottomNavigationBar:ProductEditBottomNavigationButtons(product: product,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [AriloRoute.editProduct, 'Edit Product'],
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
                        EditProductTitleAndDescription(product: product,),
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

                              EditProductTypeWidget(product: product),
                              const SizedBox(height: 16),

                              EditProductStockAndPricing(product: product,),
                              const SizedBox(height: 32),

                              EditProductAttributes(product: product,),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        EditProductVariation(product: product,),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  Expanded(
                    child: Column(
                      children: [
                        EditProductThumbnailImage(product: product,),
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
                              EditProductAdditionalImages(
                                additionalProductImagesURLs:
                                    controller.additionalProductImageUrls,
                                onTapToAddImages:
                                    () =>
                                        controller.selectMultipleProductImage(),
                                onTapToRemoveImage:
                                    (index) => controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        EditProductBrand(product: product,),
                        const SizedBox(height: 32),

                        EditProductCategories(product: product,),
                        const SizedBox(height: 32),

                        EditProductVisibilityWidget(product:product),
                        const SizedBox(height: 32)
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
