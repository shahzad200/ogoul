import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:get/get.dart';
import 'package:ogule/data/api_client/socket_io.dart';
import 'package:ogule/data/shared_preferences/share_preference.dart';
import 'package:ogule/ui/home_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);


  final _sharedPrefClient = SharedPrefClient();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterBuild(context));
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
        ],
      ),
    );
  }

  void _afterBuild(BuildContext context) => _checkInternetAndProceed(context);

  void _checkInternetAndProceed(BuildContext context) async {
    var flagConnected = false;
    try {
      final result =
      await InternetAddress.lookup('google.com').timeout(const Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        flagConnected = true;
      }
    } catch (_) {}
    if (flagConnected) {
      checkLocation().then((value) async {
        if(value){
          String? userId = await _sharedPrefClient.getUserId();
          if ( userId == '-21' ) {
            Get.offAll(const LoginScreen());
          } else {
            SocketServer.connectSocket(userId!);
            Get.offAll(const HomeScreen());
          }
        }
      });
    }
    else {
      _onNoInternet(context);
    }
  }




  Future<bool> checkLocation() async {
    try {
      final location = loc.Location();
      if (await location.serviceEnabled()) {
        final perm = await location.hasPermission();
        if (perm == loc.PermissionStatus.granted ||
            perm == loc.PermissionStatus.grantedLimited) {
          // Strings.locationPermission = 'granted';
          return true;
        } else if (perm == loc.PermissionStatus.denied) {
          final perm = await location.requestPermission();
          if (perm == loc.PermissionStatus.granted ||
              perm == loc.PermissionStatus.grantedLimited) {
            // Strings.locationPermission = 'granted';
            return true;
          } else if (perm == loc.PermissionStatus.denied) {
            // Strings.locationPermission = 'denied';
            return false;
          } else if (perm == loc.PermissionStatus.deniedForever) {
            // Strings.locationPermission = 'deniedForever';
            return false;
          } else {
            return false;
          }
        } else if (perm == loc.PermissionStatus.deniedForever) {
          // Strings.locationPermission = 'deniedForever';
          return false;
        } else {
          return false;
        }
      } else {
        final service = await location.requestService();
        if (service) {
          final perm = await location.hasPermission();
          if (perm == loc.PermissionStatus.granted ||
              perm == loc.PermissionStatus.grantedLimited) {
            // Strings.locationPermission = 'granted';
            return true;
          } else if (perm == loc.PermissionStatus.denied) {
            final perm = await location.requestPermission();
            if (perm == loc.PermissionStatus.granted ||
                perm == loc.PermissionStatus.grantedLimited) {
              // Strings.locationPermission = 'granted';
              return true;
            } else if (perm == loc.PermissionStatus.denied) {
              // Strings.locationPermission = 'denied';
              return false;
            } else if (perm == loc.PermissionStatus.deniedForever) {
              // Strings.locationPermission = 'deniedForever';
              return false;
            } else {
              return false;
            }
          } else if (perm == loc.PermissionStatus.deniedForever) {
            // Strings.locationPermission = 'deniedForever';
            return false;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  void _onNoInternet(BuildContext context) {
    // print("#showModalBottomSheet");
    showModalBottomSheet<void>(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:  Radius.circular(10.0),
          topRight:  Radius.circular(10.0),
        ),
      ),
      builder: (builderContext) => _buildNoInternetWgt(context, builderContext),
    );
  }

  Widget _buildNoInternetWgt(
      BuildContext context, BuildContext builderContext) {

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Internet Connection',
            style: Theme.of(context).textTheme.headline6,
          ),
          Image.asset(
            'assets/images/no_internet.png',
            width: 200.0,
            height: 200.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(builderContext);
              _checkInternetAndProceed(context);
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }


}
