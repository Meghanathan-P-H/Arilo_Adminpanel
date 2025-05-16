import 'package:arilo_admin/features/shop/models/banner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection("Banners").get();
      final result =
          snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();

      return result;
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


  Future<String>createBanner(BannerModel banner)async{
    try{
        final result=await _db.collection("Banners").add(banner.toJson());
        return result.id;
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

  Future<void>updateBanner(BannerModel banner)async{
    try{
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
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

    Future<void> deleteBanner(String bannerId) async {
    try {
      await _db.collection("Banners").doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
