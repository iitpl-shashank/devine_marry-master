import 'package:devine_marry/widgets/common_loading.dart';
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

class PreferenceDetailsScreen extends StatefulWidget {
  const PreferenceDetailsScreen({super.key});

  @override
  State<PreferenceDetailsScreen> createState() =>
      _PreferenceDetailsScreenState();
}

class _PreferenceDetailsScreenState extends State<PreferenceDetailsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoading();
      await profileController.setPreferenceDetails();
      hideLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    profileController.updatePreferenceDetails();
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
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                hintText: 'Min Age',
                                readOnly: true,
                                suffixText: "Yrs",
                                inputType: TextInputType.number,
                                isAmount: true,
                                controller:
                                    profileController.prefMinAgeController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Age (in Yrs)",
                                    context: context,
                                    maxHeight: 254,
                                    initialHeight: int.parse(profileController
                                        .prefMinAgeController.text),
                                    onHeightSelected: (value) {
                                      profileController.prefMinAgeController
                                          .text = value.toString();
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
                                hintText: 'Max Age',
                                readOnly: true,
                                suffixText: "Yrs",
                                inputType: TextInputType.number,
                                isAmount: true,
                                controller:
                                    profileController.prefMaxAgeController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Age (in Yrs)",
                                    context: context,
                                    maxHeight: 254,
                                    initialHeight: int.parse(profileController
                                        .prefMaxAgeController.text),
                                    onHeightSelected: (value) {
                                      profileController.prefMaxAgeController
                                          .text = value.toString();
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
                          ],
                        ),
                        SizedBox(height: 17),
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                readOnly: true,
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Height (in cm)",
                                    context: context,
                                    maxHeight: 200,
                                    onHeightSelected: (value) {
                                      profileController.prefMinHeightController
                                          .text = value.toString();
                                    },
                                    initialHeight: int.parse(profileController
                                        .prefMinHeightController.text
                                        .toString()),
                                  );
                                },
                                hintText: 'Min Height',
                                inputType: TextInputType.number,
                                suffixText: "cm",
                                isAmount: true,
                                controller:
                                    profileController.prefMinHeightController,
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
                                readOnly: true,
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Height (in cm)",
                                    context: context,
                                    maxHeight: 200,
                                    onHeightSelected: (value) {
                                      profileController.prefMaxHeightController
                                          .text = value.toString();
                                    },
                                    initialHeight: int.parse(profileController
                                        .prefMaxHeightController.text
                                        .toString()),
                                  );
                                },
                                hintText: 'Max Height',
                                inputType: TextInputType.number,
                                suffixText: "cm",
                                isAmount: true,
                                controller:
                                    profileController.prefMaxHeightController,
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
                                key: ValueKey(profileController.prefReligion),
                                hintText: 'Religion',
                                options: [
                                  'Select All',
                                  ...controller.religionResponse.religions
                                      .map((religions) => religions.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues: profileController.prefReligion,
                                onChanged: (value) {
                                  debugPrint("Selected value: $value");
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      profileController
                                          .updatePrefReligion(['Select All']);
                                      profileController.updatePrefCasteList([]);
                                      controller.getCasteList(
                                        controller.religionResponse.religions
                                            .map((element) =>
                                                element.id.toString())
                                            .toList(),
                                      );
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      profileController
                                          .updatePrefReligion(filtered);
                                      profileController.updatePrefCasteList([]);
                                      controller.getCasteList(
                                        controller.religionResponse.religions
                                            .where((element) =>
                                                filtered.contains(element.name))
                                            .map((element) =>
                                                element.id.toString())
                                            .toList(),
                                      );
                                    }
                                  } else {
                                    profileController.updatePrefReligion([]);
                                    controller.getCasteList([]);
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
                                key: ValueKey(profileController.prefCaste),
                                hintText: 'Caste',
                                options: [
                                  'Select All',
                                  ...controller.casteListResponse.castes
                                      .map((castes) => castes.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues: profileController.prefCaste,
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      profileController
                                          .updatePrefCasteList(['Select All']);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      profileController
                                          .updatePrefCasteList(filtered);
                                    }
                                  } else {
                                    profileController.updatePrefCasteList([]);
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
                                selectedValue:
                                    profileController.prefSmokingHabit,
                                hintText: 'Smoking Habit',
                                options: controller.dataModel.smoking
                                    .map((smoking) => smoking.name)
                                    .toList(),
                                onChanged: (value) {
                                  profileController
                                      .updatePrefSmokingHabit(value ?? "");
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
                                selectedValue:
                                    profileController.prefDrinkingHabit,
                                options: controller.dataModel.drinking
                                    .map((drinking) => drinking.name)
                                    .toList(),
                                onChanged: (value) {
                                  profileController
                                      .updatePrefDrinkingHabit(value ?? "");
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
                                key: ValueKey(profileController.prefComplexion),
                                hintText: 'Complexion',
                                options: [
                                  'Select All',
                                  ...controller.dataModel.complexion
                                      .map((complexion) => complexion.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues:
                                    profileController.prefComplexion,
                                onChanged: (value) {
                                  debugPrint("value===> $value");
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      profileController
                                          .updatePrefComplexion(['Select All']);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      profileController
                                          .updatePrefComplexion(filtered);
                                    }
                                  } else {
                                    profileController.updatePrefComplexion([]);
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
                                key: ValueKey(profileController.prefCountry),
                                selectedValues: profileController.prefCountry,
                                isMultiple: true,
                                hintText: 'Country',
                                options: [
                                  'Select All',
                                  ...controller.countryResponse.countries
                                      .map((country) => country.name)
                                ].toList(),
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      profileController.updatePrefCountryList(
                                          ['Select All']);
                                      profileController.updatePrefStateList([]);
                                      List<String> countryIds = controller
                                          .countryResponse.countries
                                          .map((element) =>
                                              element.id.toString())
                                          .toList();
                                      controller.getStatesList(countryIds);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      profileController
                                          .updatePrefCountryList(filtered);
                                      profileController.updatePrefStateList([]);
                                      List<String> countryIds = controller
                                          .countryResponse.countries
                                          .where((element) =>
                                              filtered.contains(element.name))
                                          .map((element) =>
                                              element.id.toString())
                                          .toList();
                                      controller.getStatesList(countryIds);
                                    }
                                  } else {
                                    profileController.updatePrefCountryList([]);
                                    profileController.updatePrefStateList([]);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an option';
                                  }
                                  return null;
                                },
                              ),
                              // CustomDropdownField(
                              //   key: ValueKey(profileController.prefCountry),
                              //   selectedValues: profileController.prefCountry,
                              //   isMultiple: true,
                              //   hintText: 'Country',
                              //   options: controller.countryResponse.countries
                              //       .map((country) => country.name)
                              //       .toList(),
                              //   onChanged: (value) {
                              //     if (value != null && value.isNotEmpty) {
                              //       profileController
                              //           .updatePrefCountryList(value);
                              //       profileController.updatePrefStateList([]);
                              //       List<String> countryIds = controller
                              //           .countryResponse.countries
                              //           .where((element) =>
                              //               value.contains(element.name))
                              //           .map((element) => element.id.toString())
                              //           .toList();
                              //       controller.getStatesList(countryIds);
                              //     } else {
                              //       profileController.updatePrefStateList([]);
                              //     }
                              //   },
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please select an option';
                              //     }
                              //     return null;
                              //   },
                              // ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
                        Row(
                          children: [
                            Flexible(
                              child: CustomDropdownField(
                                key: ValueKey(profileController.prefState),
                                hintText: 'State',
                                isMultiple: true,
                                selectedValues: profileController.prefState,
                                options: controller.stateResponse.states
                                    .map((states) => states.name)
                                    .toList(),
                                onChanged: (value) {
                                  profileController
                                      .updatePrefStateList(value ?? "");
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
                                key: ValueKey(
                                    profileController.prefHighestQualification),
                                hintText: 'Qualification',
                                options: controller.dataModel.qualifications
                                    .map((qualification) => qualification.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues:
                                    profileController.prefHighestQualification,
                                onChanged: (value) {
                                  debugPrint("value===> $value");
                                  profileController
                                      .updatePrefQualification(value ?? "");
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
                      ]),
                )),
          ),
        );
      },
    );
  }
}
