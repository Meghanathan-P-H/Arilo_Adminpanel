import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:arilo_admin/features/shop/screens/banner/edit_banners/widgets/edit_banner_form.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';

class EditbannerDesktopScreen extends StatelessWidget {
  const EditbannerDesktopScreen({super.key,required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AriloBreadCrumbs(
                returnToPreviousScreen: true,
                heading: 'Edit Banner',
                breadcrumbItems: [AriloRoute.categories, 'Edit Banner'],
              ),
              SizedBox(height: 32),

              EditBannerForm(banner: banner,),
            ],
          ),
        ),
      ),
    );
  }
}
