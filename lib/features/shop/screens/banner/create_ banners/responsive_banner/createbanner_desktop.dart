import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/screens/banner/create_%20banners/widgets/create_banner_form.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';

class CreatebannerDesktopScreen extends StatelessWidget {
  const CreatebannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(24),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AriloBreadCrumbs(returnToPreviousScreen: true,heading: 'Create Banner', breadcrumbItems: [AriloRoute.categories,'Create Brand']),
            SizedBox(height: 32,),

           CreateBannerForm()
          ],
        ),),
      ));
  }
}