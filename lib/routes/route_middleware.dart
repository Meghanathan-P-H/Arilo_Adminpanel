import 'package:arilo_admin/data/repositories/authentication_repo.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AriloRouteMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepo.instance.isAuthenticated
        ? null
        : RouteSettings(name: AriloRoute.login);
  }
}
