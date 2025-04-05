import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/features/authentication/screens/login/frogot_success.dart';
import 'package:arilo_admin/utils/popups/full_screen_popups.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      FullScreenLoader.show(
        'Processing your request...',
        'assets/logos/loding.json',
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
       FullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepo.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // Remove Loader
       FullScreenLoader.stopLoading();

      // Show Success Screen
      ALoaders.showSuccessSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password',
      );

      // Redirect
      Get.to(() => ForgotSuccess(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
     FullScreenLoader.stopLoading();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


  Future<void> resendPasswordResetEmail(String email) async {
    try {
        FullScreenLoader.show(
        'Processing your request...',
        'assets/logos/loding.json',
      );
        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
        // Send Email to Reset Password
       await AuthenticationRepo.instance.sendPasswordResetEmail(
        email,
      );

        // Remove Loader
        FullScreenLoader.stopLoading();

        // Show Success Screen
        ALoaders.showSuccessSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
}


}
