import 'dart:convert';

import 'package:devine_marry/data/repo/notification_repo.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:devine_marry/models/notification/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  final NotificationRepo notificationRepo;
  final SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;
  Rx<NotificationModel?> notificationData = Rx<NotificationModel?>(null);
  RxInt unreadCount = 0.obs;

  NotificationController({
    required this.notificationRepo,
    required this.sharedPreferences,
  });

  Future<void> getNotification() async {
    try {
      isLoading.value = true;
      String token = sharedPreferences.getString('token') ?? "";

      Response response = await notificationRepo.getNotifications(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        notificationData.value =
            notificationModelFromJson(response.bodyString ?? "");
        update();
        isLoading.value = false;
        updateUnreadCount();
        print(
            "Notifications: ${notificationData.value?.data?.notifications?.length ?? 0}");
      } else {
        isLoading.value = false;
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      isLoading.value = false;
      print("Exception in getNotification: $e");
    }
  }

  Future<void> updateNotificationStatus({
    required String notificationId,
    required String senderId,
  }) async {
    try {
      String token = sharedPreferences.getString('token') ?? "";

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      Response response = await notificationRepo.updateNotificationStatus(
        headers: headers,
        notificationId: notificationId,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            response.body is String ? jsonDecode(response.body) : response.body;
        if (responseBody['success'] == true) {
          await getNotification();
          Get.toNamed(RouteHelper.userDetailsScreen, arguments: senderId);
        } else {
          Get.snackbar(
            "Error",
            responseBody['message'] ?? "Failed to update notification status.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to update notification status. ${response.statusText}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Exception: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateUnreadCount() {
    final notifications = notificationData.value?.data?.notifications ?? [];
    unreadCount.value = notifications.where((n) => n.isRead == 0).length;
  }
}
