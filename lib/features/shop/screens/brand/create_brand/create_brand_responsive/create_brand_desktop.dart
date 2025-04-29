import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/widgets/create_brand_form.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';

class CreateBrandDesktopScreen extends StatelessWidget {  
  const CreateBrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(24),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AriloBreadCrumbs(returnToPreviousScreen: true,heading: 'Create Brand', breadcrumbItems: [AriloRoute.categories,'Create Brand']),
            SizedBox(height: 32,),

            CreateBrandForm()
          ],
        ),),
      ),
    );
  }
}
