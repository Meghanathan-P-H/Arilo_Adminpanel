import 'package:flutter/material.dart';

class AriloElevatedButtomTheme {
  AriloElevatedButtomTheme._();

  static ElevatedButtonThemeData lightElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF000000),
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: Color(0xFF000000)),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
