import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/products/controller/edit_product_controller.dart';
import 'package:arilo_admin/features/products/screens/edit_product/edit_product_responsive/edit_product_desktop.dart';
import 'package:arilo_admin/features/products/screens/edit_product/edit_product_responsive/edit_product_mobile.dart';
import 'package:arilo_admin/features/products/screens/edit_product/edit_product_responsive/edit_product_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductData(product);
    return AriloSiteTemplate(desktop: EditProductDesktopScreen(product: product,),mobile: EditProductMobileScreen(product: product),tablet: EditProductTabletScreen(product: product),);
  }
}
