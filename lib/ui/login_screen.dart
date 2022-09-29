import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogule/data/controllers/login_screen_controller.dart';
import 'package:ogule/ui/forget_password.dart';
import 'package:ogule/ui/home_screen.dart';
import 'package:ogule/values/colors.dart';
import 'package:ogule/widgets/custom_round_button.dart';
import 'package:ogule/widgets/custom_textformfield.dart';
import 'package:ogule/widgets/heading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<LoginScreenController>(
        init: LoginScreenController(),
        builder: (_) {

          // return Scaffold(
          //   key: _.scaffoldKey,
          //   backgroundColor: AppColors.whiteColor,
          //   body: _.isLoading
          //       ? const Center(child: CircularProgressIndicator())
          //       : Stack(
          //           children: [
          //             Image.asset(
          //               'assets/images/bg.png',
          //               fit: BoxFit.cover,
          //               height: Get.height,
          //               width: Get.width,
          //             ),
          //             Align(
          //                 alignment: Alignment.topCenter,
          //                 child: Image.asset('assets/images/ogoulEMS_logo_white.png',
          //                     height: 200, width: 200)),
          //             Center(
          //               child: SingleChildScrollView(
          //                   padding:  const EdgeInsets.only(top: 300.0, left: 20.0, right: 20, bottom: 0.0),
          //                 child: Form(
          //                   key: _.formKey,
          //                   child: Container(
          //                     margin: const EdgeInsets.only(top: 10.0),
          //                     child: ListView(
          //
          //                       shrinkWrap: true,
          //
          //                       keyboardDismissBehavior:
          //                       ScrollViewKeyboardDismissBehavior.onDrag,
          //                       children: <Widget>[
          //                         // const MizdahLogo(),
          //                         // const ExpandedWidth(
          //                         //   child:
          //                         const Align(
          //                           alignment: Alignment.bottomCenter,
          //                           child: Heading(
          //                             text: 'Welcome',
          //                             textColor: Colors.white,
          //                           ),
          //                         ),
          //                         // ),
          //                         const SizedBox(
          //                           height: 2,
          //                         ),
          //                         // const ExpandedWidth(
          //                         //   child:
          //                         const Align(
          //                            alignment: Alignment.topCenter,
          //                            child: Text(
          //                             'Sign in to Continue',
          //                             style: TextStyle(
          //                                 fontSize: 16, color: Colors.white),
          //                         ),
          //                          ),
          //                         // ),
          //                         const SizedBox(
          //                           height: 60,
          //                         ),
          //                         Align( alignment: Alignment.topCenter,
          //                           child: CustomTextFormField(
          //                             hint: 'Email',
          //                             icon: Icons.email,
          //                             textInputType: TextInputType.emailAddress,
          //                             fieldType: 0,
          //                             controller: _.emailController,
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 10.0,
          //                         ),
          //                         CustomTextFormField(
          //                           hint: 'Password',
          //                           obscureText: true,
          //                           icon: Icons.lock,
          //
          //                           onTextChange: (password) { _.onPasswordChanged(password);
          //                           _.update();},
          //                           controller: _.passwordController,
          //                         ),
          //
          //                         const SizedBox(
          //                           height: 20,
          //                         ),
          //                         InkWell(
          //                             onTap: () {
          //            Get.to(const ForgetPasswordScreen());
          //                             },
          //                             child:  const Heading(
          //                               text: "Don't remember your password?",
          //                               fontSize: 14,   textAlign: TextAlign.end,
          //                               textColor: AppColors.blackColor,
          //                             )),
          //                         const SizedBox(
          //                           height: 15.0,
          //                         ),
          //                         CustomRoundButton(
          //                           text: 'LOGIN',
          //                           onPress: () {
          //                             if (_.formKey.currentState!.validate()) {
          //                               _.formKey.currentState!.save();
          //                               FocusScope.of(context)
          //                                   .requestFocus(FocusNode());
          //                               _.onPressLogIn().then((value) {
          //                                 if (value) {
          //                                   Get.offAll(const HomeScreen());
          //                                 }
          //                               });
          //                             }
          //                           },
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          // );
          return Scaffold(
            key: _.scaffoldKey,
            backgroundColor: AppColors.whiteColor,
            body: _.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  height: Get.height,
                  width: Get.width,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/images/ogoulEMS_logo_white.png',
                        height: 200, width: 200)),
                Center(
                  child: SingleChildScrollView(
                    padding:  const EdgeInsets.only(top: 300.0, left: 20.0, right: 20, bottom: 0.0),
                    child: Form(
                      key: _.formKey,
                      child: Container(
                        // margin: const EdgeInsets.only(top: 5.0),
                        child: ListView(

                          shrinkWrap: true,

                          keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                          children: <Widget>[
                            // const MizdahLogo(),
                            // const ExpandedWidth(
                            //   child:
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Heading(
                                text: 'Welcome',
                                textColor: Colors.white,
                              ),
                            ),
                            // ),

                            const SizedBox(
                              height: 2,
                            ),
                            // const ExpandedWidth(
                            //   child:
                            const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Sign in to Continue',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            // ),
                            const SizedBox(
                              height: 60,
                            ),
                            Align( alignment: Alignment.topCenter,
                              child: CustomTextFormField(
                                hint: 'Email',
                                icon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                fieldType: 0,
                                controller: _.emailController,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextFormField(
                              hint: 'Password',
                              obscureText: true,
                              icon: Icons.lock,

                              onTextChange: (password) { _.onPasswordChanged(password);
                              _.update();},
                              controller: _.passwordController,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(const ForgetPasswordScreen());
                                },
                                child:  const Heading(
                                  text: "Don't remember your password?",
                                  fontSize: 14,   textAlign: TextAlign.end,
                                  textColor: AppColors.blackColor,
                                )),
                            const SizedBox(
                              height: 15.0,
                            ),
                            CustomRoundButton(
                              text: 'LOGIN',
                              onPress: () {
                                if (_.formKey.currentState!.validate()) {
                                  _.formKey.currentState!.save();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _.onPressLogIn().then((value) {
                                    if (value) {
                                      Get.offAll(const HomeScreen());
                                    }
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
