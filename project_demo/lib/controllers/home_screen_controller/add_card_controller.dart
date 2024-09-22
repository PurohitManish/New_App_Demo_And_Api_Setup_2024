import 'package:EasyLocker/controllers/home_screen_controller/get_category_controller.dart';
import 'package:EasyLocker/models/add_card_response.dart';
import 'package:EasyLocker/models/add_category_response.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/services/http_helper.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardController extends GetxController {
  var httpHelper = HttpHelper();
  late SharedPreferences sharedPreferences;
  TextEditingController textcardController = TextEditingController();
  String? token;
  // final AddCardRespons getCategoryController = Get.put(AddCardRespons());
  RxBool AddCardLoading = false.obs;

  Future<void> AddCard(String categoryId) async {
    Future.delayed(Duration.zero).then((value) {
      var body = {"categoryId": categoryId, "title": textcardController.text};
      AddCardLoading.value = true;
      httpHelper.post(URL.add_card_Url, body).then((value) {
        print("body:-${body}");
        if (value?.data != null) {
          AddCardResponse response = AddCardResponse.fromJson(value!.data);
          AddCardLoading.value = false;
          if (value.statusCode == 200 || value.statusCode == 201) {
            ToastUtil.showToast(response.message!);

            Get.back();
          } else {
            AddCardLoading.value = false;
            ToastUtil.showToast(response.message!);
            // ToastUtil.showToast(
            //     response.message ?? AppString.something_went_wrong.tr);
            return;
          }
        } else {
          AddCardLoading.value = false;
        }
      });
    });
  }
}
