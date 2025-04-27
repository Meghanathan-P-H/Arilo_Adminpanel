import 'package:arilo_admin/data/network/network_manager.dart';
import 'package:arilo_admin/features/authentication/controller/user_controller.dart';
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/controls/mediarepo.dart';
import 'package:arilo_admin/features/shop/controllers/dashboard_controller/dashbord_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => MediaController(), fenix: true);
    Get.lazyPut(() => MediaRepository(), fenix: true);
    //UserContoller
  }
}
