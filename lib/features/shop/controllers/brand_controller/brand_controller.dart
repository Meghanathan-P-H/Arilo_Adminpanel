import 'package:arilo_admin/data/abstract/base_data_table_controller.dart';
import 'package:arilo_admin/data/repositories/brand_repo.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/features/shop/models/brand_model.dart';
import 'package:get/get.dart';

class BrandController extends AriloBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categroyController = Get.put(CategoryController());

  @override
  Future<List<BrandModel>> fetchItems() async {
    final fetchedBrands = await _brandRepository.getAllBrands();
    final fetchedBrandCategories =
        await _brandRepository.getAllBrandCategories();
    if (categroyController.allItems.isNotEmpty) {
      await categroyController.fetchItems();
    }

    for (var brand in fetchedBrands) {
      List<String> categoryIds =
          fetchedBrandCategories
              .where((brandCategory) => brandCategory.brandId == brand.id)
              .map((brandCategory) => brandCategory.categoryId)
              .toList();

      brand.brandCategories =
          categroyController.allItems
              .where((category) => categoryIds.contains(category.id))
              .toList();
    }
    return fetchedBrands;
  }

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    await _brandRepository.deleteBrand(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (BrandModel b) => b.name.toLowerCase(),
    );
  }
}
