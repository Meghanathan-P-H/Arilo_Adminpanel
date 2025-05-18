import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/edit_product_controller.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
import 'package:arilo_admin/utils/constants/shimmer_eff.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductCategories extends StatelessWidget {
  const EditProductCategories({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoryController());
    final editProductController = EditProductController.instance;

    if (editProductController.selectedCategories.isEmpty) {
      editProductController.loadSelectedCategories(product.id);
    }

    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          Obx(
            () =>
                categoriesController.isLoding.value || editProductController.selectedCategoriesLoader.value
                ? const AriloShimmerEffect(
                    width: double.infinity,
                    height: 50,
                  )
                : MultiSelectDialogField(
                    buttonText: const Text("Select Categories"),
                    title: const Text("Categories"),
                    initialValue: editProductController.selectedCategories,
                    items: categoriesController.allItems
                        .map(
                          (category) => MultiSelectItem(category, category.name),
                        )
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                      onConfirm:
                          (values) => EditProductController
                              .instance
                              .selectedCategories
                              .assignAll(values),
                    ),
          ),
        ],
      ),
    );
  }
}
