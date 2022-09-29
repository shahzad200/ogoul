

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ogule/data/model/login_model.dart';
import 'package:ogule/data/shared_preferences/share_preference.dart';
class HomeScreenController extends GetxController{

  final sharedPrefClient = SharedPrefClient();
  LoginModel?loginModel;
   String userName="";

  late Location location;
  String state = 'State';
  @override
  void onInit() async {
    state = (await sharedPrefClient.getState())!;
    if(state == 'Start' || state == 'Stop'){
      state = state;
    } else{
      state = 'Start';
    }
    location = Location();
    userName= (await sharedPrefClient.getUserName())!;
    super.onInit();
    update();
  }


  Future<void> setUserOnline() async {
    printInfo(info: '-----Start');
    String? userId = await sharedPrefClient.getUserId();
    String? token = await sharedPrefClient.getUserToken();
    String? role = await sharedPrefClient.getRole();
      const platform = MethodChannel('com.ogoul.driver/driver');
     String s =  await platform.invokeMethod('driverOnline', {
        'driverId': userId!,
       'token': token!,
       'role': role!
      });
     if(s == 'success'){
       sharedPrefClient.setState('Stop');
       state = 'Stop';
       update();
     }

    }


  Future<void> setUserOffline() async {
    printInfo(info: '-----Stop');
    sharedPrefClient.setState('Start');
    const platform = MethodChannel('com.ogoul.driver/driver');
     String s = await platform.invokeMethod('driverOffline', {
      'driverId': '0'.toString(),
    });
    if(s == 'success'){
      sharedPrefClient.setState('Start');
      state = 'Start';
      update();
    }
  }


}
