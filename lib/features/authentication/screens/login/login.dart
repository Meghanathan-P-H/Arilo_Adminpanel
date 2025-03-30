import 'package:arilo_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:arilo_admin/features/authentication/screens/login/resposive_mob_desk/login_mob.dart';
import 'package:arilo_admin/features/authentication/screens/login/resposive_mob_desk/login_tab_desk.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AriloSiteTemplate(userLayout: false,desktop:AuthenticationScreen(), mobile: AuthenticationMobileScreen(),);
  }
}