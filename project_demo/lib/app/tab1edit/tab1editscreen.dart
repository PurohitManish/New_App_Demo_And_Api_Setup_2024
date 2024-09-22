import 'dart:io';

import 'package:EasyLocker/app/tab1/imagefull.dart';
import 'package:EasyLocker/app/tab1/pdf.dart';
import 'package:EasyLocker/app/tab1/videoplay.dart';
import 'package:EasyLocker/models/homelistditels.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/widget/dotted_image_border.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/common_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Tab1EditScreen extends StatefulWidget {
  final HomeListDitelsModel homeListDitelsModel;
  final int index;
  const Tab1EditScreen(
      {super.key, required this.homeListDitelsModel, required this.index});

  @override
  State<Tab1EditScreen> createState() => _Tab1EditScreenState();
}

class _Tab1EditScreenState extends State<Tab1EditScreen> {
  File? imageFile;
  var videofile;
  late VideoPlayerController _controller;

  final picker = ImagePicker();
  var pdfpath1;
  var exstans;
  TextEditingController textController = TextEditingController(
      text:
          'Nec ultrices dui sapien eget mi proin sed libero. Enim sit amet venenatis urna cursus eget nunc. Rhoncus urna neque viverra justo. Ligula ullamcorper malesuada proin libero nunc consequat interdum varius. Eu augue ut lectus arcu bibendum at.');

  @override
  void initState() {
    super.initState();
    // print('InitState');
    init();
  }

  void init() {
    print('InitState');
    if (imageFile != null) {
      print('Initializing controller...');
      _controller = VideoPlayerController.file(imageFile!)
        ..initialize().then((_) {
          print('Controller initialized');
          setState(() {});
        }).catchError((error) {
          print('Error initializing controller: $error');
        });
    } else {
      print('Image file is null');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      print('result;-${result}');
      if (result != null) {
        setState(() {
          pdfpath1 = result.files.single.path!;
          exstans = pdfpath1.endsWith('.pdf');
          print('exstans11:-${exstans}');
        });

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         ViewPDFScreen(pdfPath: result.files.single.path!),
        //   ),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file selected'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

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
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryText(
                              text: Apptext.Entercommenttext,
                              color: AppColors.white,
                              size: 12),
                          InkWell(
                              onTap: () {
                                _copyToClipboard(textController.text);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SvgPicture.asset(Assets.copybutton)))
                        ],
                      ),
                      kHeight(15),
                      TextFormField(
                        style: GoogleFonts.urbanist(
                            fontSize: 14, color: AppColors.white),
                        maxLines: 8,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: textController,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(imagefull(
                                  // homeListModel: homeListModel[index],
                                  // index: index,
                                  ));
                            },
                            child: Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                //  color: Colors.green,
                                //   borderRadius: BorderRadius.circular(radius),
                                // borderRadius: BorderRadius.horizontal(
                                //     left: Radius.circular(10)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      Assets.image1,
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
                              height: 95,
                              width: 95,
                              padding: EdgeInsets.all(35),
                              decoration: BoxDecoration(
                                // color: Colors.black38,
                                //   borderRadius: BorderRadius.circular(radius),
                                // borderRadius: BorderRadius.horizontal(
                                //     left: Radius.circular(10)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      Assets.image2,
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
                              height: 95,
                              width: 95,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.pdfbackgroundColor,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Image.asset(
                                Assets.image3,
                                // height: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight(20),
                      GestureDetector(
                          onTap: () {
                            bottomsheetfilespick(context, () {
                              // pickImage(ImageSource.gallery).then((_) {
                              //   Get.back();
                              // });
                              pickMedia(
                                ImageSource.gallery,
                              ).then((_) {
                                Get.back();
                                //  print('videofileABC${videofile}');
                              });
                            }, () {
                              pickImage(ImageSource.camera).then((_) {
                                Get.back();
                              });
                            }, () {
                              //    _loadPDF();
                              _openFilePicker();
                            });
                          },
                          child: imageandvideo())
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //color: AppColors.amber,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButtonnWidget(
                  onTap: () {
                    Get.back();
                    //  dilogbox(context, 'Cancel', 'Ok','Are you sure you want to Cancel!');
                  },
                  borderColors: AppColors.searchbarColors,
                  textColors: AppColors.white,
                  backgroundColors: AppColors.searchbarColors,
                  text: Apptext.Cancelbutton,
                ),
                CommonButtonnWidget(
                  onTap: () {
                    Get.back();
                    // dilogbox();
                  },
                  borderColors: AppColors.icontextColor,
                  textColors: AppColors.white,
                  backgroundColors: AppColors.icontextColor,
                  text: Apptext.Savebutton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // Optionally, you can show a snackbar or toast message to indicate that the text has been copied.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Text copied to clipboard'),
    ));
  }

  pickImage(ImageSource imageType) async {
    try {
      // final ImagePicker _picker = ImagePicker();
      final photo = await ImagePicker().pickImage(
        source: imageType,
        imageQuality: 50,
      );

      if (photo == null) return;
      //  final LostDataResponse response = await _picker.retrieveLostData();
      final tempImage = File(photo.path);
      setState(() {
        imageFile = tempImage;
        // cropImage();
      });
      cropImage();
      // Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> cropImage() async {
    if (imageFile == null) return;

    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 3));

      if (croppedFile != null) {
        setState(() {
          imageFile = File(croppedFile.path);
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      // Do something with the picked file
    } else {
      // User canceled the file picking
    }
  }

  // File? videoFile;

  pickMedia(
    ImageSource source,
  ) async {
    try {
      final pickedFile = await ImagePicker().pickMedia(
        imageQuality: 50,
        // source: source,
      );
      if (pickedFile == null) return;

      final tempImage = File(pickedFile.path);
      setState(() {
        imageFile = tempImage;
      });
      // print('imageFile video:- ${imageFile}');
      // print('pickedFile:- ${pickedFile.path.endsWith('.mp4')}');
      // if (pickedFile.path.endsWith('.mp4')) ;
      setState(() {
        videofile = pickedFile.path.endsWith('.mp4');
        print('pickedFile1:- ${videofile}');
        if (videofile == true) {
          init();
        }
      });

      cropImage();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Widget imageandvideo() {
    print("videofile123${videofile}");

    return imageFile != null
        ? videofile == true
            ? _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 5 / 3,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ))
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: centerLoader())
            : AspectRatio(
                aspectRatio: 5 / 3,
                child: Image.file(
                  //excludeFromSemantics: false,
                  imageFile!,

                  fit: BoxFit.contain,
                ))
        : Dottedborderimage(
            child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.gallerybutton),
                  PrimaryText(
                    text: 'Upload files',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ));
  }
}
