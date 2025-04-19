// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image data to Firestore
  Future<ImageModel> uploadImageFileInStorage({
    required dynamic file,
    required String path,
    required String imageName,
  }) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');
      if (file is html.File) {
        await ref.putBlob(file);
      } else if (file.runtimeType.toString() == 'DropzoneFileWeb') {
        // Extract bytes from DropzoneFileWeb
        final bytes = await MediaController.instance.dropzoneViewController
            .getFileData(file);
        final blob = html.Blob([bytes]);
        await ref.putBlob(blob);
      } else {
        throw 'Unsupported file type: ${file.runtimeType}';
      }

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
        metadata,
        path,
        imageName,
        downloadURL,
      );
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw e.message ?? 'Firebase error occurred';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw e.message ?? 'Firebase error occurred';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred: $e';
    }
  }
}
