import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/screens/brand/edit_brand/widgets/edit_brand_form.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(24),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AriloBreadCrumbs(returnToPreviousScreen: true,heading: 'Update Brand', breadcrumbItems: [AriloRoute.categories,'Update Brand']),
            SizedBox(height: 32,),

            EditBrandForm()
          ],
        ),),
      ),
    );
  }
}
