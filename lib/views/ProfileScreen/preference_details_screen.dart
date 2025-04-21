import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/number_picker_custom.dart';

class PreferenceDetailsScreen extends StatefulWidget {
  const PreferenceDetailsScreen({super.key});

  @override
  State<PreferenceDetailsScreen> createState() =>
      _PreferenceDetailsScreenState();
}

class _PreferenceDetailsScreenState extends State<PreferenceDetailsScreen> {
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
              StringTexts.Preferences.toUpperCase(),
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
                  child: CustomTextField(
                    hintText: 'Age',
                    readOnly: true,
                    suffixText: "Yrs",
                    inputType: TextInputType.number,
                    isAmount: true,
                    controller: authController.prefAgeController,
                    onChanged: (value) {},
                    onTap: () {
                      showHeightPickerDialog(
                        title: "Select Age (in Yrs)",
                        context: context,
                        maxHeight: 254,
                        initialHeight: 25,
                        onHeightSelected: (value) {
                          authController.prefAgeController.text =
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
                        title: "Select Height (in cm)",
                        context: context,
                        maxHeight: 200,
                        onHeightSelected: (value) {
                          authController.prefHeightController.text =
                              value.toString();
                        },
                        initialHeight: 25,
                      );
                    },
                    hintText: 'Height',
                    inputType: TextInputType.number,
                    suffixText: "cm",
                    isAmount: true,
                    controller: authController.prefHeightController,
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'Religion',
                    options: authController.religionResponse.religions
                        .map((religions) => religions.name)
                        .toList(),
                    isMultiple: true,
                    selectedValues: authController.prefReligion,
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        authController.updatePrefReligion(value);
                        authController.getCasteList(
                          authController.religionResponse.religions
                              .where((element) => value.contains(element.name))
                              .map((element) => element.id.toString())
                              .toList(),
                        );
                      } else {
                        authController.updatePrefReligion([]);
                        authController.getCasteList([]);
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'Caste',
                    options: authController.casteListResponse.castes
                        .map((castes) => castes.name)
                        .toList(),
                    isMultiple: true,
                    selectedValues: authController.prefCaste,
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        authController.updateCasteList(value);
                      } else {
                        authController.updatePrefReligion([]);
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    selectedValue: authController.prefSmokingHabit,
                    hintText: 'Smoking Habit',
                    options: authController.dataModel.smoking
                        .map((smoking) => smoking.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updatePrefSmokingHabit(value ?? "");
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
                    hintText: 'Drinking Habit',
                    selectedValue: authController.prefDrinkingHabit,
                    options: authController.dataModel.drinking
                        .map((drinking) => drinking.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updatePrefDrinkingHabit(value ?? "");
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'Complexion',
                    options: authController.dataModel.complexion
                        .map((complexion) => complexion.name)
                        .toList(),
                    isMultiple: true,
                    selectedValues: authController.prefComplexion,
                    onChanged: (value) {
                      debugPrint("value===> $value");
                      authController.updatePrefComplexion(value ?? "");
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    selectedValues: authController.prefCountry,
                    isMultiple: true,
                    hintText: 'Country',
                    options: authController.countryResponse.countries
                        .map((country) => country.name)
                        .toList(),
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        authController.updateCountryList(value);
                        List<String> countryIds = authController
                            .countryResponse.countries
                            .where((element) => value.contains(element.name))
                            .map((element) => element.id.toString())
                            .toList();
                        authController.getStatesList(countryIds);
                      } else {
                        authController.updateStateList([]);
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'State',
                    isMultiple: true,
                    selectedValues: authController.prefState,
                    options: authController.stateResponse.states
                        .map((states) => states.name)
                        .toList(),
                    onChanged: (value) {
                      authController.updatePrefState(value ?? "");
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
            SizedBox(height: 17),
            Row(
              children: [
                Flexible(
                  child: CustomDropdownField(
                    hintText: 'Qualification',
                    options: authController.dataModel.qualifications
                        .map((qualification) => qualification.name)
                        .toList(),
                    isMultiple: true,
                    selectedValues: authController.prefHighestQualification,
                    onChanged: (value) {
                      debugPrint("value===> $value");
                      authController.updatePrefQualification(value ?? "");
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
          ])),
    );
  }
}
