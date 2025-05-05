import 'package:arilo_admin/features/products/models/product_category_model.dart';
import 'package:arilo_admin/features/products/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection('Products').add(product.toJson());
      return result.id;
    } on FirebaseAuthException catch (e) {
      throw 'Authentication error: ${e.message}';
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createProductCategory(
    ProductCategoryModel productCategory,
  ) async {
    try {
      final result = await _db
          .collection("ProductCategory")
          .add(productCategory.toJson());
      return result.id;
    } on FirebaseAuthException catch (e) {
      throw 'Authentication error: ${e.message}';
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateProductSpecificValue(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      // Delete all data at once from Firebase Firestore
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception("Product not found");
        }

        final productCategoriesSnapshot =
            await _db
                .collection("ProductCategory")
                .where("productId", isEqualTo: product.id)
                .get();
        final productCategories = productCategoriesSnapshot.docs.map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
            for (var productCategory in productCategories) {
                transaction.delete(_db.collection("ProductCategory").doc(productCategory.id));
            }
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw 'FirebaseException ${e.code}';
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw 'PlatformException ${e.code}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
