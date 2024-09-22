import 'dart:convert';
import 'dart:io';
import 'package:EasyLocker/app/authscreen/logingscreen.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as prefix;
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http_parser/http_parser.dart' as http_parser;

class HttpHelper {
  late SharedPreferences preferences;

  HttpHelper() {
    _dio = Dio(BaseOptions(
      baseUrl: URL.baseUrl,
    ));
    initializeInterceptors();
  }

  late Dio _dio;

  // CancelToken cancelToken = CancelToken();

  initializeInterceptors() {
    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestHeader: true,
      responseHeader: false,
      responseBody: true,
      requestBody: true,
      logPrint: (object) {
        debugPrint(object.toString());
        if (object is FormData) {
          object;
          debugPrint(object.fields.toString());
        }
      },
    ));
  }

  // getHeaders() {
  //   // await GetStorage.init();
  //   var token = ApplicationData().getToken;
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  // }

  getHeaders() {
    print('Saved Token :${GetStorage().read('token')}');
    return {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${GetStorage().read('token')}'
    };
  }

  Future<Response?> getWithBody(
      String url, dynamic params, dynamic body) async {
    Response? response;
    try {
      var data = json.encode(body);
      response = await _dio.get(url,
          options: Options(headers: await getHeaders()),
          queryParameters: params,
          data: data);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return null;
      } else if (response.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response.data['message']);
        // showToast(response.data['message']);
        return null;
      } else if (response.statusCode == 1001) {
        logOut();
        return null;
      } else {
        return null;
      }
    } on DioException catch (e) {
      // debugPrint(e.message);
      // return null;

      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> getData(String url, dynamic params) async {
    Response? response;
    try {
      response = await _dio.get(
        url,
        options: Options(headers: await getHeaders()),
        //cancelToken: cancelToken,
        // queryParameters: params,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      // debugPrint(e.message);
      // response = e.response!;
      // return response;
      response = e.response;

      debugPrint(e.message);
      print("ERRROR RES @ : ${response?.statusCode}");
      print("ERRROR RES: ${e.message}");
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  void logOut() {
    print("SHARED CLEARED CONGRATES");
    initializePreference().whenComplete(() {
      clearPreference();
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  void clearPreference() async {
    await preferences.clear();

    prefix.Get.offAll(const LogInScreen());
  }

  Future delete(String url, body) async {
    Response? response;
    try {
      response = await _dio.delete(
        url,
        data: body, options: Options(headers: await getHeaders()),
        // cancelToken: cancelToken,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> patchRequest(String url, body) async {
    Response? response;
    try {
      response = await _dio.patch(
        url,
        data: jsonEncode(body), options: Options(headers: getHeaders()),
        // cancelToken: cancelToken,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      print("ERRROR Stats Code : ${response?.statusCode}");
      print("ERRROR RES: ${e.message}");
      response = e.response!;
      if (response.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response.data['message']);
      } else if (response.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> post(String url, body) async {
    Response? response;
    try {
      response = await _dio.post(url,
          data: jsonEncode(body),
          // cancelToken: cancelToken,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> postMultipart(String url, Map<String, dynamic> body,
      String fileParam, String filePath) async {
    Response? response;
    try {
      String fileName = path.basename(filePath);
      print("FILE NAME: $fileName");
      // Read and compress the image file
      final imageFile = File(filePath); // Replace with the actual file path
      final images = img.decodeImage(imageFile.readAsBytesSync());
      final compressedImage =
          img.encodeJpg(images!, quality: 70); // Adjust the quality as needed

      FormData formData = FormData();
      formData.fields.addAll(
        body.entries.map((e) => MapEntry(e.key, e.value.toString())),
      );

      formData.files.add(
        MapEntry(
          fileParam,
          await MultipartFile.fromFile(imageFile.path,
              filename: fileName,
              contentType: http_parser.MediaType("image", "jpeg")),
        ),
      );
      print("MULTI PARAMS: ${formData.fields}");

      response = await _dio.post(url,
          data: formData, //jsonEncode(formData),
          // cancelToken: cancelToken,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      // debugPrint(e.message);
      // response = e.response!;
      // return response;

      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> postMultipartCreatePost(
      String url, String title, List<String> filePaths) async {
    Response? response;
    try {
      List<String> fileNames = [];
      List<img.Image> imagesToUpload = [];
      List<File> imageFiles = [];
      for (String filePath in filePaths) {
        String fileName = path.basename(filePath);
        fileNames.add(fileName);
        print("FILE NAME: $fileName");
        // Read and compress the image file
        final imageFile = File(filePath); // Replace with the actual file path
        imageFiles.add(imageFile);
        final image = img.decodeImage(imageFile.readAsBytesSync());
        imagesToUpload.add(image!);
      }

      FormData formData = FormData();

      List uploadList = [];
      for (var image in imageFiles.indexed) {
        var multipartFile = await MultipartFile.fromFile(image.$2.path,
            filename: fileNames[image.$1],
            contentType: http_parser.MediaType("image", "jpeg"));
        uploadList.add(multipartFile);
      }

      formData = FormData.fromMap({"title": title, "photos": uploadList});

      print("MULTI PARAMS: ${formData.fields}");

      response = await _dio.post(url,
          data: formData, //jsonEncode(formData),
          // cancelToken: cancelToken,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      // debugPrint(e.message);
      // response = e.response!;
      // return response;

      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future postRequestFormData(String url, FormData body) async {
    Response response;
    try {
      debugPrint("Data is ${body.fields}");

      response = await _dio.post(url,
          // cancelToken: cancelToken,
          data: body,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return null;
      } else if (response.statusCode == 401) {
        logOut();
        return null;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return null;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      response = e.response!;
      if (response.statusCode == 500) {
        return response;
      } else if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return null;
    }
  }

  Future put(String url, body) async {
    Response? response;
    try {
      response = await _dio.put(url,
          data: jsonEncode(body),
          // cancelToken: cancelToken,
          options: Options(headers: await getHeaders()));
      // response = await dio.put(url,
      //     data: body,
      // cancelToken: cancelToken,
      //     options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Response?> putMultipart(String url, Map<String, dynamic> body,
      String fileParam, String filePath) async {
    Response? response;
    try {
      String fileName = path.basename(filePath);
      print("FILE NAME: $fileName");
      // Read and compress the image file
      final imageFile = File(filePath); // Replace with the actual file path
      final images = img.decodeImage(imageFile.readAsBytesSync());
      final compressedImage =
          img.encodeJpg(images!, quality: 70); // Adjust the quality as needed

      FormData formData = FormData();
      formData.fields.addAll(
        body.entries.map((e) => MapEntry(e.key, e.value.toString())),
      );

      formData.files.add(
        MapEntry(
          fileParam,
          await MultipartFile.fromFile(imageFile.path,
              filename: fileName,
              contentType: http_parser.MediaType("image", "jpeg")),
        ),
      );
      print("MULTI PARAMS: ${formData.fields}");

      response = await _dio.put(url,
          data: formData, //jsonEncode(formData),
          // cancelToken: cancelToken,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return response;
      } else if (response.statusCode == 401) {
        logOut();
        return response;
      } else if (response.statusCode == 1001) {
        logOut();
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      // debugPrint(e.message);
      // response = e.response!;
      // return response;

      debugPrint(e.message);
      print("ERRROR RES: ${e.message}");
      response = e.response;
      // ToastUtil.showToast("${e.message}");
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response?.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return response;
    }
  }

  Future<Map<String, dynamic>?> putRequestFormData(
      String url, FormData body) async {
    Response response;
    try {
      debugPrint("Data is ${body.fields}");
      response = await _dio.put(url,
          // cancelToken: cancelToken,
          data: body,
          options: Options(headers: await getHeaders()));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 203) {
        return response.data;
      } else if (response.statusCode == 409) {
        ToastUtil.showToast(response.data['message']);
        return null;
      } else if (response.statusCode == 401) {
        logOut();
        return null;
      } else if (response.statusCode == 1001) {
        logOut();
        return null;
      } else {
        return null;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      response = e.response!;
      if (response.statusCode == 500) {
        return response.data;
      }
      if (response?.statusCode == 401) {
        print("1 SHARED CLEARED CONGRATES");
        logOut();
        ToastUtil.showToast(response.data['message']);
      } else if (response?.statusCode == 1001) {
        logOut();
      }
      return null;
    }
  }
}
