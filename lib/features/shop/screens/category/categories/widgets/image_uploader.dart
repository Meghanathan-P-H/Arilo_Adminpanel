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
    this.buttonPosition = ButtonPosition.bottomRight,
    this.buttonOffset = 8, 
    this.isMemoryImage = false,
    this.fit = BoxFit.cover,
  });

  final bool circular;
  final String image;
  final bool isMemoryImage;
  final double width;
  final double height;
  final Uint8List? memoryImage;
  final IconData icon;
  final ButtonPosition buttonPosition;
  final double buttonOffset;
  final BoxFit fit;
  final VoidCallback? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(circular ? width / 2 : 12),
            child: isMemoryImage
                ? Image.memory(
                    memoryImage!,
                    width: width,
                    height: height,
                    fit: fit,
                  )
                : Image.network(
                    image,
                    width: width,
                    height: height,
                    fit: fit,
                  ),
          ),

          // Positioned Button
          Positioned(
            top: buttonPosition == ButtonPosition.topLeft || 
                 buttonPosition == ButtonPosition.topRight
                ? -buttonOffset
                : null,
            bottom: buttonPosition == ButtonPosition.bottomLeft || 
                    buttonPosition == ButtonPosition.bottomRight
                ? -buttonOffset
                : null,
            left: buttonPosition == ButtonPosition.topLeft || 
                  buttonPosition == ButtonPosition.bottomLeft
                ? -buttonOffset
                : null,
            right: buttonPosition == ButtonPosition.topRight || 
                   buttonPosition == ButtonPosition.bottomRight
                ? -buttonOffset
                : null,
            child: GestureDetector(
              onTap: onIconButtonPressed,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ButtonPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight
}