import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/models/component_models/user_atributes.dart';
import 'package:devine_marry/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/date_converter.dart';
import '../../../utils/string_texts.dart';
import '../../../utils/styles.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_text_field.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

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
                      maxLines: 1,
                      StringTexts.educationAndProfession,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF86413F),
                        fontSize: 28,
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
                        StringTexts.youCanUpdateTheDataFromProfileScreen,
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
                              StringTexts.EDUCATION_DETAILS,
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
                                hintText: 'Highest Qualification',
                                options: controller.dataModel.qualifications
                                    .map((qualification) => qualification.name)
                                    .toList(),
                                selectedValue: controller.highestQualification,
                                onChanged: (value) {
                                  controller
                                      .updateHighestQualification(value ?? "");
                                  if(value != "High School" && value != "Intermediate"){
                                    controller.updateDegree(null);
                                    controller.getDegrees();
                                  } else {
                                    controller.updateDegree(null);
                                    controller.degreeResponse = DegreeResponse(Degrees: []);
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
                          controller: controller.schoolUniversityController,
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
                          visible: controller.degreeResponse.Degrees.isNotEmpty,
                          child: Row(
                            children: [
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Degree',
                                  options: controller.degreeResponse.Degrees
                                      .map((degrees) => degrees.name)
                                      .toList(),
                                  selectedValue: controller.degree,
                                  onChanged: (value) {
                                    controller.updateDegree(value ?? "");
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
                          visible: controller.degreeResponse.Degrees.isNotEmpty,
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
                                    controller: controller.startDateController,
                                    readOnly: true,
                                    suffixIcon: const Icon(
                                      CupertinoIcons.calendar,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Starting Date',
                                    onTap: () async {
                                      DateTime currentDate = DateTime.now();
                                      DateTime firstAllowedDate = DateTime(currentDate.year - 100);
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
                                        print("Selected Start Date: ${selectedDate.toLocal()}");
                                        String value = DateConverter.formatDate(selectedDate.toLocal());
                                        controller.selectedStartDate = selectedDate;
                                        controller.startDateController.text = value;

                                        // Reset ending date if it's before the newly selected start date
                                        if (controller.selectedEndDate != null &&
                                            controller.selectedEndDate!.isBefore(selectedDate)) {
                                          controller.selectedEndDate = null;
                                          controller.endDayController.clear();
                                        }
                                      } else {
                                        showCustomSnackBar("Please select a Start Date", isError: true);
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
                                    controller: controller.endDayController,
                                    readOnly: true,
                                    suffixIcon: const Icon(
                                      CupertinoIcons.calendar,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Ending Date',
                                    onTap: () async {
                                      if (controller.startDateController.text == "") {
                                        showCustomSnackBar("Please select a starting date first",
                                            isError: true);
                                        return;
                                      }

                                      DateTime firstAllowedDate = controller.selectedStartDate!;
                                      DateTime lastAllowedDate = DateTime(DateTime.now().year);

                                      DateTime? selectedDate = await showDatePicker(
                                        context: Get.context!,
                                        initialDate: firstAllowedDate.add(Duration(days: 1)),
                                        firstDate: firstAllowedDate.add(Duration(days: 1)), // Disable past dates
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
                                        controller.selectedEndDate = selectedDate;
                                        String value = DateConverter.formatDate(selectedDate.toLocal());
                                        controller.endDayController.text =
                                            value;
                                      } else {
                                        showCustomSnackBar("Please select a date", isError: true);
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
                              StringTexts.PROFESSION_DETAIL,
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
                        CustomTextField(
                          controller: controller.companyOrganisationController,
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
                          controller: controller.designationController,
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
                          controller: controller.monthlyIncomeController,
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
                                        if (controller.experience == null ||
                                            controller.experience == 0) {
                                          controller.updateSiblings(0);
                                        } else {
                                          controller.updateExperience(
                                              (controller.experience ?? 0) - 1);
                                        }
                                      },
                                      child: Container(
                                        // width: 1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color:
                                              //Color(0xFF86413F),
                                              controller.experience == null ||
                                                      controller.experience ==
                                                          0 ||
                                                      (controller.experience ??
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        controller.noOfYears ?? "0",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if ((controller.experience ?? 0) < 30) {
                                          controller.updateExperience(
                                              (controller.experience ?? 0) + 1);
                                        }
                                      },
                                      child: Container(
                                        // width: 1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: controller.experience == null ||
                                                  controller.experience == 30 ||
                                                  (controller.experience ?? 30) >=
                                                      30
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
