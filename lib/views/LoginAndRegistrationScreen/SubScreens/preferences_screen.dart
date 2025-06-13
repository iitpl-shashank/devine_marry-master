import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/AuthController/auth_controller.dart';
import '../../../utils/string_texts.dart';
import '../../../utils/styles.dart';
import '../../../utils/themes/app_colors.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/number_picker_custom.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.stateResponse.states.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 91),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringTexts.partnerPreferences,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.darkTheme,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        StringTexts.YouCanUpdateTheData,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize:
                              DmSansRegular.copyWith(fontSize: 12).fontSize,
                          // fontFamily: 'DM Sans',
                          fontWeight: DmSansBold.fontWeight,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: Get.size.width,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 21),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringTexts.set_preferences.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.darkTheme,
                                fontSize: DmSansRegular.copyWith(fontSize: 14)
                                    .fontSize,
                                // fontFamily: 'DM Sans',
                                fontWeight: DmSansBold.fontWeight,
                              ),
                            ),
                          ],
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
                                controller: controller.prefMinAgeController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Age (in Yrs)",
                                    context: context,
                                    maxHeight: 254,
                                    initialHeight: 25,
                                    onHeightSelected: (value) {
                                      controller.prefMinAgeController.text =
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
                                hintText: 'Max Age',
                                readOnly: true,
                                suffixText: "Yrs",
                                inputType: TextInputType.number,
                                isAmount: true,
                                controller: controller.prefMaxAgeController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Age (in Yrs)",
                                    context: context,
                                    maxHeight: 254,
                                    initialHeight: 25,
                                    onHeightSelected: (value) {
                                      controller.prefMaxAgeController.text =
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
                                      controller.prefMinHeightController.text =
                                          value.toString();
                                    },
                                    initialHeight: 170,
                                  );
                                },
                                hintText: 'Min Height',
                                inputType: TextInputType.number,
                                suffixText: "cm",
                                isAmount: true,
                                controller: controller.prefMinHeightController,
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
                                      controller.prefMaxHeightController.text =
                                          value.toString();
                                    },
                                    initialHeight: 170,
                                  );
                                },
                                hintText: 'Max Height',
                                inputType: TextInputType.number,
                                suffixText: "cm",
                                isAmount: true,
                                controller: controller.prefMaxHeightController,
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
                                options: [
                                  'Select All',
                                  ...controller.religionResponse.religions
                                      .map((religions) => religions.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues: controller.prefReligion,
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      controller
                                          .updatePrefReligion(['Select All']);
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
                                      controller.updatePrefReligion(filtered);
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
                                    controller.updatePrefReligion([]);
                                    controller.getCasteList([]);
                                  }
                                  controller.updateCasteList([]);
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
                                options: [
                                  'Select All',
                                  ...controller.casteListResponse.castes
                                      .map((castes) => castes.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues: controller.prefCaste,
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      controller
                                          .updateCasteList(['Select All']);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      controller.updateCasteList(filtered);
                                    }
                                  } else {
                                    controller.updateCasteList([]);
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
                                selectedValue: controller.prefSmokingHabit,
                                hintText: 'Smoking Habit',
                                options: controller.dataModel.smoking
                                    .map((smoking) => smoking.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller
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
                                selectedValue: controller.prefDrinkingHabit,
                                options: controller.dataModel.drinking
                                    .map((drinking) => drinking.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller
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
                                selectedValues: controller.prefCountry,
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
                                      controller
                                          .updateCountryList(['Select All']);
                                      controller.getStatesList(
                                        controller.countryResponse.countries
                                            .map((element) =>
                                                element.id.toString())
                                            .toList(),
                                      );
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      controller.updateCountryList(filtered);
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
                                    controller.updateCountryList([]);
                                    controller.getStatesList([]);
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
                                selectedValues: controller.prefState,
                                options: [
                                  'Select All',
                                  ...controller.stateResponse.states
                                      .map((states) => states.name)
                                ].toList(),
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      controller
                                          .updatePrefState(['Select All']);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      controller.updatePrefState(filtered);
                                    }
                                  } else {
                                    controller.updatePrefState([]);
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
                                hintText: 'Qualification',
                                options: [
                                  'Select All',
                                  ...controller.dataModel.qualifications.map(
                                      (qualification) => qualification.name)
                                ].toList(),
                                isMultiple: true,
                                selectedValues:
                                    controller.prefHighestQualification,
                                onChanged: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains('Select All')) {
                                      controller.updatePrefQualification(
                                          ['Select All']);
                                    } else {
                                      List<String> filtered =
                                          List<String>.from(value)
                                            ..remove('Select All');
                                      controller
                                          .updatePrefQualification(filtered);
                                    }
                                  } else {
                                    controller.updatePrefQualification([]);
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
                                hintText: 'Complexion',
                                options: controller.dataModel.complexion
                                    .map((complexion) => complexion.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues: controller.prefComplexion,
                                onChanged: (value) {
                                  debugPrint("value===> $value");
                                  controller.updatePrefComplexion(value ?? "");
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21),
            ],
          ),
        ),
      );
    });
  }
}
