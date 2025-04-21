import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              StringTexts.personalDetails.toUpperCase(),
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
                    hintText: 'Looking For',
                    options: authController.lookingForList
                        .map((looking) => looking.title)
                        .toList(),
                    selectedValue: profileController.lookingFor,
                    onChanged: (value) {
                      profileController.updateLookingFor(value ?? "");
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
                    hintText: 'Marital Status',
                    options: authController.dataModel.maritalStatuses
                        .map((religions) => religions.title)
                        .toList(),
                    selectedValue: authController.maritalStatus,
                    onChanged: (value) {
                      authController.updateMaritalStatusFor(value ?? "");
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
                    hintText: 'First Name',
                    controller: authController.hairController,
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
                    hintText: 'Last Name',
                    controller: authController.eyeColorController,
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
                    hintText: 'Religion',
                    selectedValue: authController.religion,
                    options: authController.religionResponse.religions
                        .map((religions) => religions.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updateReligion(value ?? "");
                      authController.getCastes(authController
                          .religionResponse.religions
                          .firstWhere((element) => element.name == value)
                          .id
                          .toString());
                      authController.updateCaste(null);
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
                    hintText: 'Caste',
                    selectedValue: authController.caste,
                    options: authController.casteResponse.castes
                        .map((caste) => caste.name)
                        .toList(),
                    onChanged: (value) {
                      debugPrint("value ==> $value");
                      authController.updateCaste(value ?? "");
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
                    selectedValue: authController.country,
                    hintText: 'Country',
                    options: authController.countryResponse.countries
                        .map((country) => country.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updateCountry(value ?? "");
                      authController.getStates(authController
                          .countryResponse.countries
                          .firstWhere((element) => element.name == value)
                          .id
                          .toString());
                      authController.updateState(null);
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
                    hintText: 'State',
                    selectedValue: authController.state,
                    options: authController.stateResponse.states
                        .map((states) => states.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updateState(value ?? "");
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IntrinsicHeight(
                      child: CustomTextField(
                        controller: authController.dobController,
                        readOnly: true,
                        suffixIcon: const Icon(
                          CupertinoIcons.calendar,
                          size: 18,
                          color: Colors.grey,
                        ),
                        hintText: 'D.O.B',
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime firstAllowedDate =
                              DateTime(currentDate.year - 100);
                          DateTime lastAllowedDate =
                              DateTime(currentDate.year - 18);

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
                            print("Selected Date: ${selectedDate.toLocal()}");
                            authController
                                .updateDob(selectedDate.toString() ?? "");
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
                SizedBox(width: 13),
                Flexible(
                  child: IntrinsicHeight(
                    child: CustomDropdownField(
                      hintText: 'Gender',
                      options: authController.dataModel.genders
                          .map((religions) => religions.gender)
                          .toList(),
                      selectedValue: authController.gender,
                      onChanged: (value) {
                        authController.updateGender(value ?? "");
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
