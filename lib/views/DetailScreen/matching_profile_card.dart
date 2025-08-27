import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/helper/date_converter.dart';
import 'package:devine_marry/models/profile/profile_model.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/themes/app_colors.dart';
import 'package:devine_marry/models/details/user_details_model.dart'
    as MatchedUser;

class MatchCard extends StatelessWidget {
  final String userImageUrl;
  final User? myPofile;
  final MatchedUser.User? matchedUser;
  final AuthController authController = Get.find<AuthController>();
  MatchCard({
    super.key,
    required this.userImageUrl,
    this.myPofile,
    this.matchedUser,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkTheme.withOpacity(0.07),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkTheme,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                  bottom: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    StringTexts.matchesYourProfile,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 70,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 60,
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: GetBuilder<ProfileController>(
                                        builder: (profileController) {
                                      return CircleAvatar(
                                        radius: 42,
                                        backgroundImage: NetworkImage(
                                          profileController.profile.value?.data
                                                  ?.user?.imageUrl ??
                                              profileController
                                                  .defaultProfileImage,
                                        ),
                                        onBackgroundImageError:
                                            (exception, stackTrace) {
                                          debugPrint(
                                              'Error loading image: $exception');
                                        },
                                        child: (profileController.profile.value
                                                    ?.data?.user?.imageUrl ==
                                                null)
                                            ? Icon(
                                                Icons.person, // Fallback icon
                                                size: 42,
                                                color: Colors.grey,
                                              )
                                            : null,
                                      );
                                    })),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: Builder(builder: (context) {
                                  return CircleAvatar(
                                    radius: 42,
                                    backgroundImage: NetworkImage(userImageUrl),
                                    onBackgroundImageError:
                                        (exception, stackTrace) {
                                      debugPrint(
                                          'Error loading image: $exception');
                                    },
                                    child: (userImageUrl.isEmpty)
                                        ? Icon(
                                            Icons.person, // Fallback icon
                                            size: 42,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 6),
            if (AgeCalculator.matchAges(
                myPofile?.birthDate?.toIso8601String() ?? "",
                matchedUser?.birthDate?.toIso8601String() ?? ""))
              _detailRow("Age:", "28"),
            if (myPofile?.physicalAttributes?.height ==
                matchedUser?.physicalAttributes?.height)
              _detailRow(
                  "Height:",
                  HeightConverter.convertCmToFeetAndInches(
                      myPofile?.physicalAttributes?.height ?? 180)),
            if (myPofile?.religions == matchedUser?.religions)
              _detailRow(
                  "Religion:",
                  authController.religionResponse.religions
                      .firstWhere(
                          (element) => element.id == myPofile?.religions,
                          orElse: () =>
                              authController.religionResponse.religions.first)
                      .name),
            if (myPofile?.country == matchedUser?.country)
              _detailRow(
                  "Country:",
                  authController.countryResponse.countries
                      .firstWhere((element) => element.id == myPofile?.country,
                          orElse: () =>
                              authController.countryResponse.countries.first)
                      .name),
            if (myPofile?.educationInfoData?.first.highestQualification ==
                matchedUser?.educationInfoData?.first.highestQualification)
              _detailRow(
                  "Qualification:",
                  authController.dataModel.qualifications
                      .firstWhere(
                          (element) =>
                              element.id ==
                              myPofile?.educationInfoData?.first
                                  .highestQualification,
                          orElse: () =>
                              authController.dataModel.qualifications.first)
                      .name),
            if (myPofile?.careerInfo?.first.designation ==
                matchedUser?.careerInfo?.first.designation)
              _detailRow(
                "Profession:",
                myPofile?.careerInfo?.first.designation ?? "",
              ),
            if (myPofile?.maritalStatus == matchedUser?.maritalStatus)
              _detailRow(
                  "Marital Status:",
                  authController.dataModel.maritalStatuses
                      .firstWhere(
                          (element) => element.id == myPofile?.maritalStatus,
                          orElse: () =>
                              authController.dataModel.maritalStatuses.first)
                      .title,
                  hideDivider: true),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool hideDivider = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.black.withOpacity(0.6),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 18,
                      ),
                      // const SizedBox(width: 4),
                      // Text(StringTexts.matched,
                      //     style: const TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w600,
                      //       color: AppColors.green,
                      //     )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: !hideDivider ? 6 : 20),
          if (!hideDivider)
            Divider(
              color: AppColors.black.withOpacity(0.1),
              thickness: 1,
            ),
        ],
      ),
    );
  }
}
