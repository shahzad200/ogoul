import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';

import 'package:get/get.dart';
import 'package:ogule/data/api_client/api_client.dart';

import 'package:ogule/data/model/reset_password_model.dart';
import 'package:ogule/data/shared_preferences/share_preference.dart';

import '../../widgets/dialog_box.dart';

class ForgetPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _apiProvider = ApiClient();
  final sharedPrefClient = SharedPrefClient();
  TextEditingController emailController = TextEditingController();
  ResetPassword? resetPassword;
  bool isLoading = false;
  bool noInternet = false;

  @override
  void onInit() async {}

  // drivertwo@gmail.com
  // Qa123456

  onReset(context) async {
    try {
      isLoading = true;
      update();
      resetPassword =
          await _apiProvider.onResetPassword(email: emailController.text);
      isLoading = false;
      if (noInternet) {
        noInternet = false;
      }
      update();

      print(resetPassword!.success.toString());
      print("djsksdlsadjklasdjsakld");
      print(resetPassword!.error.toString());
      print("sannnnn");
      if (resetPassword!.success != null) {
        Fluttertoast.showToast(
          msg: "Request Submitted successfully",
          timeInSecForIosWeb: 5,
          textColor: Colors.white,
        );
        update();
      } else {
        Get.snackbar("error: We can't find a user with that e-mail address.",
            e.toString().replaceAll('Exception:', ''));
        update();
      }

      return true;
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading = false;
        noInternet = false;
        update();
        return false;
      } else {
        print("shahzad");
        isLoading = false;
        noInternet = true;
        update();
        // customDialogPinn(context,e.toString().replaceAll('Exception:', ''));
        Get.snackbar("error: We can't find a user with that e-mail address.",
            e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }
}
