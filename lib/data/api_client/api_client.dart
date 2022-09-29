

import 'package:get/get.dart';
import 'package:ogule/data/model/login_model.dart';
import 'package:ogule/data/model/reset_password_model.dart';

class ApiClient extends GetConnect{

  static const _baseUrl = "https://ogoullms.com/api/";

  static const _endPLogin = 'login';
  static const _endPResetPassword = 'password/email';

  Future<LoginModel> onLogin({
    required String email,
    required String password,
    required String timeZone,
    required String activityTitle,
    required String deviceType,
    required String os,
    required String version,
  }) async {
    LoginModel? loginModel;
    // httpClient.timeout = const Duration(seconds: 100);
    try {
      print("jsdlkjsadklasd");

      print(email.toString());
      print(password.toString());
      print(timeZone.toString());
      print(activityTitle.toString());
      print(deviceType.toString());
      print(os.toString());
      print(version.toString());
      print("nnnnn");
      final response = await post(
    "$_baseUrl$_endPLogin",
          {
            'email': email,
            'password': password,
            'timezone': timeZone,
            'activity_title': activityTitle,
            'device_type': deviceType,
            'os': os,
            'version': version
          },
    headers: {'Accept': 'application/json'});
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(response.body);
        if (loginModel.meta!.code! == 200) {
          return loginModel;
        } else {
          throw Exception(loginModel.meta!.message!);
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + loginModel!.meta!.message!) {
        throw Exception(loginModel!.meta!.message!);
      } else {
        throw Exception('No Internet');
      }
    }
  }
  Future<ResetPassword> onResetPassword({
    required String email,

  }) async {
    ResetPassword? resetPassword;
    httpClient.timeout = const Duration(seconds: 100);

    try {
      final response = await post(
          "$_baseUrl$_endPResetPassword",
          {
            'email': email,

          },
          // headers: {'Accept': 'appresetPasswordlication/json'}
           );

      printInfo(info: response.body.toString());

      if ( response.statusCode == 202) {

        print("<<<<<<<<<saim>>>>>>>");
       var resetPassword = ResetPassword.fromJson(response.body);
        return resetPassword;
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' ) {
        print("jdkshdjkahsdjkkkkkk");
        throw Exception(resetPassword!.error!);
      } else {
        throw Exception('No Internet');
      }
    }
  }




}
