import 'package:arilo_admin/data/abstract/base_data_table_controller.dart';
import 'package:arilo_admin/data/repositories/product_repo.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:get/get.dart';

class ProductController extends AriloBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||item.brand!.name.toLowerCase().contains(query.toLowerCase())||
        item.price.toString().contains(query);
  }
  

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productRepository.deleteProduct(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.title.toLowerCase(),
    );
  }


  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.price,
    );
  }


  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.stock,
    );
  }

  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.soldQuantity,
    );
  }

  String getProductPrice(ProductModel product) {
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        
        
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }



  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return '${percentage.toStringAsFixed(0)}%';
}



String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.stock).toString();
}


String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.soldQuantity).toString();
}


String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
}
}
