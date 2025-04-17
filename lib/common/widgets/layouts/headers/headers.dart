import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/authentication/controller/user_controller.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:arilo_admin/utils/constants/shimmer_eff.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AriloHeader extends StatelessWidget implements PreferredSizeWidget {
  const AriloHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final isDesktop = AriloDeviceUtils.isDesktopScreen(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFECECEC), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading:
            isDesktop
                ? null
                : IconButton(
                  onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                  icon: const Icon(Iconsax.menu),
                ),
        title:
            isDesktop
                ? SizedBox(
                  width: 400,
                  height: 44, // Reduced height
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      prefixIcon: Icon(Iconsax.search_normal, size: 20),
                      hintText: 'Search anything...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),style: TextStyle(fontSize: 14),
                  ),
                )
                : null,
                 centerTitle: false,
  titleSpacing: isDesktop ? 0 : null,
        actions: [
          if (isDesktop) const SizedBox(width: 24),
          if (!isDesktop)
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.search_normal),
            ),

          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),
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
              const SizedBox(width: 8),
              if (!AriloDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const AriloShimmerEffect(width: 50, height: 12)
                          : Text(
                            controller.user.value.fullName,
                            style: const TextStyle(fontSize: 14),
                          ),
                      Text(
                        controller.user.value.email,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AriloDeviceUtils.getAppBarHeight()); // Removed the + 15
}
