import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReuseAnimation extends StatelessWidget {
  const ReuseAnimation({
    super.key,
    this.height = 300,
    this.width = 300,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            'assets/logos/datas_loading.json',
            height: height,
            width: width,
          ),
          const SizedBox(height: 16),
          const Text('Loading your data...'),
        ],
      ),
    );
  }
}
