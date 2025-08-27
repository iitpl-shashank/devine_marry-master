import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';
import '../api/api.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient});

  Future<Response> searchUsers({
    required String keyword,
    required Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
      AppConstants.searchUsers,
      {"keyword": keyword},
      headers: headers,
    );
  }
}
