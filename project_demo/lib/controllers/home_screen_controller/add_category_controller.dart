import 'package:EasyLocker/controllers/home_screen_controller/get_category_controller.dart';
import 'package:EasyLocker/models/add_category_response.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/services/http_helper.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryController extends GetxController {
  var httpHelper = HttpHelper();
  late SharedPreferences sharedPreferences;
  TextEditingController textcategoryController = TextEditingController();
  String? token;
  final GetCategoryController getCategoryController =
      Get.put(GetCategoryController());
  RxBool AddCategoryLoading = false.obs;

  Future<void> AddCategory(context) async {
    Future.delayed(Duration.zero).then((value) {
      var body = {"category": textcategoryController.text};
      AddCategoryLoading.value = true;
      httpHelper.post(URL.add_category_Url, body).then((value) {
        print("body:-${body}");
        if (value?.data != null) {
          AddCategoryResponse response =
              AddCategoryResponse.fromJson(value!.data);
          AddCategoryLoading.value = false;
          if (value.statusCode == 200 || value.statusCode == 201) {
            ToastUtil.showToast(response.message!);

            Get.back();
          } else {
            AddCategoryLoading.value = false;
            ToastUtil.showToast(response.message!);
            // ToastUtil.showToast(
            //     response.message ?? AppString.something_went_wrong.tr);
            return;
          }
        } else {
          AddCategoryLoading.value = false;
        }
      });
    });
  }
}
