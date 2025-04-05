import 'package:arilo_admin/data/repositories/user_repo.dart';
import 'package:arilo_admin/features/authentication/models/user_model.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      ALoaders.showErrorSnackBar(
        title: 'Something went wrong.',
        message: e.toString(),
      );
      return UserModel.empty();
    }
  }
}
