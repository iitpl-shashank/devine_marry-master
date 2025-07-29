import 'package:devine_marry/controller/ConnectController/connect_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/helper/common_functions.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/connect_list_item.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final connectController = Get.find<ConnectController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectController.getConversationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringTexts.connects.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTheme,
                ),
              ),
              const SizedBox(height: 28),
              Obx(
                () {
                  if (connectController.conversationResponse.isEmpty) {
                    return Center(
                      child: connectController.isLoading.value
                          ? SizedBox.shrink()
                          : Text(
                              "No conversations found.",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.grey,
                              ),
                            ),
                    );
                  } else {
                    int myId =
                        profileController.profile.value?.data?.user?.id ?? 0;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: connectController.conversationResponse.length,
                      itemBuilder: (context, index) {
                        final conversation =
                            connectController.conversationResponse[index];
                        return InkWell(
                          onTap: () {
                            connectController.getChatMessages(
                              conversationId: conversation.id ?? 0,
                            );
                            Get.toNamed(RouteHelper.chatScreen);
                          },
                          child: ConnectListItem(
                            isRead: false,
                            userName: myId == conversation.senderId
                                ? (conversation.receiverDetails?.firstName ??
                                    "")
                                : (conversation.senderDetails?.firstName ?? ""),
                            time: CommonFunctions().formatDateTime(
                                conversation.createdAt.toString()),
                            description: conversation.messages?.isNotEmpty ==
                                    true
                                ? (conversation.messages!.last.message ?? "")
                                : "No messages yet",
                            imageUrl: myId == conversation.receiverId
                                ? (conversation.senderDetails?.imageUrl ?? "")
                                : (conversation.receiverDetails?.imageUrl ??
                                    ""),
                            hideNotificationIcon: true,
                            isLast: index ==
                                connectController.conversationResponse.length -
                                    1,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
