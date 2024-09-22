import 'package:EasyLocker/models/homelistmodel.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class imagefull extends StatefulWidget {
  // final HomeListModel homeListModel;
  // final int index;
  const imagefull({super.key});

  @override
  State<imagefull> createState() => _imagefullState();
}

class _imagefullState extends State<imagefull> {
  final String image = 'assets/fullimage.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              // color: AppColors.red,
              image: DecorationImage(
                  image: AssetImage(Assets.fullimage), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      Assets.backbutton,
                      height: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //       Get.back();
                      dilogbox(
                        context,
                      );
                    },
                    child: SvgPicture.asset(Assets.deletbutton),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomButton(
            padding: EdgeInsets.symmetric(vertical: 15),
            onPressed: () {
              shareImage();
            },
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.share),
                  kWidth(10),
                  PrimaryText(
                    text: Apptext.Sharebutton,
                    size: 14,
                    color: AppColors.white,
                  ),
                ],
              )
            ])
      ],
    ));
  }

  // Future<void> shareImage() async {
  //   try {
  //     // Load image from assets
  //     final ByteData bytes = await rootBundle.load('assets/image1.png');
  //     final Uint8List list = bytes.buffer.asUint8List();

  //     // Save image to temporary directory
  //     final tempDir = await getTemporaryDirectory();
  //     final file = await tempDir.createTemp('image');

  //     // Write the image data to the file
  //     // await file.writeAsBytes(list);

  //     // Check if the file exists
  //     if (await file.exists()) {
  //       // Share the image file
  //       await Share.shareFiles([file.path], text: 'Share Image');
  //     } else {
  //       print('Error: Image file does not exist');
  //     }
  //   } catch (e) {
  //     print('Error sharing image: $e');
  //   }
  // }

  Future<void> shareImage() async {
    try {
      // Load image from assets
      final ByteData bytes = await rootBundle.load('assets/fullimage.png');
      final Uint8List list = bytes.buffer.asUint8List();

      // Save image to temporary directory
      final tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String imagePath = '$tempPath/fullimage.png';

      // Create a new File instance and write the bytes to it
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(list);

      // Check if the file exists
      if (await imageFile.exists()) {
        // Share the image file
        await Share.shareFiles([imagePath]);
      } else {
        print('Error: Image file does not exist');
      }
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}
