import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/widgets/custom_linear_gradient_button.dart';
import 'package:devine_marry/widgets/profile_section_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringTexts.profile.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTheme,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Obx(
                        () => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            profileController
                                    .profile.value?.data?.user?.imageUrl ??
                                profileController.defaultProfileImage,
                            height: 115,
                            width: 115,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          profileController.updateProfileImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Svgs.editImageVector,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              StringTexts.upload_profile_picture,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightTheme,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomLinearGradientButton(
                            height: 76,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.profile.value?.data?.user
                                          ?.connectCount
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  StringTexts.connects,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CustomLinearGradientButton(
                            height: 76,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.profile.value?.data?.user
                                          ?.matchesCount
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  StringTexts.matches,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ProfileSectionButton(
                    title: StringTexts.personalDetails,
                    onTap: () {
                      profileController.profilenavigation('personal_details');
                    }),
                ProfileSectionButton(
                    title: StringTexts.familyBackground,
                    onTap: () {
                      profileController.profilenavigation('family_background');
                    }),
                ProfileSectionButton(
                    title: StringTexts.educationAndProfessionDetails,
                    onTap: () {
                      profileController
                          .profilenavigation('education_profession');
                    }),
                ProfileSectionButton(
                    title: StringTexts.Personality_Details,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringTexts.Personality_Details),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }),
                ProfileSectionButton(
                    title: StringTexts.Preferences,
                    showDivider: false,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringTexts.Preferences),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
