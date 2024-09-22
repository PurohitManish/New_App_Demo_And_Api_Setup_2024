import 'package:EasyLocker/app/filterscreen.dart';
import 'package:EasyLocker/app/settings/settingscreen.dart';
import 'package:EasyLocker/app/tab1ditels.dart';

import 'package:EasyLocker/models/homelistmodel.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class Tab_1 extends StatefulWidget {
  final BuildContext context;
  const Tab_1({super.key, required this.context});

  @override
  State<Tab_1> createState() => _Tab_1State();
}

class _Tab_1State extends State<Tab_1> {
  @override
  // FilterController filterController = Get.put(FilterController());
  TextEditingController textAddTitleController = TextEditingController();
  bool isLoading = false;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 23,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            //padding: EdgeInsets.only(r),
                            itemBuilder: ((context, index) {
                              return Container(
                                // height: 20,
                                width: 65,
                                margin: EdgeInsets.only(right: 10),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.searchbarColors,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: PrimaryText(
                                      text: 'Tag ${index + 1}',
                                      fontWeight: FontWeight.w500,
                                      size: 10,
                                      color: AppColors.white),
                                ),
                              );
                            })),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                // Get.to(() => FilterScreen());
                              },
                              child: SvgPicture.asset(
                                Assets.cancelbutton,
                                height: 24,
                              )),
                          kWidth(15),
                          InkWell(
                              onTap: () {
                                // Get.to(() => FilterScreen(
                                //       categoryId: '',
                                //     ));
                              },
                              child: SvgPicture.asset(Assets.filterbutton)),
                        ],
                      )
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeListModel.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(Tab_1_ditels());
                        },
                        child: Container(
                          // height: 100,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        text: homeListModel[index].title,
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.icontextColor,
                                      ),
                                      kHeight(7),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/calendaricon.svg'),
                                          kWidth(5),
                                          PrimaryText(
                                              text: homeListModel[index].date,
                                              color: AppColors.white,
                                              size: 12),
                                          kWidth(20),
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
                            ],
                          ),
                        ),
                      );
                    })),
                kHeight(10),
              ],
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width / 2.02,
                  onPressed: () {
                    bottomsheet(
                      widget.context,
                      Apptext.Addtitle,
                      Apptext.Entertitle,
                      textAddTitleController,
                      CustomButton(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {},
                        children: [
                          PrimaryText(
                            text: Apptext
                                .Savebutton, // Ensure this is properly initialized
                            color: AppColors.white,
                          ),
                        ],
                      ),
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category';
                        }
                        return null; // If the value is valid, return null
                      },
                    );
                  },
                  children: [
                    Column(
                      children: [
                        Icon(Icons.add, size: 30, color: AppColors.white),
                        kWidth(7),
                        PrimaryText(
                            text: Apptext.Addbutton,
                            size: 10,
                            color: AppColors.white)
                      ],
                    )
                  ]),
              Container(
                color: AppColors.white,
                height: 64,
                width: 1,
              ),
              CustomButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width / 2.02,
                  onPressed: () {
                    Get.to(() => Setting_Screen());
                  },
                  children: [
                    Column(
                      children: [
                        Icon(Icons.settings, size: 30, color: AppColors.white),
                        kWidth(7),
                        PrimaryText(
                            text: 'Settings', size: 10, color: AppColors.white)
                      ],
                    )
                  ]),
            ],
          )
        ],
      ),
    );
  }
}
