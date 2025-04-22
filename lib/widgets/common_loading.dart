import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/themes/light_theme.dart';

void showLoading() {
  Get.dialog(
    Center(child: CircularProgressIndicator(color: light.primaryColorDark)),
    barrierDismissible: false,
  );
}

// void hideLoading(){
//   Get.back();
// }

void hideLoading() {
  if (Get.isDialogOpen == true) {
    Navigator.of(Get.overlayContext!).pop();
  }
}
