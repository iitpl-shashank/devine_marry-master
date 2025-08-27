import 'dart:developer';

import 'package:devine_marry/controller/NotificationController/notification_controller.dart';
import 'package:devine_marry/helper/common_functions.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/connect_list_item.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await notificationController.getNotification();
    });
  }

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
          onEndIconTap: () {},
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
              Obx(() {
                final notifications = notificationController
                        .notificationData.value?.data?.notifications ??
                    [];
                return Column(
                  children: notifications.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          notificationController.updateNotificationStatus(
                            notificationId: item.id.toString(),
                            senderId: item.senderId.toString(),
                          );
                        },
                        child: ConnectListItem(
                          isLast: item == notifications.last,
                          isRead: item.isRead == 0 ? true : false,
                          userName: item.senderName ?? "",
                          time: CommonFunctions()
                              .formatDateTime(item.createdAt.toString()),
                          description:
                              item.title ?? StringTexts.tempDescription,
                          hideNotificationIcon: true,
                          imageUrl: item.senderImageUrl ??
                              'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg',
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
