import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';
import '../api/api.dart';

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<Response> getDefaultMatchedUsers({
    required Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
      AppConstants.getMatchedUsers,
      {},
      headers: headers,
    );
  }

  Future<Response> getUsersList({
    required String filter,
    required Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
      AppConstants.getMatchedUsers,
      {"filter": filter},
      headers: headers,
    );
  }

  Future<Response> getUserDetails(String userId) async {
    return await apiClient
        .postData(AppConstants.getUserDetails, {"user_id": userId});
  }
}
