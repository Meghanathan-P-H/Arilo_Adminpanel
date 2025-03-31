import 'package:arilo_admin/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

 
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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
}