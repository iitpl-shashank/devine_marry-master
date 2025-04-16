import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:devine_marry/helper/validations.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:devine_marry/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/login_text_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<AuthController>().loginFormKey,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(Images.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(height: 228),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringTexts.login,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 32,
                      fontWeight: DmSansBold.fontWeight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      StringTexts.enterYourPhoneNumber,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: const Color(0xFF212121),
                        fontSize: DmSansRegular.copyWith(fontSize: 16).fontSize,
                        fontWeight: DmSansBold.fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GetBuilder<AuthController>(
                builder: (loginController) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LoginTextField(
                      maxLength: 10,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ValidatorAndInputFormatters.numericInputFormatter(),
                      ],
                      controller: loginController.phoneController,
                      hintText: StringTexts.phoneNumber,
                      onChanged: (number) {
                        loginController.changePhoneNumber(number);
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          StringTexts.suffixText,
                          style: TextStyle(
                            color: const Color(0xFF212121),
                            fontSize: DmSansRegular.copyWith(fontSize: 16).fontSize,
                            fontWeight: DmSansBold.fontWeight,
                          ),
                        ),
                      ),
                      validator: (value) {
                        debugPrint("Phone number: $value");
                        if (value == null || value.isEmpty) {
                          return StringTexts.phone_cannot_be_empty; // Updated error message
                        } else if (!ValidatorAndInputFormatters.isValidIndianPhoneNumber(value)) {
                          return StringTexts.Enter_Valid_Phone_Number; // Ensures proper validation
                        }
                        return null;
                      },
                      focusNode: loginController.phoneFocus,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CommonButton(
                      isLightColor: true,
                      text: Get.find<AuthController>().isLoginLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Text(StringTexts.next, style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () {
                        if (Get.find<AuthController>().loginFormKey.currentState!.validate()) {
                          Get.find<AuthController>().sendOtpApi();
                        } else {
                          showCustomSnackBar(StringTexts.Enter_Valid_Phone_Number, isError: true);
                        }
                      },
                      isShowIcon: false,
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}