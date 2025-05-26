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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductMobileScreen extends StatelessWidget {
  const EditProductMobileScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductImageController(isEditMode: true, productModel: product),
      tag: 'createProductImage',
    );
    return Scaffold(
      bottomNavigationBar: ProductEditBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [AriloRoute.editProduct, 'Edit Product'],
              ),
              const SizedBox(height: 24),
              EditProductTitleAndDescription(product: product),
              const SizedBox(height: 24),
              EditProductThumbnailImage(product: product),
              const SizedBox(height: 24),
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Product Images',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    EditProductAdditionalImages(
                      additionalProductImagesURLs:
                          controller.additionalProductImageUrls,
                      onTapToAddImages:
                          () => controller.selectMultipleProductImage(),
                      onTapToRemoveImage:
                          (index) => controller.removeImage(index),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stock & Pricing',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),

                    EditProductTypeWidget(product: product),
                    const SizedBox(height: 16),

                    EditProductStockAndPricing(product: product),
                    const SizedBox(height: 24),

                    EditProductAttributes(product: product),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              EditProductVariation(product: product),
              const SizedBox(height: 24),
              EditProductBrand(product: product),
              const SizedBox(height: 24),
              EditProductCategories(product: product),
              const SizedBox(height: 24),
              EditProductVisibilityWidget(product: product),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
