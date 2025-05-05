import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/products/screens/all_products/responsive_screens/product_desktop.dart';
import 'package:arilo_admin/features/products/screens/all_products/responsive_screens/product_mobile.dart';
import 'package:arilo_admin/features/products/screens/all_products/responsive_screens/product_tablet.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(desktop: ProductDesktopScreen(),mobile: ProductMobileScreen(),tablet: ProductTabletScreen(),);
  }
}
