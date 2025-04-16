import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/helper/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../helper/route_helper.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/styles.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_snack_bar.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with CodeAutoFill {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpController.text = code ?? ''; // Autofill the OTP
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        // appBar: AppBar(title: const Text("OTP Verification")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 228),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringTexts.Otp_Verification,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 32,
                      // fontFamily: 'DM Sans',
                      fontWeight: DmSansBold.fontWeight,
                      // height: 1.40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringTexts.enterOtpNumber,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF212121),
                      fontSize: DmSansRegular.copyWith(fontSize: 16).fontSize,
                      // fontFamily: 'DM Sans',
                      fontWeight: DmSansBold.fontWeight,
                      // height: 1.40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PinFieldAutoFill(
                controller: _otpController,
                inputFormatters: [
                  ValidatorAndInputFormatters.numericInputFormatter(),
                ],
                codeLength: 6,
                // Change according to your OTP length
                decoration: BoxLooseDecoration(
                  hintText: StringTexts.hintText,
                  gapSpace: 10,
                  hintTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  bgColorBuilder: FixedColorBuilder(Colors.white),
                  strokeColorBuilder:
                      PinListenColorBuilder(Colors.white, Colors.white),
                ),
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    print("OTP Entered: $code");
                  }
                },
              ),
              SizedBox(height: 32),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return CommonButton(
                    isLightColor: true,
                    text: controller.isLoginLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Text(StringTexts.next, style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () {
                      // Get.toNamed(RouteHelper.register);
                      if(_otpController.text.length == 6){
                        showCustomSnackBar(StringTexts.Please_Wait_while_we_verify_your_OTP,
                            isError: false,isPending: true);
                        String otp = _otpController.text;
                        Get.find<AuthController>().verifyOtpApi(otp);} else {
                        showCustomSnackBar(StringTexts.Please_enter_a_valid_OTP, isError: true);
                      }
                    },
                    isShowIcon: false,
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
