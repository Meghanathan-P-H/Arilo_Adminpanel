import 'dart:io';
import 'dart:typed_data';
import 'package:arilo_admin/features/media/models/cloud_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing image data.
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

  // Not Mapped
  final dynamic file; // or DropzoneFileInterface

  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Constructor for ImageModel.
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

  // Static function to create an empty user model.
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => _formatDate(createdAt);
  String get updatedAtFormatted => _formatDate(updatedAt);

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Convert to Json to Store in DB
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toIso8601String(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
    };
  }

  /// Convert Firestore Document to Model

Future<void> saveImageDataToFirestore(String url, String folder, String filename) async {
  final imageModel = ImageModel(
    url: url,
    folder: folder,
    filename: filename,
    createdAt: DateTime.now(),
    mediaCategory: 'yourCategory',
  );

  await FirebaseFirestore.instance
      .collection('images')
      .add(imageModel.toJson());
}

Future<void> uploadAndSave(File imageFile) async {
  final url = await uploadImageToCloudinary(imageFile);
  if (url != null) {
    final filename = imageFile.path.split('/').last;
    await saveImageDataToFirestore(url, 'my_folder', filename);
    print('✅ Uploaded & saved to Firestore!');
  } else {
    print('❌ Failed to upload to Cloudinary');
  }
}

}