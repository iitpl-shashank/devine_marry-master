import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/utils/images.dart';
import 'package:devine_marry/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final profileController = Get.find<ProfileController>();

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
            profileController.profileNavigation("notification");
          },
        ),
        body: Center(
          child: Text('Chat messages will be displayed here.'),
        ),
      ),
    );
  }
}
