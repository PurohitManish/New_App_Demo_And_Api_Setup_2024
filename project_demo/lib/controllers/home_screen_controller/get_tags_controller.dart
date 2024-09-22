import 'package:EasyLocker/app/filterscreen.dart';
import 'package:EasyLocker/models/get_tags_response.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/services/http_helper.dart';
import 'package:EasyLocker/testing_api/filter_api_list.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetTagsController extends GetxController {
  var httpHelper = HttpHelper();
  var getTagsResponse = GetTagsResponse().obs;

  var selectedTags = RxList<TagRespons>();

  RxBool getTagsLoading = false.obs;

  Future<void> getTagslist(categoryId, bool? messageshow) async {
    var _params = {};

    getTagsLoading.value = true;
    httpHelper
        .getData(URL.get_tags_list_Url + "/${categoryId}", _params)
        .then((value) {
      if (value?.data != null) {
        GetTagsResponse response = GetTagsResponse.fromJson(value!.data);
        getTagsLoading.value = false;
        if (value.statusCode == 200 || value.statusCode == 201) {
          getTagsResponse.value = response;
          // print('GetCategoryRespons:-${response.result!.length.toString()}');
        } else {
          if (messageshow == true) {
            ToastUtil.showToast("${response.message}");
          }

          return;
        }
      } else {
        ToastUtil.showToast("Something went wrong!");
      }
    });
  }
}
