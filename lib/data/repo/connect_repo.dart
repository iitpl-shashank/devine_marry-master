import 'package:devine_marry/data/api/api.dart';
import 'package:devine_marry/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ConnectRepo {
  final ApiClient apiClient;
  ConnectRepo({required this.apiClient});

  Future<Response> getConversationList() async {
    return await apiClient.getData(
      AppConstants.conversationsList,
      method: 'GET',
    );
  }

  Future<Response> getMessagesChat({
    required int id,
    Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
      AppConstants.getMessages,
      {"conversation_id": id},
      headers: headers,
    );
  }
}
