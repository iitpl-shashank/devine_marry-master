import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/helper/date_converter.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:devine_marry/models/home/match_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_match_card.dart';

class NewMatchesSection extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final List<User> users;
  final AuthController authController = Get.find();

  NewMatchesSection(
      {super.key,
      required this.title,
      this.backgroundColor,
      required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTheme,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.seeAllScreen, arguments: {
                      'users': users,
                      'title': title,
                    });
                  },
                  child: Text(
                    StringTexts.seeAll,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black.withOpacity(0.60),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            users.isEmpty
                ? Center(
                    child: Text(
                      "No matches found",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 255,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: math.min(users.length, 10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == 4 ? 0 : 16,
                          ),
                          child: Obx(
                            () => CustomMatchCard(
                              connectionStatus:
                                  users[index].userInterestStatus ?? 100,
                              imageUrl: users[index].imageUrl ?? "",
                              name:
                                  "${users[index].firstName ?? 'Unknown'} ${users[index].lastName ?? ''}"
                                      .trim(),
                              age: int.parse(AgeCalculator.calculateAge(
                                  users[index].birthDate.toString())),
                              height: HeightConverter.convertCmToFeetAndInches(
                                  users[index].height ?? 180),
                              religion: authController
                                  .religionResponse.religions
                                  .firstWhere(
                                      (element) =>
                                          element.id == users[index].religion,
                                      orElse: () => authController
                                          .religionResponse.religions.first)
                                  .name,
                              userId: users[index].id.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
