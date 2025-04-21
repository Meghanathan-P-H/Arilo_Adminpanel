// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:arilo_admin/features/media/controls/media_controller.dart';
import 'package:arilo_admin/features/media/models/image_model.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel> uploadImageFileInStorage({
    required dynamic file,
    required String path,
    required String imageName,
  }) async {
    try {
      final Reference ref = _storage.ref('$path/$imageName');
      if (file is html.File) {
        await ref.putBlob(file);
      } else if (file.runtimeType.toString() == 'DropzoneFileWeb') {
        // Extract bytes from DropzoneFileWebbb
        final bytes = await MediaController.instance.dropzoneViewController
            .getFileData(file);
        final blob = html.Blob([bytes]);
        await ref.putBlob(blob);
      } else {
        throw 'Unsupported file type: ${file.runtimeType}';
      }

      final String downloadURL = await ref.getDownloadURL();

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

  Future<List<ImageModel>> fetchImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
  ) async {
    try {
     

      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Images')
              .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
              .orderBy('createdAt', descending: true)
              .limit(loadCount)
              .get();

      // If zero results,is this 
      if (querySnapshot.docs.isEmpty) {
        print(
          "No images found. Checking if any images exist without filtering...",
        );
        final allImages =
            await FirebaseFirestore.instance
                .collection('Images')
                .limit(5)
                .get();

        if (allImages.docs.isNotEmpty) {
          print("Sample document data: ${allImages.docs.first.data()}");
        }
      }

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw e.message ?? 'Firebase error occurred';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<List<ImageModel>> loadMoreImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
    DateTime lastFetchedDate,
  ) async {
    try {
      
      String lastFetchedDateString = lastFetchedDate.toIso8601String();

      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Images')
              .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
              .orderBy('createdAt', descending: true)
              .startAfter([lastFetchedDateString])
              .limit(loadCount)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw e.message ?? 'Firebase error occurred';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred: $e';
    }
  }
}
