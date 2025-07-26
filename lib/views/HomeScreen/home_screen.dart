import 'dart:async';

import 'package:devine_marry/controller/DashboardController/dashboard_controller.dart';
import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:devine_marry/controller/NotificationController/notification_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:devine_marry/views/HomeScreen/discover_matches_section.dart';
import 'package:devine_marry/views/HomeScreen/find_your_match_section.dart';
import 'package:devine_marry/views/HomeScreen/new_matches_section.dart';
import 'package:devine_marry/widgets/tappable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/string_texts.dart';
import '../../widgets/home_user_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final NotificationController notificationController =
      Get.find<NotificationController>();
  Timer? _notificationTimer;

  @override
  void initState() {
    super.initState();
    _notificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      notificationController.getNotification();
    });
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
        child: GetBuilder<HomeController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TappableSearchBar(
                  hintText: 'Search...',
                  onTap: () {
                    dashboardController.updateIndex(2);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Text(
                  StringTexts.matches_based_on_your_preferences,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTheme,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: controller.matchedUsers.isNotEmpty
                    ? SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.matchedUsers.length,
                          itemBuilder: (context, index) {
                            final user = controller.matchedUsers[index];
                            return UserItem(
                                showAddbutton: (user.userInterestStatus == 100),
                                imageUrl: user.imageUrl ?? "",
                                name: user.firstName ?? "",
                                onImageTap: () {
                                  controller.homeUserNavigation(
                                    id: user.id.toString(),
                                  );
                                },
                                connectButtonTap: () {
                                  controller.homeUserNavigation(
                                    id: user.id.toString(),
                                  );
                                });
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Match Found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTheme,
                          ),
                        ),
                      ),
              ),

              // <--- Find Your Match Section --->

              FindYourMatchSection(
                allMatchedUsers: homeController.allMatchedUsers,
              ),

              // <--- Discover Matches Section --->

              DiscoverMatchesSection(),

              // <--- New Matches Section --->

              NewMatchesSection(
                key: ValueKey(controller.latestUsers),
                title: StringTexts.newMatches,
                users: controller.latestUsers,
              ),

              // <--- Matches in your state Section --->

              NewMatchesSection(
                title: StringTexts.matchesInYourState,
                backgroundColor: AppColors.backgroundGrey,
                users: controller.myStateUsers,
              ),
              SizedBox(
                height: 34,
              ),
            ],
          );
        }),
      ),
    );
  }
}
