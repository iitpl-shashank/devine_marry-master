import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:devine_marry/views/ConnectScreen/connect_screen.dart';
import 'package:devine_marry/views/ProfileScreen/profile_screen.dart';
import 'package:devine_marry/views/SearchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../controller/DashboardController/dashboard_controller.dart';
import '../../controller/HomeController/home_controller.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../utils/images.dart';
import '../../widgets/common_loading.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_navigationbar_item.dart';
import '../HomeScreen/home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final DashboardController dashboardController = Get.find();
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();

  final List<Widget> _screens = [
    const HomeScreen(),
    const ConnectScreen(),
    SearchScreen(),
    const ProfileScreen(),
  ];

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
        await homeController.getAllMatchedUserList();
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
        backgroundColor: AppColors.backgroundGrey,
        appBar: CustomAppBar(
          startIconPath: Svgs.menuVector,
          endIconPath: Svgs.notificationVector,
          centerLogoPath: Svgs.logo,
          startIconHeight: 18,
          startIconWidth: 26,
          endIconHeight: 21,
          endIconWidth: 16,
          centerLogoHeight: 51,
          centerLogoWidth: 104,
          onStartIconTap: () {
            dashboardController.navigateToMenu();
          },
          onEndIconTap: () {
            dashboardController.navigateToNotification();
          },
        ),
        body: Obx(() => _screens[dashboardController.currentIndex.value]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() => CustomBottomNavigationBarItem(
                      svgIconPath: Svgs.homeVector,
                      label: "HOME",
                      isActive: dashboardController.currentIndex.value == 0,
                      onTap: () {
                        dashboardController.updateIndex(0);
                      },
                    )),
                Obx(() => CustomBottomNavigationBarItem(
                      svgIconPath: Svgs.connectsVector,
                      label: "CONNECTS",
                      isActive: dashboardController.currentIndex.value == 1,
                      onTap: () {
                        dashboardController.updateIndex(1);
                      },
                    )),
                Obx(() => CustomBottomNavigationBarItem(
                      svgIconPath: Svgs.searchVector,
                      label: "SEARCH",
                      isActive: dashboardController.currentIndex.value == 2,
                      onTap: () {
                        dashboardController.updateIndex(2);
                      },
                    )),
                Obx(() => CustomBottomNavigationBarItem(
                      svgIconPath: Svgs.profileVector,
                      label: "PROFILE",
                      isActive: dashboardController.currentIndex.value == 3,
                      onTap: () {
                        dashboardController.updateIndex(3);
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
