import 'dart:math' as math;
import 'package:arilo_admin/utils/constants/snackbar_asset.dart';
import 'package:flutter_svg/svg.dart';
import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String title;
  final String message;
  final SnackBarType type;

  const CustomSnackBar({
    super.key,
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
   
    final baseColor = SnackBarColors.getColorForType(type);
    
    
    final hsl = HSLColor.fromColor(baseColor);
    final darkShade = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();

    
    final horizontalPadding = 1.0; 
    final leftSpace = 50.0; 

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 0.5,
      ),
      height:75,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

      
          Positioned(
            bottom: 0,
            left: !isRTL ? 0 : null,
            right: isRTL ? 0 : null,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL ? math.pi : 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
                child: SvgPicture.asset(
                  SnackbarAssets.bubblesBg,
                  height: 40, 
                  width: 40,
                  colorFilter: ColorFilter.mode(darkShade, BlendMode.srcIn),
                ),
              ),
            ),
          ),

          Positioned(
            top: -12,
            left: !isRTL ? 12 : null,
            right: isRTL ? 12 : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  SnackbarAssets.circleBack,
                  height: 36, 
                  colorFilter: ColorFilter.mode(darkShade, BlendMode.srcIn),
                ),
                
                // 
                Positioned(
                  top: 9, 
                  child: SvgPicture.asset(
                    _getIconForType(),
                    height: 16, 
                  ),
                ),
              ],
            ),
          ),

          
          Positioned.fill(
            left: isRTL ? 12 : leftSpace,
            right: isRTL ? leftSpace : 12,
            top: 8,
            bottom: 8, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18, 
                      ),
                      padding: EdgeInsets.zero, 
                      constraints: const BoxConstraints(), 
                    ),
                  ],
                ),
                const SizedBox(height: 4), 
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13, 
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getIconForType() {
    switch (type) {
      case SnackBarType.success:
        return SnackbarAssets.successIcon;
      case SnackBarType.failure:
        return SnackbarAssets.failureIcon;
      case SnackBarType.warning:
        return SnackbarAssets.warningIcon;
      case SnackBarType.help:
        return SnackbarAssets.helpIcon;
    }
  }
}