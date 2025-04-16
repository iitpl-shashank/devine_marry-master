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

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder <AuthController>(
      builder: (controller) {
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
                        StringTexts.createAccount,
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
                          StringTexts.fillDetailsToStartYourJourney,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: DmSansRegular.copyWith(fontSize: 12).fontSize,
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
                                StringTexts.PROFILE_DETAILS,
                                style: TextStyle(
                                  color: Color(0xFF86413F),
                                  fontSize:
                                      DmSansRegular.copyWith(fontSize: 14).fontSize,
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
                                  hintText: 'Looking For',
                                  options: controller.lookingForList.map((looking) => looking.title).toList(),
                                  selectedValue: controller.lookingFor,
                                  onChanged: (value) {
                                    controller.updateLookingFor(value ?? "");
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an option';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 13,),
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Marital Status',
                                  options: controller.dataModel.maritalStatuses.map((religions) => religions.title).toList(),
                                  selectedValue: controller.maritalStatus,
                                  onChanged: (value) {
                                    controller.updateMaritalStatusFor(value ?? "");
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
                            hintText: 'First Name',
                            controller: controller.firstNameController,
                            onChanged: (value) {

                            },
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextField(
                            hintText: 'Last Name',
                            controller:  controller.lastNameController,
                            onChanged: (value) {},
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Religion',
                                  selectedValue: controller.religion,
                                  options: controller.religionResponse.religions.map((religions) => religions.name).toList(),
                                  onChanged: (value) {
                                    controller.updateReligion(value ?? "");
                                    controller.getCastes(controller.religionResponse.religions.firstWhere((element) => element.name == value).id.toString());
                                    controller.updateCaste(null);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an option';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 13,),
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'Caste',
                                  selectedValue: controller.caste,
                                  options: controller.casteResponse.castes.map((caste) => caste.name).toList(),
                                  onChanged: (value) {
                                    debugPrint("value ==> $value");
                                    controller.updateCaste(value ?? "");
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
                                  selectedValue: controller.country,
                                  hintText: 'Country',
                                  options: controller.countryResponse.countries.map((country) => country.name).toList(),
                                  onChanged: (value) {
                                    controller.updateCountry(value ?? "");
                                    controller.getStates(controller.countryResponse.countries.firstWhere((element) => element.name == value).id.toString());
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
                              SizedBox(width: 13,),
                              Flexible(
                                child: CustomDropdownField(
                                  hintText: 'State',
                                  selectedValue: controller.state,
                                  options: controller.stateResponse.states.map((states) => states.name).toList(),
                                  onChanged: (value) {
                                    controller.updateState(value ?? "");
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
                                      controller:  controller.dobController,
                                      readOnly: true,
                                      suffixIcon: const Icon(
                                        CupertinoIcons.calendar,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'D.O.B',
                                      onTap: () async {
                                        DateTime currentDate = DateTime.now();
                                        DateTime firstAllowedDate = DateTime(currentDate.year - 100); // Allows up to 100 years back
                                        DateTime lastAllowedDate = DateTime(currentDate.year - 18); // Minimum age 18 years

                                        DateTime? selectedDate = await showDatePicker(
                                          context: Get.context!,
                                          initialDate: lastAllowedDate,
                                          firstDate: firstAllowedDate,
                                          lastDate: lastAllowedDate,
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Theme.of(context).primaryColor, // Header background & selected date color
                                                  onPrimary: Colors.white, // Header text color
                                                  onSurface: Colors.black, // Default text color
                                                  secondary: Colors.red, // **Changes the selected date color**
                                                ),
                                                textButtonTheme: TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.black, // Button text color
                                                  ),
                                                ),
                                                dialogBackgroundColor: Colors.white, // Background color of the calendar
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (selectedDate != null) {
                                          print("Selected Date: ${selectedDate.toLocal()}");
                                          controller.updateDob(selectedDate.toString() ?? "");
                                        }else {
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

                              SizedBox(width: 13),
                              Flexible(
                                child: IntrinsicHeight(
                                  child: CustomDropdownField(
                                    hintText: 'Gender',
                                    options: controller.dataModel.genders.map((religions) => religions.gender).toList(),
                                    selectedValue: controller.gender,
                                    onChanged: (value) {
                                      controller.updateGender(value ?? "");
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
                          SizedBox(height: 20),
                          ProfileImageUploader(onImageSelected: (String value) {
                            controller.updateProfilePhoto(value);

                          },initialImageUrl: controller.profilePhoto,),
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
                                StringTexts.Family_Details,
                                style: TextStyle(
                                  color: Color(0xFF86413F),
                                  fontSize:
                                      DmSansRegular.copyWith(fontSize: 14).fontSize,
                                  // fontFamily: 'DM Sans',
                                  fontWeight: DmSansBold.fontWeight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 17),
                          CustomTextField(
                            controller: controller.fathersNameController,
                            hintText: 'Father’s Name',
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
                            controller: controller.fathersProfessionController,
                            hintText: 'Father’s Profession',
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
                            controller: controller.motherNameController,
                            hintText: 'Mother Name',
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
                            controller: controller.motherProfessionController,
                            hintText: 'Mother Profession',
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
                                Flexible(child: Text("Number of Siblings",

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
                                    onTap: (){
                                      if(controller.siblings == null || controller.siblings == 0){
                                        controller.updateSiblings(0);
                                      } else {
                                          controller.updateSiblings(
                                              (controller.siblings ?? 0) - 1);
                                        }
                                      },
                                    child: Container(
                                      // width: 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color:
                                        //Color(0xFF86413F),
                                        controller.siblings == null || controller.siblings == 0 || (controller.siblings ?? 0) < 0 ? Color(0xFFBA7270) : Color(0xFF86413F),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 13.0,vertical: 10),
                                        child: Center(child: Text("-",style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(controller.numberOfSiblings ?? "0",),
                                  ),
                                      GestureDetector(
                                        onTap: (){
                                          if((controller.siblings ?? 0) < 10){
                                            controller.updateSiblings(
                                                (controller.siblings ?? 0) + 1);
                                          }

                                        },
                                    child: Container(
                                      // width: 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color:  controller.siblings == null || controller.siblings == 10 || (controller.siblings ?? 10) >= 10 ? Color(0xFFBA7270) : Color(0xFF86413F),

                                        // isLightColor ? Color(0xFFBA7270) : Color(0xFF86413F),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 13.0,vertical: 10),
                                        child: Center(child: Text("+",style: TextStyle(color: Colors.white,fontSize: 12),)),
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
      }
    );
  }
}
