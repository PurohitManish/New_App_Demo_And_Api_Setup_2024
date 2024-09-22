import 'package:EasyLocker/models/get_category_response.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/services/http_helper.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCategoryController extends GetxController {
  var httpHelper = HttpHelper();
  var getCategoryResponse = GetCategoryResponse().obs;

  RxBool getCategoryLoading = false.obs;

  Future<void> getCategorylist() async {
    var _params = {};

    getCategoryLoading.value = true;
    httpHelper.getData(URL.get_category_list_Url, _params).then((value) {
      if (value?.data != null) {
        GetCategoryResponse response =
            GetCategoryResponse.fromJson(value!.data);
        getCategoryLoading.value = false;
        if (value.statusCode == 200 || value.statusCode == 201) {
          getCategoryResponse.value = response;
          // print('GetCategoryRespons:-${response.result!.length.toString()}');
        } else {
          ToastUtil.showToast("${response.message}");
          return;
        }
      } else {
        ToastUtil.showToast("Something went wrong!");
      }
    });
  }
}
