import 'dart:developer';

import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:devine_marry/views/DetailScreen/basic_info_card.dart';
import 'package:devine_marry/views/DetailScreen/interest_hobbies_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/common_loading.dart';
import 'matching_profile_card.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userId;
  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        showLoading();
        await homeController.getUserDetails(userId: widget.userId);
      } catch (e) {
        debugPrint('Error fetching profile: $e');
      } finally {
        hideLoading();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() {
          dynamic userInterest =
              homeController.selectedUser.value.data?.user?.userInterestStatus;
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  log("Button Pressed : $userInterest");
                  if ((userInterest == "0" || userInterest == 0)) {
                    Get.snackbar(
                      "Request Sent",
                      "Request already sent",
                      snackPosition: SnackPosition.TOP,
                    );
                  } else if ((userInterest == "1" || userInterest == 1)) {
                    Get.snackbar(
                      "Chat Now",
                      "Start chatting with this user",
                      snackPosition: SnackPosition.TOP,
                    );
                  } else {
                    homeController.sendInterestToUser(
                      interestingId:
                          homeController.selectedUser.value.data?.user?.id ?? 0,
                      myUserId: widget.userId,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  (userInterest == "0" || userInterest == 0)
                      ? StringTexts.requestSent.toUpperCase()
                      : (userInterest == "1" || userInterest == 1)
                          ? StringTexts.chatNow.toUpperCase()
                          : StringTexts.connect.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          );
        }),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        homeController
                                .selectedUser.value.data?.user?.imageUrl ??
                            homeController.defaultUserImage,
                        width: double.infinity,
                        height: 500,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 500,
                              color: Colors.grey[300],
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          homeController.defaultUserImage,
                          width: double.infinity,
                          height: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white.withOpacity(0.40),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Info Card
                  Container(
                    color: AppColors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          StringTexts.about,
                          style: TextStyle(
                            color: AppColors.darkTheme,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          homeController.selectedUser.value.data?.user
                                  ?.physicalAttributes?.bio ??
                              "",
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.60),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Basic Info
                        BasicInfoCard(
                          userProfile: homeController.selectedUser.value,
                        ),
                        SizedBox(height: 16),

                        // Interests
                        InterestsHobbiesSection(
                          interestAndHobbies: homeController
                                  .selectedUser
                                  .value
                                  .data
                                  ?.user
                                  ?.physicalAttributes
                                  ?.interestsHobbies ??
                              "",
                        ),
                        SizedBox(height: 16),

                        //Matches Your Profile
                        MatchCard(
                          userImageUrl: homeController
                                  .selectedUser.value.data?.user?.imageUrl ??
                              "",
                          myPofile: profileController.profile.value?.data?.user,
                          matchedUser:
                              homeController.selectedUser.value.data?.user,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
