import 'package:flutter/material.dart';

class AriloBottomSheetTheme {
  AriloBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheet = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints:const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
    )
  );
}
