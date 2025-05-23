import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/features/authentication/screens/login/frogot_success.dart';
import 'package:arilo_admin/utils/popups/full_screen_popups.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  
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

      
      if (!forgetPasswordFormKey.currentState!.validate()) {
       FullScreenLoader.stopLoading();
        return;
      }

      
      await AuthenticationRepo.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      
       FullScreenLoader.stopLoading();

      
      ALoaders.showSuccessSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password',
      );

      
      Get.to(() => ForgotSuccess(email: email.text.trim()));
    } catch (e) {
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
        
        final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
       await AuthenticationRepo.instance.sendPasswordResetEmail(
        email,
      );

        
        FullScreenLoader.stopLoading();

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
