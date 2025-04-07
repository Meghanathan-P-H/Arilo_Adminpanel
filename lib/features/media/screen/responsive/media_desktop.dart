import 'package:arilo_admin/common/widgets/breadcrumps/breadcrumb_with_heading.dart';
import 'package:arilo_admin/features/media/screen/widgets/media_content.dart';
import 'package:arilo_admin/features/media/screen/widgets/media_uploader.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(24),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AriloBreadCrumbs(heading: 'Media',breadcrumbItems: ['Media Screen'],),

              SizedBox(
                width: 130*1.5 ,
                child: ElevatedButton.icon(onPressed: (){},
                icon: Icon(Iconsax.cloud_add), label:Text('Upload Image')),
              )
            ],
          ),
          SizedBox( height: 32,),
          MediaUploader(),

          MediaContent()
        ],
      ),),),
    );
  }
}
