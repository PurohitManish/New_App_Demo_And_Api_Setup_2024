import 'package:EasyLocker/app/authscreen/auth_controller.dart';
import 'package:EasyLocker/app/homescreen.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/enums.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final bool back;
  final String mobileNumber;
  final String countryCode;
  final String verificationId;
  final String token;
  final bool fromContactPhone;
  final ScreenOperation screenOps;

  OtpScreen(
      {super.key,
      this.back = false,
      required this.mobileNumber,
      required this.countryCode,
      required this.verificationId,
      required this.token,
      required this.fromContactPhone,
      required this.screenOps});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  final authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  final TextEditingController pinCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homebackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.homebackgroundColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(Assets.backbutton)),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            SvgPicture.asset(
              Assets.app_logo,
              height: 100,
            ),
            kHeight(50),
            PrimaryText(
              text: 'Enter Verification Code',
              color: AppColors.icontextColor,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            kHeight(5),
            PrimaryText(
              text:
                  'We are automatically detecting a SMS send to your mobile number 517-699-3085',
              color: AppColors.white,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            kHeight(20),
            Pinput(
              controller: pinCodeController,
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.searchbarColors,
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(
                  //   color: Colors.purple.shade200,
                  // ),
                ),
                textStyle: TextStyle(
                  fontSize: 30,
                  color: AppColors.searchbartextColors,
                ),
              ),
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            kHeight(15),
            // const SizedBox(height: 25),
            Row(
              children: [
                PrimaryText(
                  text: 'Didn’t get code? ',
                  color: AppColors.white,
                  size: 14,
                ),
                PrimaryText(
                  text: 'Resend',
                  color: AppColors.icontextColor,
                  size: 14,
                ),
              ],
            ),
            kHeight(40),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: CustomButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                // text: "Verify",
                onPressed: () async {
                  if (otpCode != null) {
                    // verifyOtp(context, otpCode!);
                    // Get.to(() => Home_Screen());

                    print("country code from otp : $widget. countryCode");
                    authController.verifyOTP(
                      context,
                      verificationId: widget.verificationId,
                      smsCode: pinCodeController.text,
                      phoneNumber: widget.mobileNumber,
                      countryCode: widget.countryCode,
                      screenOps: widget.screenOps,
                      fromContactPhone: widget.fromContactPhone,
                    ); //

                    // back ? Get.back() : AppRoutes.navigateOffModuleSelector();
                  } else {
                    showSnackBar(context, "Enter 6-Digit code");
                  }
                },
                borderRadius: BorderRadius.circular(13),

                children: [
                  PrimaryText(
                    text: 'Verify',
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
