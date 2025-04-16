import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/string_texts.dart';
import '../../../utils/styles.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/image_picker_widget.dart';
import '../../../widgets/number_picker_custom.dart';

class PersonalityScreen extends StatelessWidget {
  const PersonalityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.transparent,
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
                      StringTexts.Personality_Attributes,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF86413F),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
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
                          color: Color(0xFF212121),
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
                              StringTexts.Personality_Details,
                              style: TextStyle(
                                color: Color(0xFF86413F),
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
                              child: CustomDropdownField(
                                hintText: 'Complexion',
                                options: controller.dataModel.complexion
                                    .map((complexion) => complexion.name)
                                    .toList(),
                                selectedValue: controller.complexion,
                                onChanged: (value) {
                                  controller.updateComplexion(value ?? "");
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
                                selectedValue: controller.bloodGroup,
                                onChanged: (value) {
                                  controller.updateBloodGroup(value ?? "");
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
                                controller: controller.heightController,
                                onChanged: (value) {},
                                onTap: () {
                                  showHeightPickerDialog(
                                    context: context,
                                    maxHeight: 254,
                                    onHeightSelected: (value) {
                                      controller.heightController.text =
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
                                    context: context,
                                    maxHeight: 150,
                                    onHeightSelected: (value) {
                                      controller.weightController.text =
                                          value.toString();
                                    },
                                    initialHeight: 25,
                                  );
                                },
                                hintText: 'Weight',
                                inputType: TextInputType.number,
                                suffixText: "Kg",

                                // suffixIcon: Text(
                                //   "Kg",
                                //   style: TextStyle(
                                //     color: Color(0xFFBA7270),
                                //     fontSize: 16,
                                //     fontFamily: 'DM Sans',
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                isAmount: true,
                                controller: controller.weightController,
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
                                controller: controller.hairController,
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
                                controller: controller.eyeColorController,
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
                                selectedValue: controller.smokingHabit,
                                hintText: 'Smoking Habit',
                                options: controller.dataModel.smoking
                                    .map((smoking) => smoking.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller.updateSmokingHabit(value ?? "");
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
                                selectedValue: controller.drinkingHabit,
                                options: controller.dataModel.smoking
                                    .map((drinking) => drinking.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller.updateDrinkingHabit(value ?? "");
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
                                selectedValue: controller.disability,
                                options: controller.dataModel.disabilities
                                    .map((drinking) => drinking.name)
                                    .toList(),
                                onChanged: (value) {
                                  controller.updateDisability(value ?? "");
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
                                controller: controller.bioController,
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
                                controller: controller.interestController,
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
                      ],
                    ),
                  ),
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
                              StringTexts.Preferrences,
                              style: TextStyle(
                                color: Color(0xFF86413F),
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
                                hintText: 'Country',
                                options: controller.countryResponse.countries
                                    .map((country) => country.name)
                                    .toList(),
                                isMultiple: true,
                                selectedValues: controller.prefCountry,
                                onChanged: (value) {
                                  controller.updatePrefCountry(value ?? "");
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
