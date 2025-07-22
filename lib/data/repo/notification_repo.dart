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
}
