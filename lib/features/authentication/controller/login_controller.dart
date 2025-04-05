import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/data/repositories/user_repo.dart';
import 'package:arilo_admin/features/authentication/controller/user_controller.dart';
import 'package:arilo_admin/features/authentication/models/user_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/popups/full_screen_popups.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
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

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';

    super.onInit();
  }

  Future<void> emailAndPassword() async {
    try {
      FullScreenLoader.show('Logging you in...', 'assets/logos/loding.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      await AuthenticationRepo.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final user = await UserController.instance.fetchUserDetails();
      FullScreenLoader.stopLoading();

      if (user.role != AppRole.admin) {
        await AuthenticationRepo.instance.logout();
        ALoaders.showErrorSnackBar(
          title: 'Not Authorized',
          message:
              'You are not authorized or do not have access. Contact Admin',
        );
      } else {
        AuthenticationRepo.instance.screenRedirect();
      }
    } catch (e) {
       FullScreenLoader.stopLoading();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> registerAdmin() async {
    try {
      FullScreenLoader.show(
        'Registering Admin Account',
        'assets/logos/loding.json',
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepo.instance.registerWithEmailAndPassword(
        'dadud3002@gmail.com',
        'Admin@123',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepo.instance.authUser!.uid,
          firstName: 'Megha',
          lastName: 'Admin',
          email: 'dadud3002@gmail.com',
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      FullScreenLoader.stopLoading();

      AuthenticationRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
