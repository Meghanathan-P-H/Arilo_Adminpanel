import 'dart:io';
import 'package:arilo_admin/features/shop/models/brand_category_model.dart';
import 'package:arilo_admin/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message ?? 'Firebase error occurred';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message ?? 'Platform error occurred';
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }

  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final brandCategoryQuery = await _db.collection('BrandCategory').get();
      final brandCategories =
          brandCategoryQuery.docs
              .map((doc) => BrandCategoryModel.fromSnapshot(doc))
              .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message ?? 'Firebase error occurred';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message ?? 'Platform error occurred';
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }

  Future<List<BrandCategoryModel>> getCategoriesofSpecificBrand(
    String brandId,
  ) async {
    try {
      final brandCategoryQuery =
          await _db
              .collection('BrandCategory')
              .where('brandId', isEqualTo: brandId)
              .get();
      final brandCategories =
          brandCategoryQuery.docs
              .map((doc) => BrandCategoryModel.fromSnapshot(doc))
              .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message ?? 'Firebase error occurred';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message ?? 'Platform error occurred';
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }

  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection("Brands").add(brand.toJson());
      return result.id;
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

  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      final result = await _db
          .collection("BrandCategory")
          .add(brandCategory.toJson());
      return result.id;
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

  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection("Brands").doc(brand.id).update(brand.toJson());
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


  Future<void> deleteBrand(BrandModel brand)async{
    try{
      await _db.runTransaction((transaction)async{
        
        final brandRef=_db.collection("Brands").doc(brand.id);
        final brandSnap= await transaction.get(brandRef);

        if(!brandSnap.exists){
          throw Exception("Brand not found");
        }
        final brandCategoriesSnapshot=await _db.collection("BrandCategory").where("brandId",isEqualTo: brand.id).get();
        final brandCategories=brandCategoriesSnapshot.docs.map((e)=>BrandCategoryModel.fromSnapshot(e));

        if(brandCategories.isNotEmpty){
          for(var brandCategory in brandCategories){
            transaction.delete(_db.collection("BrandCategory").doc(brandCategory.id));
          }
        }
        transaction.delete(brandRef);
        
      });
    }on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void>deleteBrandCategory(String brandCategoryId)async{

    try{
      await _db.collection("BrandCategory").doc(brandCategoryId).delete();
    }on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
