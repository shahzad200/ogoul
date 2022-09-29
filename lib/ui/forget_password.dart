
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogule/data/controllers/forget_password_controller.dart';

import 'package:ogule/values/colors.dart';
import 'package:ogule/widgets/custom_round_button.dart';
import 'package:ogule/widgets/custom_textformfield.dart';
import 'package:ogule/widgets/heading.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (_) {

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
                              height: 50,
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
                            CustomRoundButton(
                              text: 'Reset Password',
                              onPress: () {

                                if (_.formKey.currentState!.validate()) {
                                  _.formKey.currentState!.save();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _.onReset(context);

                                }
                                _.emailController.text="";
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            CustomRoundButton(buttonColor: Colors.orange,textColor: Colors.black,
                              text: 'Back to Login',borderColor: Colors.orange,
                              onPress: () {
                              Get.back();
                                    }



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
