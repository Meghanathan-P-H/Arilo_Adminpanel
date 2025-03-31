import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AriloRouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(());//sidebarContoller

    if (previousRoute != null) {
      for (var routeName in AriloRoute.sidebarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          // sidebarController.activeItem.value == routeName;
        }
      }
    }
  }
}
