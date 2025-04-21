import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageUploader extends StatelessWidget {
  const ImageUploader({
    super.key,
    required this.image,
    this.onIconButtonPressed,
    this.memoryImage,
    this.width = 100,
    this.height = 100,
    this.circular = false,
    this.icon = Icons.edit,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
    this.isMemoryImage = false,
  });

  final bool circular;
  final String image;
  final bool isMemoryImage;
  final double width;
  final double height;
  final Uint8List? memoryImage;
  final IconData icon;
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final VoidCallback? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(circular ? width / 2 : 12),
          child: isMemoryImage
              ? Image.memory(
                  memoryImage!,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                )
              : Image.network(
                  image,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                ),
        ),
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: GestureDetector(
            onTap: onIconButtonPressed,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black54,
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
