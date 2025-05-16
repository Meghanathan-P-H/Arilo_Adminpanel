import 'package:arilo_admin/data/abstract/base_data_table_controller.dart';
import 'package:arilo_admin/data/repositories/banner_repo.dart';
import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends AriloBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  String formatRoute(String route) {
    if (route.isEmpty) return "";

    String formatted = route.substring(1);

    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }
}
