import 'package:arilo_admin/common/widgets/breadcrumps/widgets/brudcrumb_headingwidget.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AriloBreadCrumbs extends StatelessWidget {
  const AriloBreadCrumbs({super.key, required this.heading, required this.breadcrumbItems,this.returnToPreviousScreen=false});

  final String heading;

  final List<String> breadcrumbItems;

  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAll(AriloRoute.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Dashboard',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),


            for(int i=0;i<breadcrumbItems.length;i++)
              Row(
                children: [
                  const Text('/'),
                   InkWell(
              onTap:i==breadcrumbItems.length-1?null:()=>Get.toNamed(breadcrumbItems[i]),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  i==breadcrumbItems.length-1?breadcrumbItems[i].capitalize.toString():capitalize(breadcrumbItems[i].substring(1)),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),
                ],
              )
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            if(returnToPreviousScreen)IconButton(onPressed: ()=>Get.back(), icon: const Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen)const SizedBox(width: 16,),
            AriloPageHeadingBredCrumb(heading: heading)
          ],
        )
      ],
    );
  }


  String capitalize(String s){
    return s.isEmpty?'':s[0].toUpperCase()+s.substring(1);
  }
}
