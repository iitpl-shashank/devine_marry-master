import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:devine_marry/models/home/match_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/route_helper.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_discover_icon.dart';

class DiscoverMatchesSection extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final String title = "Discover Matches";
  DiscoverMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringTexts.discover_matches,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    homeController.getReligionUserList().then((value) {
                      homeController.update();
                      List<User> users = homeController.religionUsers;
                      Get.toNamed(RouteHelper.seeAllScreen, arguments: {
                        'users': users,
                        'title': title,
                      });
                    });
                  },
                  child: CustomDiscoverIcon(
                    svgPath: Svgs.religionVector,
                    padding: 10.0,
                    borderColor: AppColors.lightTheme,
                    label: "Religion",
                  ),
                ),
                InkWell(
                  onTap: () {
                    homeController.getQualificationUserList().then((value) {
                      homeController.update();
                      List<User> users = homeController.qualificationUsers;
                      Get.toNamed(RouteHelper.seeAllScreen, arguments: {
                        'users': users,
                        'title': title,
                      });
                    });
                  },
                  child: CustomDiscoverIcon(
                    svgPath: Svgs.qualificationVector,
                    padding: 10.0,
                    borderColor: AppColors.lightTheme,
                    label: "Qualification",
                  ),
                ),
                InkWell(
                  onTap: () {
                    homeController.getStateUserList().then((value) {
                      homeController.update();
                      List<User> users = homeController.stateUsers;
                      Get.toNamed(RouteHelper.seeAllScreen, arguments: {
                        'users': users,
                        'title': title,
                      });
                    });
                  },
                  child: CustomDiscoverIcon(
                    svgPath: Svgs.stateVector,
                    padding: 10.0,
                    borderColor: AppColors.lightTheme,
                    label: "State",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
