import 'package:flutter/material.dart';

class AriloAppBarTheme {
  AriloAppBarTheme._();

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor:Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color:Colors.black,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.black)

  );
}
