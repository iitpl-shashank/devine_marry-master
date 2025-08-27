import 'package:devine_marry/data/api/api.dart';
import 'package:devine_marry/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NotificationRepo {
  final ApiClient apiClient;

  NotificationRepo({
    required this.apiClient,
  });

  Future<Response> getNotifications(
      {required Map<String, String>? headers}) async {
    return await apiClient.getData(
      AppConstants.notificationsUrl,
      method: 'GET',
      headers: headers,
    );
  }

  Future<Response> updateNotificationStatus({
    required Map<String, String>? headers,
    required String notificationId,
  }) async {
    return await apiClient.postData(
      AppConstants.updateNotificationRead,
      headers: headers,
      {
        'notification_id': notificationId,
        'is_read': '1',
      },
    );
  }
}
