import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AriloAnimationLoaderWidget extends StatelessWidget {
  final String animation;
  final String text;
  final double height;
  final double width;

  const AriloAnimationLoaderWidget({
    super.key,
    required this.animation,
    required this.text,
    this.height = 200,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            animation,
            height: height,
            width: width,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
