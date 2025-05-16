import 'package:arilo_admin/features/products/controller/create_product_controller.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () => controller.productType.value == ProductType.single
          ? Form(
              key: controller.stockPriceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.45,
                    child: TextFormField(
                      controller: controller.stock,
                      decoration: const InputDecoration(
                        labelText: 'Stock',
                        hintText: 'Add Stock, only numbers are allowed',
                      ),
                      validator: (value) =>
                          AriloValidator.validateEmptyText('Stock', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),  
                  ), 
                  const SizedBox(height: 16),

                  Row(children: [
                    Expanded(child:   TextFormField(
                      controller: controller.price,
                      decoration: InputDecoration(labelText: 'Price',hintText: 'Price with up-to 2 decimals'),
                      validator: (value)=>AriloValidator.validateEmptyText('Price', value),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters:<TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^(a+),2^(d{0,2}$)'),) ],
                    )),
                     const SizedBox(height: 16),
                    Expanded(child:   TextFormField(
                      controller: controller.salePrice,
                      decoration: InputDecoration(labelText: 'Discouted Price',hintText: 'Price with up-to 2 decimals'),
                      validator: (value)=>AriloValidator.validateEmptyText('Discout Price', value),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters:<TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^(a+),2^(d{0,2}$)'),) ],
                    )),

                  ],)
                ],
              ),
            )
          : SizedBox.shrink(), 
    );
  }
}