import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/data/repositories/user_repo.dart';
import 'package:arilo_admin/features/authentication/models/user_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  // Future<void> emailAndPasswordSignIn() async {
  //   final isLoading = true.obs;
  //   try {
  //     Get.dialog(
  //       const Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false,
  //     );

  //     if (!loginFormKey.currentState!.validate()) {
  //       return;
  //     }

  //     await AuthenticationRepo.instance.loginWithEmailAndPassword(
  //       email.text.trim(),
  //       password.text.trim(),
  //     );

  //     final user =await ;

  //     if(user.role != AppRole.admin){
  //      await AuthenticationRepo.instance.logout();
       
  //     }
  //   } catch (e) {
  //   } finally {}
  // }

  Future<void> registerAdmin() async {
    final isLoading = true.obs;

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final userCredential = await AuthenticationRepo.instance
          .registerWithEmailAndPassword(
            'meghanathanph1@gmail.com',
            'admin@123',
          );

      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: userCredential.user?.uid ?? '',
          email: 'meghanathanph1@gmail.com',
          firstName: 'Megha',
          lastName: 'Admin',
          role: AppRole.admin,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      AuthenticationRepo.instance.screenRedirect();
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(
        'Registration Failed',
        e.message ?? 'Unknown error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Failed to register admin: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
