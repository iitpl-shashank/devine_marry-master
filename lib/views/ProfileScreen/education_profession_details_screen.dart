import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/AuthController/auth_controller.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../helper/date_converter.dart';
import '../../models/component_models/user_atributes.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/styles.dart';
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
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
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
                  options: authController.dataModel.qualifications
                      .map((qualification) => qualification.name)
                      .toList(),
                  selectedValue: authController.highestQualification,
                  onChanged: (value) {
                    authController.updateHighestQualification(value ?? "");
                    if (value != "High School" && value != "Intermediate") {
                      authController.updateDegree(null);
                      authController.getDegrees();
                    } else {
                      authController.updateDegree(null);
                      authController.degreeResponse =
                          DegreeResponse(Degrees: []);
                    }
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
            controller: authController.schoolUniversityController,
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
            visible: authController.degreeResponse.Degrees.isNotEmpty,
            child: Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'Degree',
                    options: authController.degreeResponse.Degrees
                        .map((degrees) => degrees.name)
                        .toList(),
                    selectedValue: authController.degree,
                    onChanged: (value) {
                      authController.updateDegree(value ?? "");
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
              visible: authController.degreeResponse.Degrees.isNotEmpty,
              child: SizedBox(height: 25)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IntrinsicHeight(
                    child: CustomTextField(
                      controller: authController.startDateController,
                      readOnly: true,
                      suffixIcon: const Icon(
                        CupertinoIcons.calendar,
                        size: 18,
                        color: Colors.grey,
                      ),
                      hintText: 'Starting Date',
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        DateTime firstAllowedDate =
                            DateTime(currentDate.year - 100);
                        DateTime lastAllowedDate = DateTime(currentDate.year);

                        DateTime? selectedDate = await showDatePicker(
                          context: Get.context!,
                          initialDate: lastAllowedDate,
                          firstDate: firstAllowedDate,
                          lastDate: lastAllowedDate,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                  secondary: Colors.red,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (selectedDate != null) {
                          print(
                              "Selected Start Date: ${selectedDate.toLocal()}");
                          String value =
                              DateConverter.formatDate(selectedDate.toLocal());
                          authController.selectedStartDate = selectedDate;
                          authController.startDateController.text = value;

                          // Reset ending date if it's before the newly selected start date
                          if (authController.selectedEndDate != null &&
                              authController.selectedEndDate!
                                  .isBefore(selectedDate)) {
                            authController.selectedEndDate = null;
                            authController.endDayController.clear();
                          }
                        } else {
                          showCustomSnackBar("Please select a Start Date",
                              isError: true);
                        }
                      },
                      onChanged: (value) {},
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IntrinsicHeight(
                    child: CustomTextField(
                      controller: authController.endDayController,
                      readOnly: true,
                      suffixIcon: const Icon(
                        CupertinoIcons.calendar,
                        size: 18,
                        color: Colors.grey,
                      ),
                      hintText: 'Ending Date',
                      onTap: () async {
                        if (authController.startDateController.text == "") {
                          showCustomSnackBar(
                              "Please select a starting date first",
                              isError: true);
                          return;
                        }

                        DateTime firstAllowedDate =
                            authController.selectedStartDate!;
                        DateTime lastAllowedDate =
                            DateTime(DateTime.now().year);

                        DateTime? selectedDate = await showDatePicker(
                          context: Get.context!,
                          initialDate: firstAllowedDate.add(Duration(days: 1)),
                          firstDate: firstAllowedDate
                              .add(Duration(days: 1)), // Disable past dates
                          lastDate: lastAllowedDate,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                  secondary: Colors.red,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (selectedDate != null) {
                          print("Selected End Date: ${selectedDate.toLocal()}");
                          authController.selectedEndDate = selectedDate;
                          String value =
                              DateConverter.formatDate(selectedDate.toLocal());
                          authController.endDayController.text = value;
                        } else {
                          showCustomSnackBar("Please select a date",
                              isError: true);
                        }
                      },
                      onChanged: (value) {},
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
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
            controller: authController.companyOrganisationController,
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
            controller: authController.designationController,
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
            controller: authController.monthlyIncomeController,
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
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                )),
                // Spacer(),

                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (authController.experience == null ||
                              authController.experience == 0) {
                            authController.updateSiblings(0);
                          } else {
                            authController.updateExperience(
                                (authController.experience ?? 0) - 1);
                          }
                        },
                        child: Container(
                          // width: 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color:
                                //Color(0xFF86413F),
                                authController.experience == null ||
                                        authController.experience == 0 ||
                                        (authController.experience ?? 0) < 0
                                    ? Color(0xFFBA7270)
                                    : Color(0xFF86413F),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 10),
                            child: Center(
                                child: Text(
                              "-",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          authController.noOfYears ?? "0",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((authController.experience ?? 0) < 30) {
                            authController.updateExperience(
                                (authController.experience ?? 0) + 1);
                          }
                        },
                        child: Container(
                          // width: 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: authController.experience == null ||
                                    authController.experience == 30 ||
                                    (authController.experience ?? 30) >= 30
                                ? Color(0xFFBA7270)
                                : Color(0xFF86413F),

                            // isLightColor ? Color(0xFFBA7270) : Color(0xFF86413F),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 10),
                            child: Center(
                                child: Text(
                              "+",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
    );
  }
}
