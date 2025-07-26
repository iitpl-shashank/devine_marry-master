import 'dart:async';
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
  final PageController _pageController = PageController();
  Timer? _sliderTimer;

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
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _sliderTimer?.cancel();
    _sliderTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      final images = _getSliderImages();
      if (images.length <= 1) return;

      homeController.currentPage.value =
          (homeController.currentPage.value + 1) % images.length;
      _pageController.animateToPage(
        homeController.currentPage.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  List<String> _getSliderImages() {
    final user = homeController.selectedUser.value.data?.user;
    final List<String> images = [];
    if ((user?.imageUrl ?? '').isNotEmpty) {
      images.add(user!.imageUrl!);
    }
    if (user?.galleryImages != null && user!.galleryImages!.isNotEmpty) {
      images.addAll(user.galleryImages!);
    }
    return images;
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() {
          int userInterest = int.parse(homeController
                  .selectedUser.value.data?.user?.userInterestStatus
                  .toString() ??
              '0');
          int senderId =
              homeController.selectedUser.value.data?.user?.userSenderId ?? 0;
          int receiverId =
              homeController.selectedUser.value.data?.user?.userReceiverId ?? 0;
          int myId = profileController.profile.value?.data?.user?.id ?? 0;

          log("User Interest: $userInterest, Sender ID: $senderId, Receiver ID: $receiverId, My ID: $myId");
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: (receiverId == myId && userInterest == 0)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              homeController.rejectInterestRequest(
                                id: senderId,
                                myUserId: widget.userId,
                              );
                            },
                            child: Text("Reject"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              homeController.acceptInterestRequest(
                                id: senderId,
                                myUserId: widget.userId,
                              );
                            },
                            child: Text("Accept"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (senderId == myId) {
                          log("Button Pressed : $userInterest");
                          if ((userInterest == "0" || userInterest == 0)) {
                            Get.snackbar(
                              "Request Sent",
                              "Request already sent",
                              snackPosition: SnackPosition.TOP,
                            );
                          } else if ((userInterest == "1" ||
                              userInterest == 1)) {
                            Get.snackbar(
                              "Chat Now",
                              "Start chatting with this user",
                              snackPosition: SnackPosition.TOP,
                            );
                          } else {
                            homeController.sendInterestToUser(
                              interestingId: homeController
                                      .selectedUser.value.data?.user?.id ??
                                  0,
                              myUserId: widget.userId,
                            );
                          }
                        } else if (receiverId == myId) {
                          log("Button Pressed : $userInterest");
                          if ((userInterest == "1" || userInterest == 1)) {
                            Get.snackbar(
                              "Chat Now",
                              "Start chatting with this user",
                              snackPosition: SnackPosition.TOP,
                            );
                          } else {
                            homeController.sendInterestToUser(
                              interestingId: homeController
                                      .selectedUser.value.data?.user?.id ??
                                  0,
                              myUserId: widget.userId,
                            );
                          }
                        } else {
                          homeController.sendInterestToUser(
                            interestingId: homeController
                                    .selectedUser.value.data?.user?.id ??
                                0,
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
                      if (homeController.selectedUser.value.data?.user
                              ?.galleryImages?.isEmpty ??
                          true)
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
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          height: 500,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: _getSliderImages().length,
                                onPageChanged: (index) {
                                  homeController.currentPage.value = index;
                                },
                                itemBuilder: (context, index) {
                                  final imageUrl = _getSliderImages()[index];
                                  return Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 500,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.network(
                                      homeController.defaultUserImage,
                                      width: double.infinity,
                                      height: 500,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Obx(() {
                                  final total = _getSliderImages().length;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      total,
                                      (index) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: homeController
                                                      .currentPage.value ==
                                                  index
                                              ? Theme.of(context).primaryColor
                                              : Colors.white.withOpacity(0.7),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
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
