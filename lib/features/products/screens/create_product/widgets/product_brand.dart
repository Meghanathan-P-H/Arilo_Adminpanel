import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/features/shop/controllers/brand_controller/brand_controller.dart';
import 'package:arilo_admin/utils/constants/shimmer_eff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    final brandController = Get.put(BrandController());

    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          Obx(
            () =>
                brandController.isLoding.value
                    ? const AriloShimmerEffect(
                      width: double.infinity,
                      height: 50,
                    )
                    : TypeAheadField(
                      builder: (context, ctr, focusNode) {
                        return TextFormField(
                          focusNode: focusNode,
                          controller: controller.brandTextField = ctr,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Select Brand',
                            suffixIcon: Icon(Iconsax.box),
                          ),
                        );
                      },
                      suggestionsCallback: (pattern) {
                        return brandController.allItems
                            .where((brand) => brand.name.contains(pattern))
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(title: Text(suggestion.name));
                      },
                      onSelected: (suggestion) {
                        controller.selectedBrand.value = suggestion;
                        controller.brandTextField.text = suggestion.name;
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
