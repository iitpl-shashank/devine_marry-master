import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/connect_list_item.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> connectList = [
    {
      "userName": "New match found",
      "time": "11:20 PM",
    },
    {
      "userName": "Message from Ritu",
      "time": "11:20 PM",
    },
    {
      "userName": "New match found",
      "time": "11:20 PM",
    },
    {
      "userName": "New match found",
      "time": "11:20 PM",
    },
    {
      "userName": "Message from Ritu",
      "time": "11:20 PM",
    },
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 120,
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
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              StringTexts.notifications.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            const SizedBox(height: 28),
            // Display the connect list items
            Column(
              children: connectList.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ConnectListItem(
                    userName: item["userName"]!,
                    time: item["time"]!,
                    description: StringTexts.tempDescription,
                    hideNotificationIcon: false,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
