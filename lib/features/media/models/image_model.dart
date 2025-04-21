import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';



class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

 
  final dynamic file; 

  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

 
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    required this.filename,
    this.sizeBytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
    this.mediaCategory = '',
  });

  // Static function to create an empty user model
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => _formatDate(createdAt);
  String get updatedAtFormatted => _formatDate(updatedAt);

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);

  }

factory ImageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  if (document.data() != null) {
    final data = document.data()!;

    DateTime? createdAt;
    if (data['createdAt'] != null) {
      if (data['createdAt'] is Timestamp) {
        createdAt = data['createdAt'].toDate();
      } else if (data['createdAt'] is String) {
        try {
          createdAt = DateTime.parse(data['createdAt']);
        } catch (e) {
          print("Error parsing date: ${data['createdAt']}");
        }
      }
    }

    DateTime? updatedAt;
    if (data['updatedAt'] != null) {
      if (data['updatedAt'] is Timestamp) {
        updatedAt = data['updatedAt'].toDate();
      } else if (data['updatedAt'] is String) {
        try {
          updatedAt = DateTime.parse(data['updatedAt']);
        } catch (e) {
          print("Error parsing date: ${data['updatedAt']}");
        }
      }
    }

    return ImageModel(
      id: document.id,
      url: data['url'] ?? '',
      folder: data['folder'] ?? '',
      filename: data['filename'] ?? '',
      sizeBytes: data['sizeBytes'] ?? 0,
      fullPath: data['fullPath'] ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      contentType: data['contentType'] ?? '',
      mediaCategory: data['mediaCategory'] ?? '',
    );
  } else {
    return ImageModel.empty();
  }
}


/// Convert to Json to Store in DB
Map<String, dynamic> toJson() {
  return {
    'url': url,
    'folder': folder,
    'sizeBytes': sizeBytes,
    'filename': filename,
    'fullPath': fullPath,
    'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    'contentType': contentType,
    'mediaCategory': mediaCategory,
  };
}



factory ImageModel.fromFirebaseMetadata(
    FullMetadata metadata,
    String folder,
    String filename,
    String downloadUrl,
  ) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType,
    );
  }

}