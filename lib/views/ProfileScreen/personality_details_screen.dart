import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/number_picker_custom.dart';

class PersonalityDetailsScreen extends StatefulWidget {
  const PersonalityDetailsScreen({super.key});

  @override
  State<PersonalityDetailsScreen> createState() =>
      _PersonalityDetailsScreenState();
}

class _PersonalityDetailsScreenState extends State<PersonalityDetailsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.setPersonalityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  profileController.updatePhysicalAttributes();
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
            child: SingleChildScrollView(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  StringTexts.Personality_Details.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTheme,
                  ),
                ),
                SizedBox(height: 17),
                Row(
                  children: [
                    Flexible(
                      child: CustomDropdownField(
                        hintText: 'Complexion',
                        options: controller.dataModel.complexion
                            .map((complexion) => complexion.name)
                            .toList(),
                        selectedValue: profileController.complexion,
                        onChanged: (value) {
                          profileController.updateComplexion(value ?? "");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Flexible(
                      child: CustomDropdownField(
                        hintText: 'Blood Group',
                        options: controller.dataModel.bloodGroups
                            .map((religions) => religions.name)
                            .toList(),
                        selectedValue: profileController.bloodGroup,
                        onChanged: (value) {
                          profileController.updateBloodGroup(value ?? "");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Height',
                        readOnly: true,
                        suffixText: "Cm",
                        inputType: TextInputType.number,
                        isAmount: true,
                        controller: profileController.heightController,
                        onChanged: (value) {},
                        onTap: () {
                          showHeightPickerDialog(
                            context: context,
                            maxHeight: 254,
                            initialHeight: int.parse(
                                profileController.heightController.text),
                            onHeightSelected: (value) {
                              profileController.heightController.text =
                                  value.toString();
                            },
                          );
                        },
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: CustomTextField(
                        readOnly: true,
                        onTap: () {
                          showHeightPickerDialog(
                            title: "Select Weight (in Kg)",
                            context: context,
                            maxHeight: 150,
                            onHeightSelected: (value) {
                              profileController.weightController.text =
                                  value.toString();
                            },
                            initialHeight: int.parse(
                              profileController.weightController.text,
                            ),
                          );
                        },
                        hintText: 'Weight',
                        inputType: TextInputType.number,
                        suffixText: "Kg",
                        isAmount: true,
                        controller: profileController.weightController,
                        onChanged: (value) {},
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Hair Color',
                        controller: profileController.hairController,
                        onChanged: (value) {},
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Eye Color',
                        controller: profileController.eyeColorController,
                        onChanged: (value) {},
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                      child: CustomDropdownField(
                        selectedValue: profileController.smokingHabit,
                        hintText: 'Smoking Habit',
                        options: controller.dataModel.smoking
                            .map((smoking) => smoking.name)
                            .toList(),
                        onChanged: (value) {
                          profileController.updateSmokingHabit(value ?? "");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                      child: CustomDropdownField(
                        hintText: 'Drinking Habit',
                        selectedValue: profileController.drinkingHabit,
                        options: controller.dataModel.drinking
                            .map((drinking) => drinking.name)
                            .toList(),
                        onChanged: (value) {
                          profileController.updateDrinkingHabit(value ?? "");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                      child: CustomDropdownField(
                        hintText: 'Do you have any disability?',
                        selectedValue: profileController.disability,
                        options: controller.dataModel.disabilities
                            .map((drinking) => drinking.name)
                            .toList(),
                        onChanged: (value) {
                          profileController.updateDisability(value ?? "");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Bio (Max 50 lines)',
                        maxLines: 50,
                        controller: profileController.bioController,
                        onChanged: (value) {},
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Interests & Hobbies',
                        maxLines: 50,
                        controller: profileController.interestController,
                        onChanged: (value) {},
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ]),
            ),
          ),
        ),
      );
    });
  }
}
