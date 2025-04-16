import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/controller/SplashScreenController/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(Images.splashScreen),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
