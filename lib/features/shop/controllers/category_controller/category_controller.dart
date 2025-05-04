import 'package:arilo_admin/data/abstract/base_data_table_controller.dart';
import 'package:arilo_admin/data/repositories/category_repo.dart';
import 'package:arilo_admin/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends AriloBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepo = Get.put(CategoryRepository());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepo.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return _categoryRepo.getAllCategories();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (CategoryModel category) => category.name.toLowerCase(),
    );
  }
}
