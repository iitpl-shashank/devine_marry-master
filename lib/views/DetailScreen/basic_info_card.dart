import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/helper/date_converter.dart';
import 'package:devine_marry/models/details/user_details_model.dart'
    as MatchedUser;
import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/string_texts.dart';

class BasicInfoCard extends StatelessWidget {
  final MatchedUser.UserDetailsModel userProfile;
  final AuthController authController = Get.find<AuthController>();
  BasicInfoCard({
    super.key,
    required this.userProfile,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkTheme.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringTexts.basicInformation,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTheme,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),
          infoRow(
              StringTexts.height,
              HeightConverter.convertCmToFeetAndInches(
                  userProfile.data?.user?.physicalAttributes?.height ?? 0)),
          infoRow(
            StringTexts.age,
            userProfile.data?.user?.birthDate != null
                ? AgeCalculator.calculateAge(
                    userProfile.data!.user!.birthDate!.toIso8601String(),
                  )
                : "N/A", // Fallback value if birthDate is null
          ),
          infoRow(
              StringTexts.religion,
              authController.religionResponse.religions
                  .firstWhere(
                      (element) =>
                          element.id == userProfile.data?.user?.religions,
                      orElse: () =>
                          authController.religionResponse.religions.first)
                  .name),
          // infoRow(
          //     StringTexts.currentLocation,
          //     authController.stateResponse.states
          //         .firstWhere(
          //             (element) =>
          //                 element.id == userProfile.data?.user?.state,
          //             orElse: () => authController.stateResponse.states.first)
          //         .name),
          infoRow(
              StringTexts.qualification,
              authController.dataModel.qualifications
                  .firstWhere(
                      (element) =>
                          element.id ==
                          userProfile.data?.user?.educationInfoData?.first
                              .highestQualification,
                      orElse: () =>
                          authController.dataModel.qualifications.first)
                  .name),
          infoRow(StringTexts.profession,
              userProfile.data?.user?.careerInfo?.first.designation ?? "",
              hideDivider: true),
        ],
      ),
    );
  }

  Widget infoRow(String title, String value, {bool hideDivider = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.60),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (!hideDivider)
            Divider(
              color: AppColors.darkTheme.withOpacity(0.2),
              height: 16,
              thickness: 1,
            ),
        ],
      ),
    );
  }
}
