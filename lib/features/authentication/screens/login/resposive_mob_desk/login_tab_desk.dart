import 'package:arilo_admin/features/authentication/controller/forgotpswd_contoller.dart';
import 'package:arilo_admin/features/authentication/controller/login_controller.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLogin = true;
  final double containerWidth = 769;
  final double containerHeight = 497;

  void toggleScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
             width: containerWidth,
          height: containerHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                     width: containerWidth * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/frontimage.png'
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                
                Expanded(
                  child: SizedBox(
                    width: containerWidth * 0.5,
                    height: containerHeight,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.2, 0.0),
                              end: const Offset(0.0, 0.0),
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: isLogin 
                        ? _buildLoginForm() 
                        : _buildForgotPasswordForm(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
     final controller = Get.put(LoginController());
    return Padding(
      key: const ValueKey('login'),
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'ADMIN LOGIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: 0.2, end: 0),
            Text(
              'Hello there, login and start managing your application',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.2, end: 0),
            const SizedBox(height: 40),
            TextFormField(
              controller: controller.email,
              validator: AriloValidator.validateEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 20),
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                 validator:
                          (value) =>
                              AriloValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                          onPressed:
                              () =>
                                  controller.hidePassword.value =
                                      !controller.hidePassword.value,
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                          ),
                        ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged:
                              (value) => controller.rememberMe.value = value!,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: toggleScreen,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPassword(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    final forgotController = Get.put(ForgetPasswordController());
    return Padding(
      key: const ValueKey('forgot'),
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: forgotController.forgetPasswordFormKey, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: toggleScreen,
              icon: Icon(Icons.arrow_back),
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 20),
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.2, end: 0),
            const SizedBox(height: 16),
            Text(
              'Enter email associated with your account and we\'ll send and email with intructions to reset your password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.2, end: 0),
            const SizedBox(height: 40),
            TextFormField(
              controller: forgotController.email,
              validator: AriloValidator.validateEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  forgotController.sendPasswordResetEmail();
        
                  //     Get.toNamed(
                  //       AriloRoute
                  //           .forgotPassword, 
                  //       parameters: {'email': email},
                  //     );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms).scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
          ],
        ),
      ),
    );
  }
}