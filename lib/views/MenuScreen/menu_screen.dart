import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/profile_section_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 120,
        startIconPath: Svgs.backArrowVector,
        endIconPath: Svgs.notificationVector,
        centerLogoPath: Svgs.logo,
        endIconHeight: 21,
        endIconWidth: 16,
        centerLogoHeight: 51,
        centerLogoWidth: 104,
        onStartIconTap: () {
          Get.back();
        },
        onEndIconTap: () {
          // Handle end icon tap
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              StringTexts.menu.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            const SizedBox(height: 12),
            ProfileSectionButton(
                title: StringTexts.aboutDivineMarry,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(StringTexts.aboutDivineMarry),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
            ProfileSectionButton(
                title: StringTexts.privacyPolicy,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(StringTexts.privacyPolicy),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
            ProfileSectionButton(
                title: StringTexts.termsAndConditions,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(StringTexts.termsAndConditions),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
            ProfileSectionButton(
                title: StringTexts.helpCenter,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(StringTexts.helpCenter),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
            ProfileSectionButton(
                title: StringTexts.rateUs,
                showDivider: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(StringTexts.rateUs),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
