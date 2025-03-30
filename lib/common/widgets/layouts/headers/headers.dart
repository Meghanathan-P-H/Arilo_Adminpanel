import 'package:arilo_admin/common/widgets/images/rounded_image.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AriloHeader extends StatelessWidget implements PreferredSizeWidget {
  const AriloHeader({super.key,this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AppBar(
        leading:
            !AriloDeviceUtils.isDesktopScreen(context)  
                ? IconButton(onPressed: ()=>scaffoldKey?.currentState?.openDrawer(), icon: const Icon(Iconsax.menu))
                : null,
        title:
            AriloDeviceUtils.isDesktopScreen(context)
                ? SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search anything...',
                    ),
                  ),
                )
                : null,

        actions: [
          if (!AriloDeviceUtils.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),

          IconButton(onPressed: () {}, icon: Icon(Iconsax.notification)),
          const SizedBox(width: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AriloRoundedImage(
                width: 40,
                height: 40,
                padding: 2,
                imageType: ImageType.asset,
                image: 'assets/images/defaultuser.png',
              ),
              SizedBox(width: 8),
              if (!AriloDeviceUtils.isMobileScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meghanathan', style: TextStyle(fontSize: 16)),
                    Text(
                      'meghanathan@gmail.com',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AriloDeviceUtils.getAppBarHeight() + 15);
}
