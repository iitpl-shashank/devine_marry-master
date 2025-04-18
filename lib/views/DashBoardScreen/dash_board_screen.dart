import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:devine_marry/views/ConnectScreen/connect_screen.dart';
import 'package:devine_marry/views/ProfileScreen/profile_screen.dart';
import 'package:devine_marry/views/SearchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/DashboardController/dashboard_controller.dart';
import '../../utils/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_navigationbar_item.dart';
import '../HomeScreen/home_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final DashboardController dashboardController = Get.find();

  final List<Widget> _screens = [
    HomeScreen(),
    const ConnectScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: CustomAppBar(
        appBarHeight: 120,
        startIconPath: Svg.menuVector,
        endIconPath: Svg.notificationVector,
        centerLogoPath: Svg.logo,
        startIconHeight: 18,
        startIconWidth: 26,
        endIconHeight: 21,
        endIconWidth: 16,
        centerLogoHeight: 51,
        centerLogoWidth: 104,
        onStartIconTap: () {
          // TODO : Handle start icon tap
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
                    svgIconPath: Svg.homeVector,
                    label: "HOME",
                    isActive: dashboardController.currentIndex.value == 0,
                    onTap: () {
                      dashboardController.updateIndex(0);
                    },
                  )),
              Obx(() => CustomBottomNavigationBarItem(
                    svgIconPath: Svg.connectsVector,
                    label: "CONNECTS",
                    isActive: dashboardController.currentIndex.value == 1,
                    onTap: () {
                      dashboardController.updateIndex(1);
                    },
                  )),
              Obx(() => CustomBottomNavigationBarItem(
                    svgIconPath: Svg.searchVector,
                    label: "SEARCH",
                    isActive: dashboardController.currentIndex.value == 2,
                    onTap: () {
                      dashboardController.updateIndex(2);
                    },
                  )),
              Obx(() => CustomBottomNavigationBarItem(
                    svgIconPath: Svg.profileVector,
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
    );
  }
}
