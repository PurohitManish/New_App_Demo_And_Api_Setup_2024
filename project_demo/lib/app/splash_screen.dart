// import 'dart:async';

// import 'package:EasyLocker/app/authscreen/logingscreen.dart';
// import 'package:EasyLocker/app/homescreen.dart';
// import 'package:EasyLocker/utils/app_assets.dart';
// import 'package:EasyLocker/utils/app_colors.dart';
// import 'package:EasyLocker/utils/text_size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   void initState() {
//     super.initState();
// SharedPreferences _prefs = await SharedPreferences.getInstance();
//   bool checkLogin = _prefs.getBool("isLoggedIn") ?? false;
//     // Future.delayed(Duration(seconds: 1))
//     //     .then((value) => Get.offAll(() => Home_Screen()));
//     Future.delayed(Duration(seconds: 1)).then((value) {
//       Get.offAll(() =>  checkLogin ? LogInScreen():Home_Screen());
//     });
//   }

// //MainScreen()
//   @override
//   Widget build(BuildContext context) {

//     SizeConfig().init(context);
//     return Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   Assets.app_logo,
//                   height: 150,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
import 'package:EasyLocker/app/authscreen/logingscreen.dart';
import 'package:EasyLocker/app/homescreen.dart';
import 'package:EasyLocker/controllers/newpage.dart';
import 'package:EasyLocker/testing_api/test_api_list.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/text_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Asynchronous operation to check login status
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool checkLogin = _prefs.getBool("isLoggedIn") ?? false;

    // Delay for splash screen display
    Future.delayed(Duration(seconds: 1), () {
      // Navigate to the appropriate screen based on login status
      Get.offAll(() => checkLogin ? TestApi() : LogInScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        context); // Initialize SizeConfig (assuming you have it set up elsewhere)
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SvgPicture.asset(
          Assets.app_logo, // Make sure this path is correct
          height: 150,
        ),
      ),
    );
  }
}
