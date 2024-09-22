import 'package:EasyLocker/app/tab1/imagefull.dart';
import 'package:EasyLocker/app/tab1/pdf.dart';
import 'package:EasyLocker/app/tab1/videoplay.dart';
import 'package:EasyLocker/app/tab1edit/commentaddsctreen.dart';
import 'package:EasyLocker/app/tab1edit/commentscreen.dart';
import 'package:EasyLocker/app/tab1edit/tab1editscreen.dart';
import 'package:EasyLocker/models/homelistditels.dart';
import 'package:EasyLocker/models/homelistmodel.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/text_size.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Tab_1_ditels extends StatefulWidget {
  // final HomeListModel homeListModel;
  // final int index;
  const Tab_1_ditels({
    super.key,
  });

  @override
  State<Tab_1_ditels> createState() => _Tab_1_ditelsState();
}

class _Tab_1_ditelsState extends State<Tab_1_ditels> {
  // _launchURL() async {
  //   const url =
  //       'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
          actions: [
            InkWell(
              onTap: () {
                //   Get.back();
                dilogbox(
                  context,
                );
              },
              child: SvgPicture.asset(Assets.deletbutton),
            ),
            kWidth(20)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  kHeight(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PrimaryText(
                          text:
                              'Lorem ipsum dolor sit amet', // widget.homeListModel.title,
                          size: 18,
                          color: AppColors.icontextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeListDitelsModel.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(Tab1EditScreen(
                                      homeListDitelsModel:
                                          homeListDitelsModel[index],
                                      index: index));
                                },
                                child: Container(
                                  // height: 100,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: AppColors.searchbarColors,
                                      // border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryText(
                                          textAlign: TextAlign.justify,
                                          text: homeListDitelsModel[index]
                                              .description,
                                          overflow: TextOverflow.ellipsis,
                                          size: 13,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 3,
                                        ),
                                        kHeight(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(imagefull(
                                                    // homeListModel:
                                                    //     homeListModel[index],
                                                    // index: index,
                                                    ));
                                              },
                                              child: Container(
                                                height:
                                                    getProportionateScreenWidth(
                                                        90),
                                                width:
                                                    getProportionateScreenWidth(
                                                        90),
                                                decoration: BoxDecoration(
                                                  //  color: Colors.green,
                                                  //   borderRadius: BorderRadius.circular(radius),
                                                  // borderRadius: BorderRadius.horizontal(
                                                  //     left: Radius.circular(10)),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        homeListDitelsModel[
                                                                index]
                                                            .image1,
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(VideoApp());
                                              },
                                              child: Container(
                                                height:
                                                    getProportionateScreenWidth(
                                                        90),
                                                width:
                                                    getProportionateScreenWidth(
                                                        90),
                                                padding: EdgeInsets.all(35),
                                                decoration: BoxDecoration(
                                                  // color: Colors.black38,
                                                  //   borderRadius: BorderRadius.circular(radius),
                                                  // borderRadius: BorderRadius.horizontal(
                                                  //     left: Radius.circular(10)),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        homeListDitelsModel[
                                                                index]
                                                            .image2,
                                                      ),
                                                      opacity: 0.4,
                                                      fit: BoxFit.cover),
                                                ),
                                                child: SvgPicture.asset(
                                                  Assets.playbutton,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(pdfScreen());
                                              },
                                              child: Container(
                                                height:
                                                    getProportionateScreenWidth(
                                                        90),
                                                width:
                                                    getProportionateScreenWidth(
                                                        90),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .pdfbackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Image.asset(
                                                  homeListDitelsModel[index]
                                                      .image3,
                                                  // height: 80,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        kHeight(10),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/calendaricon.svg'),
                                            kWidth(5),
                                            PrimaryText(
                                              text: homeListModel[index].date,
                                              color: AppColors.white,
                                              size: 12,
                                            ),
                                            kWidth(15),
                                            SvgPicture.asset(
                                                'assets/timeclock.svg'),
                                            kWidth(5),
                                            PrimaryText(
                                              text: homeListModel[index].time,
                                              color: AppColors.white,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => CommentAddScrren());
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.searchbarColors,
                  child: PrimaryText(
                    text: Apptext.commenttextbutton,
                    color: AppColors.white,
                  )),
            )

            // kHeight(10)
          ],
        ));
  }
}
