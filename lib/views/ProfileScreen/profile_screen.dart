import 'package:devine_marry/widgets/custom_linear_gradient_button.dart';
import 'package:devine_marry/widgets/profile_section_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        child: Image.network(
                          'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with your image URL
                          height: 115,
                          width: 115,
                          fit: BoxFit
                              .cover, // Ensures the image fits within the bounds
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
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
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLinearGradientButton(
                        height: 76,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "13",
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
                    CustomLinearGradientButton(
                        height: 76,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "3",
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
                  ],
                ),
                const SizedBox(height: 8),
                ProfileSectionButton(
                    title: StringTexts.personalDetails,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringTexts.personalDetails),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }),
                ProfileSectionButton(
                    title: StringTexts.familyBackground,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringTexts.familyBackground),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }),
                ProfileSectionButton(
                    title: StringTexts.educationAndProfessionDetails,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(StringTexts.educationAndProfessionDetails),
                          duration: Duration(seconds: 2),
                        ),
                      );
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
