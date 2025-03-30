import 'package:arilo_admin/utils/popups/loding_snackbar.dart';
import 'package:flutter/material.dart';


class SnackBarColors {
  static const Color success = Color(0xff2D6A4F);
  static const Color failure = Color(0xffc72c41);
  static const Color warning = Color(0xffFCA652);
  static const Color help = Color(0xff3282B8);

 
  static Color getColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return success;
      case SnackBarType.failure:
        return failure;
      case SnackBarType.warning:
        return warning;
      case SnackBarType.help:
        return help;
    }
  }
}

class SnackbarAssets {
  static const String _iconsPath = 'assets/type_svg/';
  

  static const String successIcon = '${_iconsPath}success.svg';
  static const String failureIcon = '${_iconsPath}failure.svg';
  static const String warningIcon = '${_iconsPath}warning.svg';
  static const String helpIcon = '${_iconsPath}help.svg';
  static const String bubblesBg = '${_iconsPath}bubbles.svg';
  static const String circleBack = '${_iconsPath}back.svg';
}
