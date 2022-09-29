
import 'dart:io';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogule/data/api_client/api_client.dart';
import 'package:ogule/data/api_client/socket_io.dart';
import 'package:ogule/data/model/login_model.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:ogule/data/shared_preferences/share_preference.dart';

class LoginScreenController extends GetxController {

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _apiProvider = ApiClient();
  final sharedPrefClient = SharedPrefClient();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool noInternet = false;
  LoginModel? loginModel;
  String? currentTimeZone;
  String? os;
  String? activityTitle = 'driver location';
  String? deviceType = "phone";
  String? version = "1.0";
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


      _isPasswordEightCharacters = false;
      if(password.length >= 8)
        _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if(numericRegex.hasMatch(password))
        _hasPasswordOneNumber = true;
    update();
  }
  @override
  void onInit() async {

    currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    if(Platform.isAndroid){
      os = 'Android';
    } else{
      os = 'iOS';
    }
    super.onInit();
  }


  // drivertwo@gmail.com
  // Qa123456


  Future<bool> onPressLogIn() async {
    try {

     print (  emailController.text.toString(),);
      print( passwordController.text);


    // print (  loginModel!.data!.id.toString());
    //
      isLoading = true;
      update();

      print("shahzad");
      loginModel = await _apiProvider.onLogin(
          email: emailController.text,
          password: passwordController.text,
          timeZone: currentTimeZone!, activityTitle: activityTitle!,
          deviceType: deviceType!, os: os!, version: version!);
      sharedPrefClient.setUserToken(loginModel!.data!.apiToken!);
      // SocketServer.connectSocket(loginModel!.data!.id.toString());
      sharedPrefClient.setUserId(loginModel!.data!.id.toString());
      sharedPrefClient.setRole(loginModel!.data!.role!);
      sharedPrefClient.setUserEmail(loginModel!.data!.email!);
      sharedPrefClient.setUserName(loginModel!.data!.name!);
     sharedPrefClient.setUserPhone(loginModel!.data!.phone!);

     print("annnn");
     // print(get=.toString())
print(loginModel!.data!.name.toString());
     print( sharedPrefClient.setUserName(loginModel!.data!.name!));
      isLoading = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
      return true;
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading = false;
        noInternet = true;
        update();
        return false;
      } else {
        isLoading = false;
        noInternet = true;
        update();
        Fluttertoast.showToast(
            msg: e.toString().replaceAll('Exception:', ''),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.snackbar("LogIn", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }

}
