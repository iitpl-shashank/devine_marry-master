import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:devine_marry/views/HomeScreen/discover_matches_section.dart';
import 'package:devine_marry/views/HomeScreen/find_your_match_section.dart';
import 'package:devine_marry/views/HomeScreen/new_matches_section.dart';
import 'package:devine_marry/widgets/common_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../utils/string_texts.dart';
import '../../widgets/custom_search_field.dart';
import '../../widgets/home_user_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        showLoading();
        await profileController.fetchProfile();
        await Get.find<AuthController>().getCountries();
        await Get.find<AuthController>().getReligion();
        await Get.find<AuthController>().getUserAttributes();
        await homeController.getDefaultUsersBasedOnPreference();
        await homeController.getLatestUserList();
        await homeController.getMyStateUserList();
      } catch (e) {
        debugPrint('Error fetching profile: $e');
      } finally {
        hideLoading();
      }
    });
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
                child: CustomSearchBar(
                  hintText: 'Search...',
                  onChanged: (value) {
                    debugPrint('Search query: $value');
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),

              // <--- Matches Based on your Preferences Section --->

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
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.matchedUsers.length,
                    itemBuilder: (context, index) {
                      final user = controller.matchedUsers[index];
                      return UserItem(
                          imageUrl: user.imageUrl ?? "",
                          name: user.firstName ?? "",
                          onImageTap: () {
                            controller.homeUserNavigation(
                              id: user.id.toString(),
                            );
                          },
                          connectButtonTap: () {
                            Get.snackbar(
                              "Divine Marry",
                              "Connect with ${user.firstName.toString()} ${user.lastName.toString()}",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.lightTheme,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          });
                    },
                  ),
                ),
              ),

              // <--- Find Your Match Section --->

              FindYourMatchSection(),
              SizedBox(
                height: 24,
              ),

              // <--- Discover Matches Section --->

              DiscoverMatchesSection(),
              SizedBox(
                height: 24,
              ),

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
