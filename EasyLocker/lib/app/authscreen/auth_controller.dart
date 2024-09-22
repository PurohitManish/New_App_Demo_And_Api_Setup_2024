import 'dart:convert';
import 'dart:math';
import 'package:EasyLocker/app/authscreen/otpscreen.dart';
import 'package:EasyLocker/app/homescreen.dart';
import 'package:EasyLocker/main.dart';
import 'package:EasyLocker/services/api_service.dart';
import 'package:EasyLocker/services/http_helper.dart';
import 'package:EasyLocker/utils/app_toast.dart';
import 'package:EasyLocker/utils/enums.dart';
import 'package:EasyLocker/utils/token_generator.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? _verificationId;
  String? uid;
  String? apptoken;
  int? forceResendingToken;

  //var conCode = "+91";
  // RxString selectedCountry = "+91".obs;
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  var httpHelper = HttpHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isSocialLoading = false.obs;
  void onInit() {
    super.onInit();
    addTokenToApi();
  }

  Future<bool?> addTokenToApi() async {
    loadingcontroller.updateLoading(true);
    apptoken = getRandomString(32);
    bool? result = await addToken(phoneController.text, apptoken);
    loadingcontroller.updateLoading(false);
    print('token123:- ${apptoken}');
    return result;
  }

  //////////////
  Future<void> savetoken(context) async {
    // await addTokenToApi();
    print('phoneController.text1:${phoneController.text}');
    print('apptoke1:${apptoken}');
    var _params = {
      "phoneNumber": phoneController.text,
      "token": apptoken,
    };

    httpHelper.post(URL.savetokenUrl, _params).then((value) async {
      if (value?.data != null) {
        var json1 = value?.data; // Navigator.push(
        print('phoneController.text1:${phoneController.text}');
        print('apptoke1:${apptoken}');
        if (value?.statusCode == 200 || value?.statusCode == 201) {
          // Get.to(() => BottomNavigationBarCustom());

          // Fluttertoast.showToast(
          //     msg: "${json1['message']}",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.green,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          await signInwithPhone("Login", context);
        } else {
          var json1 = value?.data;
          Fluttertoast.showToast(
              msg: "${json1['message']}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }
      } else {
        print('data null error');
      }
    });
  }

////////////////////
  signInwithPhone(screen, context,
      {ScreenOperation screenOps = ScreenOperation.add,
      bool fromContactPhone = false}) async {
    if (phoneController.text.isEmpty) {
      showSnackBar(context, "Phone Number Required");
      return;
    }
    loadingcontroller.updateLoading(true);

    // Ensure token is generated
    // await addTokenToApi();
    if (apptoken == null) {
      showSnackBar(context, "Failed to generate token");
      loadingcontroller.updateLoading(false);
      return;
    }

    // Ensure the phone number is in E.164 format
    String phoneNumber = "+${selectedCountry.phoneCode}${phoneController.text}";
    if (!RegExp(r'^\+\d{1,3}\d{1,14}$').hasMatch(phoneNumber)) {
      showSnackBar(context,
          "Invalid phone number format. Please enter a valid phone number.");
      return;
    }
    loadingcontroller.updateLoading(true);

    debugPrint("InsignIn");
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {}
    verificationFailed(FirebaseAuthException authException) {
      debugPrint("auth Exeception ${authException.message}");

      showSnackBar(context, "Invalid Number");
      loadingcontroller.updateLoading(false);
    }

    codeSent(String verificationId, [int? forceResendingToken]) async {
      this.forceResendingToken = forceResendingToken;
      _verificationId = verificationId;
      if (screen == "Login") {
        debugPrint("$_verificationId $apptoken");
        print('mobileNumber:- ${phoneController.text}');
        print('countryCode:-  +${selectedCountry.phoneCode}');
        print('verificationId:- ${verificationId}');
        print(' token!:- ${apptoken ?? ""}');
        print('fromContactPhone:- ${fromContactPhone}');
        print('screenOps:- ${screenOps}');
        Get.to(OtpScreen(
            mobileNumber: phoneController.text,
            countryCode: '+${selectedCountry.phoneCode}',
            verificationId: verificationId,
            token: apptoken ?? "",
            fromContactPhone: fromContactPhone,
            screenOps: screenOps));
        GetStorage().write('apptoken', apptoken);
        print('apptoken:-${GetStorage().read(
          'apptoken',
        )}');
        loadingcontroller.updateLoading(false);
      } else {
        showSnackBar(context, "Your OTP has been resent");
        loadingcontroller.updateLoading(false);
      }
    }

    codeAutoRetrievalTimeout(String verificationId) {
      debugPrint('verificationId: $verificationId');
      _verificationId = verificationId;
      debugPrint('verificationId: $_verificationId');
    }

    try {
      debugPrint("In try block");
      print(
          "Mobile Code: +${selectedCountry.phoneCode}${phoneController.text}");
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          forceResendingToken: forceResendingToken,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (e) {
      // longToastMessage("${e.message}");
      showSnackBar(context, "${e.message}");
      loadingcontroller.updateLoading(false);
    }
  }

  Future<bool?> addToken(mobileNo, apptoken) async {
    var body = ({
      "phone_number": "$mobileNo",
      "token": apptoken,
    });
  }

  void verifyOTP(context,
      {verificationId,
      smsCode,
      apptoken,
      countryCode,
      phoneNumber,
      required ScreenOperation screenOps,
      bool fromContactPhone = false}) async {
    if (smsCode != "") {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);
      try {
        loadingcontroller.updateLoading(true);
        await FirebaseAuth.instance.signInWithCredential(
          credential,
        );

        if (FirebaseAuth.instance.currentUser != null) {
          if (screenOps == ScreenOperation.add) {
            await login(
              context,
              1,
              phoneNumber,
              GetStorage().read(
                'apptoken',
              ),
              countryCode,
            );
            // Get.to(() => Home_Screen());
            // doLogin(countryCode, phoneNumber, token, context);
          }
        }
      } catch (e) {
        debugPrint("$e");
        loadingcontroller.updateLoading(false);

        showSnackBar(context, "Please  enter valid OTP");
      }
    } else {
      showSnackBar(context, "Please enter OTP");
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  Future<void> login(
    BuildContext context,
    int signupType,
    String phoneNumber,
    token,
    countryCode,
  ) async {
    var _params = {
      "signupType": signupType,
      "phoneNumber": phoneNumber,
      "token": token,
      // "password": "",
      "countryCode": countryCode,
    };

    isSocialLoading.value = true;
    httpHelper.post(URL.loginUrl, _params).then((value) async {
      // var json1 = value?.data;
      isSocialLoading.value = false;
      if (value?.data != null) {
        var json1 = value?.data;
        print('json1json1-->${json1}');
        final token = json1['token'];
        print(json1['message']);
        GetStorage().write('token', token);
        print('Saved Token :${GetStorage().read('token')}');

        SharedPreferences _prefs = await SharedPreferences.getInstance();
        await _prefs.setBool("isLoggedIn", true);
        print('isLoggedin:- ${_prefs.getBool('isLoggedIn')}');
        // Navigator.push(
        if (value?.statusCode == 200 || value?.statusCode == 201) {
          Get.to(() => Home_Screen());

          Fluttertoast.showToast(
              msg: "${json1['message']}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          var json1 = value?.data;
          ToastUtil.showToast(json1['message']);

          return;
        }
      } else {
        print('data null error');
      }
    });
  }
}
