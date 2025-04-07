import 'package:arilo_admin/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32,)
        ],
      ),
    );
  }
}
