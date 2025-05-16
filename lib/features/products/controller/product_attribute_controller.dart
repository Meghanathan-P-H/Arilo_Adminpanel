import 'package:arilo_admin/features/products/controller/produt_variation_controller.dart';
import 'package:arilo_admin/features/products/models/product_attribute_model.dart';
import 'package:arilo_admin/utils/popups/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  void addNewAttribute() {
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }
    productAttributes.add(
      ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList(),
      ),
    );

    attributeName.text = '';
    attributes.text = '';
  }

  void removeAttribute(int index, BuildContext context) {
    ADialogs.defaultDialog(
      context: context,
      title: 'Removal Confirmation',
      confirmText: 'Remove',
      onConfirm: () {
        // Navigator.of(context).pop();
        productAttributes.removeAt(index);

        ProductVariationController.instance.productVariations.value = [];
      },
      content: 'Removing this data will delete all related data Are you Sure?',
    );
  }

  void resetProductAttributes() {
    productAttributes.clear();
  }
}
