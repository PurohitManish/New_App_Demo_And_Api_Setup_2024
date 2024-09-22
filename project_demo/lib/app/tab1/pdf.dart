import 'dart:io';

import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfScreen extends StatelessWidget {
  const pdfScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title: PrimaryText(
            text: 'PDF',
            size: 25,
            fontWeight: FontWeight.w600,
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                  child: SfPdfViewer.asset('assets/flutter-succinctly.pdf')),
            ),
            CustomButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  sharePdf();
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

  Future<void> sharePdf() async {
    try {
      // Load PDF from network
      final ByteData bytes =
          await rootBundle.load('assets/flutter-succinctly.pdf');
      final Uint8List list = bytes.buffer.asUint8List();

      // Save PDF to temporary directory
      final tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String pdfPath = '$tempPath/flutter-succinctly.pdf';

      // Create a new File instance and write the bytes to it
      File pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(list);

      // Check if the file exists
      if (await pdfFile.exists()) {
        // Share the PDF file
        await Share.shareFiles([pdfPath]);
      } else {
        print('Error: PDF file does not exist');
      }
    } catch (e) {
      print('Error sharing PDF: $e');
    }
  }
}
