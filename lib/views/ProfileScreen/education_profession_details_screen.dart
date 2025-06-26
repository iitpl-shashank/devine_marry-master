import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../helper/date_converter.dart';
import '../../models/component_models/user_atributes.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';

class EducationProfessionDetailsScreen extends StatefulWidget {
  const EducationProfessionDetailsScreen({super.key});

  @override
  State<EducationProfessionDetailsScreen> createState() =>
      _EducationProfessionDetailsScreenState();
}

class _EducationProfessionDetailsScreenState
    extends State<EducationProfessionDetailsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.setEducationProfesionDetails();
    });
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
                  profileController.updateEducationalDetails();
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
              profileController.profileNavigation("notification");
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: profileController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            StringTexts.EDUCATION_DETAILS,
                            style: TextStyle(
                              color: AppColors.darkTheme,
                              fontSize: 18,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Highest Qualification',
                                  options: controller.dataModel.qualifications
                                      .map(
                                          (qualification) => qualification.name)
                                      .toList(),
                                  selectedValue:
                                      profileController.highestQualification,
                                  onChanged: (value) async {
                                    profileController
                                        .updateHighestQualification(
                                            value ?? "");
                                    if (value != "High School" &&
                                        value != "Intermediate") {
                                      profileController.updateDegree(null);
                                      await controller.getDegrees();
                                    } else {
                                      profileController.updateDegree(null);
                                      controller.degreeResponse =
                                          DegreeResponse(Degrees: []);
                                    }
                                    setState(() {});
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
                          CustomTextField(
                            hintText: 'School/ University',
                            controller:
                                profileController.schoolUniversityController,
                            onChanged: (value) {},
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          Visibility(
                            visible: (((profileController.degree != null &&
                                        profileController.degree!.isNotEmpty) ||
                                    profileController.highestQualification !=
                                            "High School" &&
                                        profileController
                                                .highestQualification !=
                                            "Intermediate") &&
                                controller.degreeResponse.Degrees.isNotEmpty),
                            child: Row(
                              children: [
                                Flexible(
                                  child:
                                      // CustomDropdownField(
                                      //   hintText: 'Degree',
                                      //   options: controller.degreeResponse.Degrees
                                      //       .map((degrees) => degrees.name)
                                      //       .toList(),
                                      //   selectedValue: profileController.degree,
                                      //   onChanged: (value) {
                                      //     profileController
                                      //         .updateDegree(value ?? "");
                                      //   },
                                      //   validator: (value) {
                                      //     if (value == null || value.isEmpty) {
                                      //       return 'Please select an option';
                                      //     }
                                      //     return null;
                                      //   },
                                      // ),
                                      CustomDropdownField(
                                    hintText: 'Degree',
                                    options: controller.degreeResponse.Degrees
                                        .map((degrees) => degrees.name)
                                        .toList(),
                                    selectedValue: controller
                                            .degreeResponse.Degrees
                                            .map((degrees) => degrees.name)
                                            .contains(profileController.degree)
                                        ? profileController.degree
                                        : null,
                                    onChanged: (value) {
                                      profileController
                                          .updateDegree(value ?? "");
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
                          ),
                          Visibility(
                            visible:
                                (controller.degreeResponse.Degrees.isNotEmpty &&
                                    profileController.highestQualification !=
                                        "High School" &&
                                    profileController.highestQualification !=
                                        "Intermediate"),
                            child: SizedBox(height: 25),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Year of Passing',
                                  options: controller.yearOptions,
                                  selectedValue:
                                      profileController.yearOfPassing,
                                  onChanged: (value) {
                                    profileController
                                        .updateYearOfPassing(value ?? "");
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
                          Text(
                            StringTexts.PROFESSION_DETAIL,
                            style: TextStyle(
                              color: AppColors.darkTheme,
                              fontSize: 18,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 17),
                          CustomTextField(
                            controller:
                                profileController.companyOrganisationController,
                            hintText: 'Company/ Organisation',
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
                            controller: profileController.designationController,
                            hintText: 'Designation',
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
                            isAmount: true,
                            inputType: TextInputType.number,
                            controller:
                                profileController.monthlyIncomeController,
                            hintText: 'Monthly Income',
                            onChanged: (value) {},
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Years of Experience",
                                    style: TextStyle(
                                      color: Color(0xB2212121),
                                      fontSize: 14,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (profileController.experience ==
                                                  null ||
                                              profileController.experience ==
                                                  0) {
                                            profileController
                                                .updateExperience(0);
                                          } else {
                                            profileController.updateExperience(
                                                (profileController.experience ??
                                                        0) -
                                                    1);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: profileController
                                                            .experience ==
                                                        null ||
                                                    profileController
                                                            .experience ==
                                                        0 ||
                                                    (profileController
                                                                .experience ??
                                                            0) <
                                                        0
                                                ? Color(0xFFBA7270)
                                                : Color(0xFF86413F),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13.0, vertical: 10),
                                            child: Center(
                                                child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: GetBuilder<ProfileController>(
                                            builder: (controller) {
                                          return Text(
                                            profileController.noOfYears ?? "0",
                                          );
                                        }),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if ((profileController.experience ??
                                                  0) <
                                              30) {
                                            profileController.updateExperience(
                                                (profileController.experience ??
                                                        0) +
                                                    1);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: profileController
                                                            .experience ==
                                                        null ||
                                                    profileController
                                                            .experience ==
                                                        30 ||
                                                    (profileController
                                                                .experience ??
                                                            30) >=
                                                        30
                                                ? Color(0xFFBA7270)
                                                : Color(0xFF86413F),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13.0, vertical: 10),
                                            child: Center(
                                                child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                        ]),
                  ),
          ),
        ),
      );
    });
  }
}
