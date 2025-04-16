import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/themes/light_theme.dart';

void showLoading(){
  Get.dialog(
    Center(child: CircularProgressIndicator(color: light.primaryColorDark)),
    barrierDismissible: false,
  );
}

void hideLoading(){
  Get.back();
}