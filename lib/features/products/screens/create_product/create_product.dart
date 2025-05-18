import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_desktop.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_mobile.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_tablet.dart';
import 'package:arilo_admin/features/shop/controllers/product_img_controller/product_img_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
     final createProductController = Get.put(CreateProductController());
    
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createProductController.resetValues();
    
      Get.find<ProductImageController>(tag: 'createProductImage').resetValues();
    });
    return AriloSiteTemplate(desktop: CreateProductDesktopScreen(),tablet: CreateProductTabletScreen(),mobile: CreateProductMobileScreen(),);
  }
}