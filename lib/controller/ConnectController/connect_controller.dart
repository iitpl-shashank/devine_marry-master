import 'dart:developer';

import 'package:devine_marry/data/repo/connect_repo.dart';
import 'package:devine_marry/models/connect/conversation_model.dart';
import 'package:devine_marry/models/connect/message_model.dart';
import 'package:devine_marry/widgets/common_loading.dart';
import 'package:devine_marry/widgets/custom_snack_bar.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectController extends GetxController implements GetxService {
  final ConnectRepo connectRepo;
  final SharedPreferences sharedPreferences;

  ConnectController({
    required this.connectRepo,
    required this.sharedPreferences,
  });

  RxList<ConversationModel> conversationResponse = <ConversationModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<MessageModel> messagesList = <MessageModel>[].obs;

  Future<void> getConversationList() async {
    showLoading();
    isLoading.value = true;
    conversationResponse.clear();
    update();

    try {
      Response response = await connectRepo.getConversationList();
      log("Conversation Response: ${response.body}");

      if (response.body == null) {
        showCustomSnackBar("No data received.", isError: true);
        isLoading.value = false;
        return;
      }

      if (response.body is List) {
        List<ConversationModel> conversations = (response.body as List)
            .map((item) => ConversationModel.fromJson(item))
            .toList();
        conversationResponse.assignAll(conversations);
        log("Conversations count: ${conversationResponse.length}");
      } else {
        isLoading.value = false;
        showCustomSnackBar("Unexpected response format", isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      log("Error fetching conversations: $e");
      showCustomSnackBar("Something went wrong. $e", isError: true);
    } finally {
      hideLoading();
      isLoading.value = false;
      update();
    }
  }

  Future<void> getChatMessages({required int conversationId}) async {
    showLoading();
    isLoading.value = true;
    update();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      Response response = await connectRepo.getMessagesChat(
        id: conversationId,
        headers: headers,
      );
      log("Messages Chat Response: ${response.body}");

      if (response.body == null) {
        showCustomSnackBar("No data received.", isError: true);
        isLoading.value = false;
        return;
      }

      if (response.body is List) {
        List<MessageModel> fetchedMessages = (response.body as List)
            .map((item) => MessageModel.fromJson(item))
            .toList();
        messagesList.assignAll(fetchedMessages);
        log("Messages fetched: ${messagesList.length}");
      } else {
        showCustomSnackBar("Unexpected response format.", isError: true);
      }
    } catch (e) {
      log("Error fetching messages: $e");
      showCustomSnackBar("Something went wrong. $e", isError: true);
    } finally {
      hideLoading();
      isLoading.value = false;
      update();
    }
  }
}
