import 'package:EasyLocker/app/tab1edit/commentscreen.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/common_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentAddScrren extends StatefulWidget {
  const CommentAddScrren({super.key});

  @override
  State<CommentAddScrren> createState() => _CommentAddScrrenState();
}

class _CommentAddScrrenState extends State<CommentAddScrren> {
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
            child: SvgPicture.asset(
              Assets.backbutton,
              height: 35,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.lockericons),
            kWidth(5),
            Text(
              Apptext.EasyLocker,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 28,
                  color: AppColors.icontextColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              //       Get.back();
              dilogbox(
                context,
              );
            },
            child: SvgPicture.asset(Assets.deletbutton),
          ),
          kWidth(20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                //    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight(15),
                  PrimaryText(
                      text: Apptext.Entercommenttext,
                      color: AppColors.white,
                      size: 12),
                  kHeight(10),
                  TextFormField(
                    autofocus: true,
                    style: GoogleFonts.urbanist(
                        fontSize: 14, color: AppColors.white),
                    maxLines: 6,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    //controller: textController,
                    //expands: true,

                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.searchbarColors,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.searchbarColors,
                          )),
                      contentPadding: EdgeInsets.all(15),
                      fillColor: AppColors.searchbarColors,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.searchbarColors,
                          )),
                      hintText: '',
                    ),
                  ),
                  kHeight(20),
                ],
              ),
            ),
            Container(
              //color: AppColors.amber,
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButtonnWidget(
                    onTap: () {
                      Get.back();
                      //dilogbox(context, 'Cancel', 'OK');
                    },
                    borderColors: AppColors.searchbarColors,
                    textColors: AppColors.white,
                    backgroundColors: AppColors.searchbarColors,
                    text: Apptext.Cancelbutton,
                  ),
                  CommonButtonnWidget(
                    onTap: () {
                      Get.to(() => CommentScreen());
                    },
                    borderColors: AppColors.icontextColor,
                    textColors: AppColors.white,
                    backgroundColors: AppColors.icontextColor,
                    text: Apptext.Addbutton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
