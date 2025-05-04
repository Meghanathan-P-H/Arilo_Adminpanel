import 'package:arilo_admin/utils/popups/circularindi.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AriloBaseController<T> extends GetxController {
  RxBool isLoding = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAcending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<List<T>> fetchItems();

  bool containsSearchQuery(T item, String query);

  Future<void> deleteItem(T item);

  Future<void> fetchData() async {
    try {
      isLoding.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }

      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

      isLoding.value = false;
    } catch (e) {
      isLoding.value = false;
      ALoaders.showErrorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoding.value = false;
    }
  }

  void searchQuery(String query) {
    print(query);
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );
  }

  void sortByProperty(
    int sortColumnIndex,
    bool ascending,
    Function(T) property,
  ) {
    sortAcending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  void updateItemFromList(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;

    filteredItems.refresh();
  }

  confirmAndDeleteCaterogy(T category) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure want to delete this Items?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(category),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text('Ok'),
        ),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text('Cancel'),
        ),
      ),
    );
  }

  deleteOnConfirm(T item) async {
    try {
      Navigator.of(Get.context!).pop();
      BlackCircularProgressIndicator();

      await deleteItem(item);

      removeItemFromLists(item);

      ALoaders.showSuccessSnackBar(
        title: "Item Deleted",
        message: 'Your Item has been Deleted',
      );
    } catch (e) {
      Navigator.of(Get.context!).pop();
      ALoaders.showErrorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

    update();
  }
}
