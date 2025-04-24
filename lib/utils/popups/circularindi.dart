import 'package:flutter/material.dart';

class BlackCircularProgressIndicator extends StatelessWidget {
  final String? content;

  const BlackCircularProgressIndicator({super.key,this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 0, 0, 0),
                strokeWidth: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content??'',
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
