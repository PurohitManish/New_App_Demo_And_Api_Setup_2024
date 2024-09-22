// import 'dart:io';

// import 'package:EasyLocker/controllers/controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:video_player/video_player.dart';

// class MediaUploadPage extends StatelessWidget {
//   final MediaController controller = Get.put(MediaController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload and Display Media'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => _pickImage(),
//               child: Text('Upload Image'),
//             ),
//             ElevatedButton(
//               onPressed: () => _pickVideo(),
//               child: Text('Upload Video'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () => _pickPdf(),
//             //   child: Text('Upload PDF'),
//             // ),
//             Obx(
//               () => Expanded(
//                 child: ListView.builder(
//                   itemCount: controller.mediaList.length,
//                   itemBuilder: (context, index) {
//                     var media = controller.mediaList[index];
//                     if (media is File) {
//                       return ListTile(
//                         leading: Icon(Icons.image),
//                         title: Text('Image'),
//                         onTap: () => _openMedia(media),
//                       );
//                     } else if (media is VideoPlayerController) {
//                       return ListTile(
//                         leading: Icon(Icons.video_label),
//                         title: Text('Video'),
//                         onTap: () => _openMedia(media),
//                       );
//                     } else if (media is PdfViewerController) {
//                       return ListTile(
//                         leading: Icon(Icons.picture_as_pdf),
//                         title: Text('PDF'),
//                         onTap: () => _openMedia(media),
//                       );
//                     }
//                     return Container(
//                       color: Colors.red,
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       controller.addMedia(File(image.path));
//     }
//   }

//   Future<void> _pickVideo() async {
//     XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       var videoController = VideoPlayerController.file(File(video.path));
//       await videoController.initialize();
//       controller.addMedia(videoController);
//     }
//   }

//   // Future<void> _pickPdf() async {
//   //   XFile? pdf = await ImagePicker().pickPdf(source: PdfSource.gallery);
//   //   if (pdf != null) {
//   //     controller.addMedia(PdfViewerController(filePath: pdf.path));
//   //   }
//   // }

//   void _openMedia(dynamic media) {
//     if (media is File) {
//       // Handle opening image file
//     } else if (media is VideoPlayerController) {
//       // Handle opening video file
//     } else if (media is PdfViewerController) {
//       // Handle opening PDF file
//     }
//   }
// }
import 'package:EasyLocker/app/tab1/tab1.dart';

import 'package:EasyLocker/controllers/home_screen_controller/add_category_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/get_category_controller.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';

import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class Home_Screen1 extends StatefulWidget {
  const Home_Screen1({super.key});

  @override
  State<Home_Screen1> createState() => _Home_Screen1State();
}

class _Home_Screen1State extends State<Home_Screen1>
    with SingleTickerProviderStateMixin {
  final AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  final GetCategoryController getCategoryController =
      Get.put(GetCategoryController());
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategoryController.getCategorylist();
    });

    // _tabController = TabController(length:getCategoryController. , vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Create a TabController based on the length of the category list
      if (getCategoryController.getCategoryLoading.value) {
        return centerLoader();
      } else {
        _tabController = TabController(
          length:
              getCategoryController.getCategoryResponse.value.result?.length ??
                  1,
          vsync: this,
        );
        return Scaffold(
          backgroundColor: AppColors.homebackgroundColor,
          body: Column(
            children: [
              TabBar(
                isScrollable: true,
                indicatorColor: AppColors.icontextColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: GoogleFonts.urbanist(
                    fontSize: 16, color: AppColors.icontextColor),
                unselectedLabelColor: AppColors.white,
                tabAlignment: TabAlignment.start,
                dividerColor: AppColors.dividerColor,
                padding: EdgeInsets.only(left: 10),
                tabs: getCategoryController.getCategoryResponse.value.result
                        ?.map((category) => Tab(text: category.category))
                        ?.toList() ??
                    [Tab(text: 'Loading')],
                controller: _tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: getCategoryController
                          .getCategoryResponse.value.result
                          ?.map((category) {
                        // Replace with your actual widget for each tab
                        return Center(
                            child: Text('Content for ${category.category}'));
                      })?.toList() ??
                      [Center(child: Text('Loading'))],
                ),
              ),
            ],
          ),
        );
      }
      //));
    });
  }
}
