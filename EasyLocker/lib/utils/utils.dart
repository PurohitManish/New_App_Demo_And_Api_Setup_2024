import 'dart:async';

import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/app_textformfield.dart';
import 'package:EasyLocker/widget/common_button_widget.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/utils/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kHeight(double height) {
  return SizedBox(
    height: height,
  );
}

Widget kWidth(double width) {
  return SizedBox(
    width: width,
  );
}

Widget centerLoader() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
  );
}

Future<void> bottomsheet(
    BuildContext context,
    String? title,
    String enterTitle,
    TextEditingController? controller,
    Widget? child,
    Function onvalidate) async {
  await showModalBottomSheet(
    backgroundColor: AppColors.buttomsheetColors,
    isScrollControlled: true,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    context: context,
    builder: (builder) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size based on content
            children: [
              SizedBox(height: 20), // Replace kHeight with SizedBox
              PrimaryText(
                text:
                    title ?? '', // Use a default empty string if title is null
                color: AppColors.icontextColor,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                      text: enterTitle, // Enter title text
                      size: 12,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 10), // Replace kHeight
                    CustomTextField2(
                      controller: controller,
                      hint: '',
                      // Make sure these callbacks do something
                      onChange: () {},
                      onvalidate: ((value) => onvalidate(value)),

                      //
                    ),
                    SizedBox(
                      height:
                          20, // Replace getProportionateScreenWidth with fixed height for simplicity
                    ),
                  ],
                ),
              ),
              Container(
                child: child,
              )
            ],
          ),
        ),
      );
    },
  );
}
// void bottomsheet(context, String? title, Entertitle, Function()? onPressed,TextEditingController?  controller,
//     bool? isLoaderbutton) {
//   showModalBottomSheet(
//       backgroundColor: AppColors.buttomsheetColors,
//       isScrollControlled: true,
//       enableDrag: false,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       //  barrierLabel: 'Add Category',
//       context: context,
//       builder: (builder) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Column(
//               children: [
//                 kHeight(20),
//                 PrimaryText(
//                   text: title, //'Add Category',
//                   color: AppColors.icontextColor,
//                   size: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       PrimaryText(
//                         text: Entertitle, //'Enter category name'
//                         size: 12,
//                         color: AppColors.white,
//                       ),
//                       kHeight(10),
//                       CustomTextField2(
//                         controller: controller,
//                         // controller: controller.insetnameController,
//                         hint: '',
//                         onvalidate: () {},
//                         onChange: () {},
//                       ),
//                       kHeight(
//                         getProportionateScreenWidth(20),
//                       )
//                     ],
//                   ),
//                 ),
//                 isLoaderbutton
//                     ? centerLoader()
//                     : CustomButton(
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         width: MediaQuery.of(context).size.width,
//                         onPressed: onPressed,
//                         children: [
//                           PrimaryText(
//                               text: Apptext.Savebutton, color: AppColors.white)
//                         ],
//                       ),
//               ],
//             ),
//           ),
//         );
//       });
// }

void bottomsheetfilespick(
    context, Function()? GalleryOnTap, CameraOnTap, PDFFileOnTap) {
  showModalBottomSheet(
      backgroundColor: AppColors.buttomsheetColors,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      //  barrierLabel: 'Add Category',
      context: context,
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  kHeight(20),
                InkWell(
                  onTap: GalleryOnTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,
                    child: Center(
                      child: PrimaryText(
                        text: 'Upload from Gallery', //'Add Category',
                        color: AppColors.white,
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.dividerColor,
                ),
                // Divider(color: AppColors.dividerColor),
                InkWell(
                  onTap: CameraOnTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,

                    child: Center(
                      child: PrimaryText(
                        text: 'Camera', //'Add Category',
                        color: AppColors.white,
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.dividerColor,
                ),
                // Divider(color: AppColors.dividerColor),
                InkWell(
                  onTap: PDFFileOnTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,

                    child: Center(
                      child: PrimaryText(
                        text: 'Upload PDF File', //'Add Category',
                        color: AppColors.white,
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: AppColors.searchbarColors,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: PrimaryText(
                            text: 'Cancle', color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> dilogbox(
  context,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //buttonPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          titlePadding: EdgeInsets.fromLTRB(30, 20, 10, 0),
          title: Column(
            children: [
              SvgPicture.asset(Assets.erroricons),
              kHeight(10),
              PrimaryText(
                text: Apptext.Alertmessenge,
                size: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.icontextColor,
              ),
              Row(
                children: [
                  Container(
                    //color: AppColors.amber,
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.cancelColor,
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: borderColors)
                              ),
                              child: PrimaryText(
                                  text: Apptext.Nobutton,
                                  fontWeight: FontWeight.w500,
                                  size: 14,
                                  color: AppColors.searchbartextColors),
                            )),
                        kWidth(10),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.icontextColor,
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: borderColors)
                              ),
                              child: PrimaryText(
                                  text: Apptext.Yesbutton,
                                  fontWeight: FontWeight.w500,
                                  size: 14,
                                  color: AppColors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

class ToastUtil {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.BOTTOM,
      // You can change the position as needed
      toastLength: Toast.LENGTH_LONG,
      // You can change the duration as needed
      backgroundColor: Colors.black,
      // You can customize the background color
      textColor: Colors.white, // You can customize the text color
    );
    // if (Platform.isAndroid) {
    //   Fluttertoast.showToast(
    //     msg: message,
    //     timeInSecForIosWeb: 3,
    //     gravity: ToastGravity.BOTTOM,
    //     // You can change the position as needed
    //     toastLength: Toast.LENGTH_LONG,
    //     // You can change the duration as needed
    //     backgroundColor: Colors.black,
    //     // You can customize the background color
    //     textColor: Colors.white, // You can customize the text color
    //   );
    // }
  }
}
