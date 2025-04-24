import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../widgets/custom_app_bar.dart';

class SeeAllMatchesScreen extends StatelessWidget {
  const SeeAllMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          startIconPath: Svgs.backArrowVector,
          endIconPath: Svgs.notificationVector,
          centerLogoPath: Svgs.logo,
          endIconHeight: 21,
          endIconWidth: 16,
          centerLogoHeight: 51,
          centerLogoWidth: 104,
          onStartIconTap: () {
            Get.back();
          },
          onEndIconTap: () {
            // Handle end icon tap
          },
        ),
      ),
    );
  }
}
