import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductVariationModel {
  final String id;
  String sku;
  RxString image;
  String description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  }) : image = image.obs;


  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

 
  toJson() {
    return {
      'Id': id,
      'Image': image.value,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Stock': stock,
      'SoldQuantity': soldQuantity,
      'AttributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
  final data = document;
  if (data.isEmpty) return ProductVariationModel.empty();
  return ProductVariationModel(
    id: data['Id'] ?? '',
    price: double.parse((data['Price'] ?? 0.0).toString()),
    sku: data['SKU'] ?? '',
    description: data['Description'] ?? '',
    stock: data['Stock'] ?? 0,
    soldQuantity: data['SoldQuantity'] ?? 0,
    salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
    image: data['Image'] ?? '',
    attributeValues: Map<String, String>.from(data['AttributeValues']),
  );
}

}
