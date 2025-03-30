

import 'package:arilo_admin/utils/theme/custome_theme/appbar_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/bottomsheet_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/checkbox_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/chip_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/elevatebottom_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/outlinebuttom_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/text_theme.dart';
import 'package:arilo_admin/utils/theme/custome_theme/textform_theme.dart';
import 'package:flutter/material.dart';

class AriloAppTheme {
  AriloAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AriloTextTheme.lighttexttheme,
    elevatedButtonTheme: AriloElevatedButtomTheme.lightElevatedButton,
    appBarTheme: AriloAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: AriloBottomSheetTheme.lightBottomSheet,
    checkboxTheme: AriloCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: AriloChipTheme.lightChipTheme,
    outlinedButtonTheme: AriloOutlinedButtonTheme.lightOutlinedButton,
    inputDecorationTheme: AriloTextFormTheme.lightInputDecorationTheme,
  );
}
