import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandTableHeader extends StatelessWidget {
  const BrandTableHeader({super.key, this.onPressed, required this.textButton, this.searchContorller, this.searchOnChanged});

  final Function()? onPressed;
  final String textButton;

  final TextEditingController? searchContorller;
  final Function(String)? searchOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: AriloDeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AriloRoute.createBrand),
                  child: Text('Create New Brand'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: AriloDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller:searchContorller ,
            onChanged: searchOnChanged,
            decoration: InputDecoration(
              hintText: 'Search Brand',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}