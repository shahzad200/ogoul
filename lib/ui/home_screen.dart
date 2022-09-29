import 'package:flutter/material.dart';
import 'package:ogule/data/controllers/home_screen_controller.dart';
import 'package:ogule/ui/login_screen.dart';
import 'package:ogule/widgets/custom_round_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (_) {
          return Scaffold(
              body: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top:70),
                    child: Text(_.userName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 18),),
                  ),

                  Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.cover,
                    height: Get.height,
                    width: Get.width,
                  ),


               // Text(_.userName),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/images/bus.png',
                            height: 300, width: 300)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 30,top:60,),
                    child: Text(_.userName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20),),
                  ),
                  Positioned(
                    top: 40,
                      right: 20,
                      child: IconButton(
                    icon: const Icon(Icons.power_settings_new_outlined,size: 50,color: Colors.white,),
                    onPressed: () async {
                      await  _.sharedPrefClient.setUserId('-21');
                      await _.setUserOffline();
                      Get.offAll(const LoginScreen());
                    },
                  )),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 50.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: CustomRoundButton(
                  //       text: 'LogOut',
                  //       width: 120,
                  //       onPress: () async {
                  //       await  _.sharedPrefClient.setUserId('-21');
                  //       await _.setUserOffline();
                  //       Get.offAll(const LoginScreen());
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // _.state == 'Start' ?
                  Positioned(
                    left: Get.width / 4.5,
                    top: Get.height / 1.7,
                    child:
                    InkWell(
                      onTap: () {
                        _.state == 'Start' ?
                        _.setUserOnline() :
                        _.setUserOffline();
                      },
                      child: Image.asset(_.state == 'Start'
                          ? 'assets/images/start.png'
                          : 'assets/images/stop.png',
                          height: 200, width: 200),
                    ),
                  )
                  //     :
                  // Positioned(
                  //   left: Get.width/4.5,
                  //   top: Get.height/1.7,
                  //   child: InkWell(
                  //     onTap: (){
                  //       _.state == 'Start' ?
                  //       _.setUserOnline() :
                  //       _.setUserOffline();
                  //     },
                  //     child: Image.asset(_.state == 'Start' ? 'assets/images/start.png' : 'assets/images/stop.png',
                  //         height: 200, width: 200),
                  //   ),
                  // )

                  // Center(
                  //     child: CustomRoundButton(
                  //       onPress: (){
                  //         // printInfo(info: 'STATE------'+_.state);
                  //         _.state == 'Start' ?
                  //
                  //         _.setUserOnline() :
                  //
                  //         _.setUserOffline();
                  //
                  //       },
                  //       text: _.state,
                  //       roundCornersRadius: 100,
                  //       height: 200,
                  //       width: 200,
                  //     )),

                ],
              ),



          );
        });
  }
}
