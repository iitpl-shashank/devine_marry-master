import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/AuthController/auth_controller.dart';
import '../../../utils/string_texts.dart';
import '../../../utils/styles.dart';
import '../../../utils/themes/app_colors.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/number_picker_custom.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

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
                      StringTexts.Preferences,
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
                                hintText: 'Age',
                                readOnly: true,
                                suffixText: "Yrs",
                                inputType: TextInputType.number,
                                isAmount: true,
                                controller: controller.prefAgeController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    title: "Select Age (in Yrs)",
                                    context: context,
                                    maxHeight: 254,
                                    initialHeight: 25,
                                    onHeightSelected: (value) {
                                      controller.prefAgeController.text =
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
                                      controller.prefHeightController.text =
                                          value.toString();
                                    },
                                    initialHeight: 25,
                                  );
                                },
                                hintText: 'Height',
                                inputType: TextInputType.number,
                                suffixText: "cm",
                                isAmount: true,
                                controller: controller.prefHeightController,
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
                                options: controller.religionResponse.religions
                                    .map((religions) => religions.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues: controller.prefReligion,
                                onChanged: (value) {
                                  controller.updatePrefReligion(value ?? "");
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
                                options: controller.religionResponse.religions
                                    .map((religions) => religions.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues: controller.prefReligion,
                                onChanged: (value) {
                                  controller.updatePrefReligion(value ?? "");
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
                                options: controller.dataModel.smoking
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
                                selectedValue: controller.country,
                                hintText: 'Country',
                                options: controller.countryResponse.countries
                                    .map((country) => country.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller.updateCountry(value ?? "");
                                  controller.getStates(controller
                                      .countryResponse.countries
                                      .firstWhere(
                                          (element) => element.name == value)
                                      .id
                                      .toString());
                                  controller.updateState(null);
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
                                options: controller.stateResponse.states
                                    .map((states) => states.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller.updatePrefState(value ?? "");
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
                                options: controller.dataModel.qualifications
                                    .map((qualification) => qualification.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues:
                                    controller.prefHighestQualification,
                                onChanged: (value) {
                                  debugPrint("value===> $value");
                                  controller
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
                                selectedValues:
                                    controller.prefComplexion,
                                onChanged: (value) {
                                  debugPrint("value===> $value");
                                  controller
                                      .updatePrefComplexion(value ?? "");
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
