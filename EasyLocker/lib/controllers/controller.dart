import 'package:get/get.dart';

class MediaController extends GetxController {
  RxList<dynamic> mediaList = [].obs;

  void addMedia(dynamic media) {
    mediaList.add(media);
  }
}
