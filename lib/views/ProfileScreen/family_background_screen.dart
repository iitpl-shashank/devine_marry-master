import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';

class FamilyBackgroundScreen extends StatefulWidget {
  const FamilyBackgroundScreen({super.key});

  @override
  State<FamilyBackgroundScreen> createState() => _FamilyBackgroundScreenState();
}

class _FamilyBackgroundScreenState extends State<FamilyBackgroundScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    //TODO : Change the authController to ProfileController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              print("Save button pressed");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              StringTexts.saveChanges,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
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
          profileController.profilenavigation("notification");
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 4,
          ),
          Text(
            StringTexts.familyBackground.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTheme,
            ),
          ),
          SizedBox(height: 25),
          CustomTextField(
            hintText: 'Father\'s Name',
            controller: authController.hairController,
            onChanged: (value) {},
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextField(
            hintText: 'Father\'s Profession',
            controller: authController.hairController,
            onChanged: (value) {},
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextField(
            hintText: 'Mother\'s Name',
            controller: authController.hairController,
            onChanged: (value) {},
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextField(
            hintText: 'Mother\'s Profession',
            controller: authController.hairController,
            onChanged: (value) {},
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextField(
            inputType: TextInputType.number,
            hintText: 'Number of Siblings',
            controller: authController.hairController,
            onChanged: (value) {},
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ]),
      ),
    );
  }
}
