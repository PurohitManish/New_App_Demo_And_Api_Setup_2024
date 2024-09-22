import 'package:EasyLocker/app/authscreen/logingscreen.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homebackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.homebackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(Assets.backbutton),
            ),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(Assets.lockericons),
            kWidth(5),
            Text(
              Apptext.EasyLocker,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 28,
                  color: AppColors.icontextColor,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       //   Get.back();
          //       dilogbox(
          //         context,
          //       );
          //     },
          //     child: SvgPicture.asset(Assets.deletbutton),
          //   ),
          //   kWidth(20)
          // ],
        ),
        body: ListView(
          children: [
            kHeight(
              10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.termsandconditionsicon),
                    kWidth(20),
                    PrimaryText(
                        text: 'Terms of Conditions',
                        size: 14,
                        color: AppColors.white),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.dividerColor,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.privacypolicyicon),
                    kWidth(20),
                    PrimaryText(
                        text: 'Privacy Policy',
                        size: 14,
                        color: AppColors.white),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.dividerColor,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.settingdeleteicon),
                    kWidth(20),
                    PrimaryText(
                        text: 'Delete Account',
                        size: 14,
                        color: AppColors.white),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.dividerColor,
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences prefs = await _prefs;
                prefs.setBool("isLoggedIn", false);
                Get.offAll(LogInScreen());
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.logouticon),
                    kWidth(20),
                    PrimaryText(
                        text: 'Logout', size: 14, color: AppColors.white),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.dividerColor,
            )
          ],
        ));
  }
}
