import 'package:EasyLocker/app/authscreen/auth_controller.dart';
import 'package:EasyLocker/app/authscreen/otpscreen.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  // Country selectedCountry = Country(
  //   phoneCode: "91",
  //   countryCode: "IN",
  //   e164Sc: 0,
  //   geographic: true,
  //   level: 1,
  //   name: "India",
  //   example: "India",
  //   displayName: "India",
  //   displayNameNoCountryCode: "IN",
  //   e164Key: "",
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homebackgroundColor,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            kHeight(105),
            SvgPicture.asset(
              Assets.app_logo,
              height: 100,
            ),
            kHeight(40),
            PrimaryText(
              text: 'Log in',
              color: AppColors.icontextColor,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            PrimaryText(
              text: 'Please enter the details below to continue.',
              color: AppColors.white,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            kHeight(15),
            TextFormField(
              controller: authController.phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.urbanist(fontSize: 14, color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: InkWell(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        // optional. Shows phone code before the country name.
                        countryListTheme: const CountryListThemeData(
                          bottomSheetHeight: 550,
                        ),
                        // onSelect: (country) {
                        //   print('Wybierz kraj: ${country.displayName}');
                        //   authController.selectedCountryCode.value =
                        //       "${country.flagEmoji}+${country.phoneCode}";
                        // },
                        onSelect: (country) {
                          setState(() {
                            authController.selectedCountry = country;
                          });

                          // print('Wybierz kraj: ${country.displayName}');
                          // authController.selectedCountryCode.value =
                          //     "${country.flagEmoji}+${country.phoneCode}";
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 14, right: 5),
                    child: Text(
                      "${authController.selectedCountry.flagEmoji} +${authController.selectedCountry.phoneCode}",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.searchbartextColors,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //  CountryCodeWidget(
                //   text: authController.selectedCountryCode,
                //   onTap: () {
                // showCountryPicker(
                //   context: context,
                //   showPhoneCode: true,
                //   // optional. Shows phone code before the country name.
                //   countryListTheme: const CountryListThemeData(
                //     bottomSheetHeight: 550,
                //   ),
                //   // onSelect: (country) {
                //   //   print('Wybierz kraj: ${country.displayName}');
                //   //   authController.selectedCountryCode.value =
                //   //       "${country.flagEmoji}+${country.phoneCode}";
                //   // },
                //   onSelect: (country) {
                //     selectedCountry = country;
                //     // print('Wybierz kraj: ${country.displayName}');
                //     // authController.selectedCountryCode.value =
                //     //     "${country.flagEmoji}+${country.phoneCode}";
                //   },
                //     );
                //   },
                // ),
                filled: true,
                fillColor: AppColors.searchbarColors,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: AppColors.searchbarColors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: AppColors.searchbarColors)),
                contentPadding: EdgeInsets.only(left: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: AppColors.searchbarColors)),
                hintText: 'Phone number',
                hintStyle: GoogleFonts.urbanist(
                    color: AppColors.searchbartextColors, fontSize: 14),
              ),
            ),
            kHeight(25),
            CustomButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  // authController.signInwithPhone("Login", context);
                  authController.savetoken(context);
                  //  Get.to(() => OtpScreen());
                },
                borderRadius: BorderRadius.circular(13),
                children: [
                  PrimaryText(
                      text: 'Log In',
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white)
                ])
          ],
        ));
  }
}

// class CountryCodeWidget extends StatelessWidget {
//   const CountryCodeWidget({
//     Key? key,
//     required this.text,
//     required this.onTap,
//   }) : super(key: key);
//   final Function()? onTap;
//   final RxString text;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         // color: Colors.red,
//         padding: EdgeInsets.only(left: 10),
//         child: Row(
//           children: [
//             Obx(() => Text(
//                   text.value,
//                   style: TextStyle(color: AppColors.white),
//                   softWrap: false,
//                 )),
//             SizedBox(width: 2),
//             Container(
//               // padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(60),
//                   color: Colors.grey.shade100),
//               child: Icon(
//                 Icons.keyboard_arrow_down_sharp,
//                 size: 12,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
