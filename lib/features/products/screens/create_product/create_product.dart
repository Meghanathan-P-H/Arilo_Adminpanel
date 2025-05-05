import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_desktop.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_mobile.dart';
import 'package:arilo_admin/features/products/screens/create_product/create_product_responsive/create_product_tablet.dart';
import 'package:flutter/material.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(desktop: CreateProductDesktopScreen(),tablet: CreateProductTabletScreen(),mobile: CreateProductMobileScreen(),);
  }
}