// import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
// import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
// import 'package:arilo_admin/features/shop/controllers/category_controller/category_controller.dart';
// import 'package:arilo_admin/utils/constants/shimmer_eff.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';

// class ProductCategories extends StatelessWidget {
//   const ProductCategories({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final categoriesController = Get.put(CategoryController());

   
//     if (categoriesController.allItems.isEmpty) {
//       categoriesController.fetchItems();
//     }

//     return ARoundedContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
//           const SizedBox(height:16 ),   
//           Obx(
//             () => categoriesController.isLoding.value
//                 ? const AriloShimmerEffect(width: double.infinity, height: 50)
//                 : MultiSelectDialogField(
//                     buttonText: const Text("Select Categories"),
//                     title: const Text("Categories"),
//                     items: categoriesController.allItems
//                         .map((category) => MultiSelectItem(category, category.name))
//                         .toList(),
//                     listType: MultiSelectListType.CHIP,
//                     onConfirm: (values) {
//                       CreateProductController.instance.selectedCategories.assignAll(values);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
