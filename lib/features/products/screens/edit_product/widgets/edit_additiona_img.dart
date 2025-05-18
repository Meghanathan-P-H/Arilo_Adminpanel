import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductAdditionalImages extends StatelessWidget {
  final RxList<String> additionalProductImagesURLs;
  final VoidCallback onTapToAddImages;
  final Function(int index) onTapToRemoveImage;

  const EditProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    required this.onTapToAddImages,
    required this.onTapToRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final canAddMore = additionalProductImagesURLs.length < 3;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (additionalProductImagesURLs.isEmpty)
              GestureDetector(
                onTap: onTapToAddImages,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Additional Product Images',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            if (additionalProductImagesURLs.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: additionalProductImagesURLs.length >= 3 ? 0 : 1,
                    ),

                    ...additionalProductImagesURLs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final imageUrl = entry.value;

                      return Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => onTapToRemoveImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    if (canAddMore)
                      GestureDetector(
                        onTap: onTapToAddImages,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(
                            child: Icon(Icons.add, color: Colors.grey),
                          ),
                        ),
                      ),

                    SizedBox(
                      width: additionalProductImagesURLs.length >= 3 ? 0 : 1,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Maximum 3 images (${additionalProductImagesURLs.length}/3)',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
