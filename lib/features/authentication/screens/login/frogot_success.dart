import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/authentication/controller/forgotpswd_contoller.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotSuccess extends StatelessWidget {
  const ForgotSuccess({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    Widget desktopContent = _buildDesktopContent(context, email ?? '');
    Widget tabletContent = _buildTabletContent(context, email ?? '');
    Widget mobileContent = _buildMobileContent(context, email ?? '');

    return AriloSiteTemplate(
      desktop: desktopContent,
      tablet: tabletContent,
      mobile: mobileContent,
      userLayout: false,
    );
  }

  Widget _buildDesktopContent(BuildContext context, String email) {
    return _buildContentWithSize(
      context,
      email,
      imageSize: 300.0,
      contentWidth: 800.0,
      contentPadding: 64.0,
      textPadding: 80.0,
      buttonWidth: 380.0,
      spacing: 24.0,
    );
  }

  Widget _buildTabletContent(BuildContext context, String email) {
    return _buildContentWithSize(
      context,
      email,
      imageSize: 250.0,
      contentWidth: 600.0,
      contentPadding: 48.0,
      textPadding: 60.0,
      buttonWidth: 320.0,
      spacing: 20.0,
    );
  }

  Widget _buildMobileContent(BuildContext context, String email) {
    final size = MediaQuery.of(context).size;
    return _buildContentWithSize(
      context,
      email,
      imageSize: 200.0,
      contentWidth: size.width,
      contentPadding: 24.0,
      textPadding: 0.0,
      buttonWidth: size.width * 0.8,
      spacing: 16.0,
    );
  }

  Widget _buildContentWithSize(
    BuildContext context,
    String email, {
    required double imageSize,
    required double contentWidth,
    required double contentPadding,
    required double textPadding,
    required double buttonWidth,
    required double spacing,
  }) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: contentWidth),
              padding: EdgeInsets.symmetric(horizontal: contentPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Get.offAllNamed(AriloRoute.login),
                      icon: const Icon(CupertinoIcons.clear),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_read_rounded,
                      size: imageSize * 0.6,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    'Password Reset Email Sent',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing / 2),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: textPadding),
                    child: Text(
                      'Your Account Security is Our Priority! We\'ve Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: spacing * 1.5),
                  SizedBox(
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed(AriloRoute.login),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                  SizedBox(height: spacing / 2),
                  TextButton(
                    onPressed: () {
                      ForgetPasswordController.instance
                          .resendPasswordResetEmail(email);
                    },
                    child: const Text('Resend Email'),
                  ),
                  SizedBox(height: spacing),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
