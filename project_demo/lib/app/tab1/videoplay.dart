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
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  double _startTime = 0.0;
  double _endTime = 0.0;
  double _currentPosition = 0.0;
  bool _isVideoPlaying = false;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    _controller = VideoPlayerController.asset(Assets.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _endTime = _controller.value.duration.inSeconds.toDouble();
          _isVideoPlaying = false;
        });
      });
    _controller.addListener(() {
      setState(() {
        _currentPosition = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackgroundColor,
      //appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_isVideoPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                            setState(() {
                              _isVideoPlaying = !_isVideoPlaying;
                            });
                            // _controller.value.isPlaying
                            //     ? _controller.pause()
                            //     : _controller.play();
                          });
                        },
                        child: SvgPicture.asset(
                          _isVideoPlaying
                              ? Assets.pausebutton
                              : Assets.playbutton,
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 16),
                    GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        double percentage =
                            details.primaryDelta! / context.size!.width;
                        setState(() {
                          _currentPosition +=
                              percentage * (_endTime - _startTime);
                          _currentPosition = _currentPosition.clamp(_startTime,
                              _endTime); // Ensure it stays within bounds
                        });
                        _controller.seekTo(
                            Duration(seconds: _currentPosition.toInt()));
                      },
                      child: Slider(
                        value: _currentPosition,
                        min: _startTime,
                        max: _endTime,
                        onChanged: (value) {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      // setState(() {
      //   _controller.value.isPlaying
      //       ? _controller.pause()
      //       : _controller.play();
      // });
      //   },
      //   child: ,
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> shareImage() async {
    try {
      // Load image from assets
      final ByteData bytes = await rootBundle.load('assets/Video.mp4');
      final Uint8List list = bytes.buffer.asUint8List();

      // Save image to temporary directory
      final tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String imagePath = '$tempPath/Video.mp4';

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
