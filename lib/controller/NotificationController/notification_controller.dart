import 'package:devine_marry/data/repo/notification_repo.dart';
import 'package:devine_marry/models/notification/notification_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  final NotificationRepo notificationRepo;
  final SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;
  Rx<NotificationModel?> notificationData = Rx<NotificationModel?>(null);

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
}
