import 'package:devine_marry/models/home/match_preference_model.dart';
import 'package:devine_marry/widgets/custom_animated_match_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../helper/date_converter.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/match_card.dart';

class FindYourMatchSection extends StatelessWidget {
  final List<User> allMatchedUsers;
  final AuthController authController = Get.find();
  FindYourMatchSection({
    super.key,
    required this.allMatchedUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
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
              StringTexts.find_your_match,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomAnimatedMatchCard(
              cards: allMatchedUsers.map((user) {
                return MatchCard(
                  name: user.firstName ?? "Unknown",
                  age: int.parse(
                      AgeCalculator.calculateAge(user.birthDate.toString())),
                  height: HeightConverter.convertCmToFeetAndInches(
                      user.height ?? 180),
                  religion: authController.religionResponse.religions
                      .firstWhere((element) => element.id == user.religion,
                          orElse: () =>
                              authController.religionResponse.religions.first)
                      .name,
                  imageUrl: user.imageUrl ?? "",
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
