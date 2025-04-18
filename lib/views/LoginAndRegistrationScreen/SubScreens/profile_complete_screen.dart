import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/images.dart';

class ProfileCompleteScreen extends StatelessWidget {
  ProfileCompleteScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    authController.onCompleteRegistration();
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(Images.successRegistration))),
    );
  }
}
