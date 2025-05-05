import 'package:arilo_admin/features/products/controller/product_attribute_controller.dart';
import 'package:arilo_admin/features/products/models/product_variation_model.dart';
import 'package:arilo_admin/utils/popups/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariationController extends GetxController {
  // Singleton instance
  static ProductVariationController get instance => Get.find();

  // Observables for loading state and product variations
  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  // Lists to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
  salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
  descriptionControllersList = [];

  // Instance of ProductAttributesController
  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] = TextEditingController(
        text: variation.stock.toString(),
      );
      stockControllersList.add(stockControllers);

      // Price Controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] = TextEditingController(
        text: variation.price.toString(),
      );
      priceControllersList.add(priceControllers);

      // Sale Price Controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers =
          {};
      salePriceControllers[variation] = TextEditingController(
        text: variation.salePrice.toString(),
      );
      salePriceControllersList.add(salePriceControllers);

      // Description Controllers
      Map<ProductVariationModel, TextEditingController> descriptionControllers =
          {};
      descriptionControllers[variation] = TextEditingController(
        text: variation.description,
      );
      descriptionControllersList.add(descriptionControllers);
    }
  }

  void removeVariations(BuildContext context) {
    ADialogs.defaultDialog(
      context: context,
      title: 'Remove Variation',
      confirmText: 'Remove',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
      content: "Are you sure want to remove?",
    );
  }

  void generateVariationsConfirmation(BuildContext context) {
    ADialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      content:
          'Once the variations are created, you cannot add more attributes. '
          'In order to add more variations, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  void generateVariationsFromAttributes() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    if (attributesController.productAttributes.isNotEmpty) {
      final List<List<String>> attributeCombinations = getCombinations(
        attributesController.productAttributes
            .map((attr) => attr.values ?? <String>[])
            .toList(),
      );

      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
          attributesController.productAttributes.map((attr) => attr.name ?? ''),
          combination,
        );

        final ProductVariationModel variation = ProductVariationModel(
          id: UniqueKey().toString(),
          attributeValues: attributeValues,
        );

        variations.add(variation);
      }

      // Create controllers
      // Initialize controller maps for each variation property
      final Map<ProductVariationModel, TextEditingController> stockControllers =
          {};
      final Map<ProductVariationModel, TextEditingController> priceControllers =
          {};
      final Map<ProductVariationModel, TextEditingController>
      salePriceControllers = {};
      final Map<ProductVariationModel, TextEditingController>
      descriptionControllers = {};

      // Create controllers for each variation
      for (final variation in variations) {
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();
      }

      // Add the maps to their respective lists (assuming these lists are declared elsewhere)
      stockControllersList.add(stockControllers);
      priceControllersList.add(priceControllers);
      salePriceControllersList.add(salePriceControllers);
      descriptionControllersList.add(descriptionControllers);
    }
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];

    combine(lists, 0, <String>[], result);

    return result;
  }

  // Helper function to recursively combine attribute values
  void combine(
    List<List<String>> lists,
    int index,
    List<String> current,
    List<List<String>> result,
  ) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    for (final item in lists[index]) {
      final List<String> updated = List.from(current)..add(item);

      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }
}
