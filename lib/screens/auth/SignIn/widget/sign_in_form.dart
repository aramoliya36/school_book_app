import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/screens/auth/SignUp/sign_up.dart';
import 'package:skoolmonk/screens/auth/SignUp/widget/sign_up_form.dart';
import 'package:skoolmonk/screens/foegotpasswordScreen/forgot_password_screen.dart';

TextEditingController mobileNoTextEditingController = TextEditingController();

TextEditingController passwordTextEditingController = TextEditingController();

Widget signInForm(BuildContext context) {
  return Obx(() => Material(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: Get.height * 0.012),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(),

                GestureDetector(
                  onTap: () {
                    Get.to(SignUpScreen());
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: CommonTextStyle.register,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.013),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      border:
                          Border.all(width: 2.0, color: ColorPicker.navyBlue),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBox(),
                Container(
                  width: Get.width,
                  child: Center(
                    child: Text('OR', style: CommonTextStyle.orText),
                  ),
                ),
                sizedBox(),

                ///Mobile Number...
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                    child: Column(
                      children: [
                        CommanWidget.getTextFormField(
                          keyboardType: TextInputType.phone,
                          labelText: "",
                          textEditingController: mobileNoTextEditingController,
                          inputLength: 10,
                          regularExpression: Utility.digitsValidationPattern,
                          validationMessage:
                              Utility.mobileNumberInValidValidation,
                          validationType: 'mobileno',
                          hintText: "Enter Mobile No",
                        ),

                        ///Password ...
                        CommanWidget.getTextFormField(
                          labelText: "",
                          textEditingController: passwordTextEditingController,
                          inputLength: 30,
                          regularExpression: Utility.password,
                          validationMessage: "Password is required",
                          validationType: 'password',
                          obscureOnTap: () {
                            validationController.loginPasswordToggle();
                          },
                          obscureValue:
                              validationController.loginPasswordObscure.value,
                          hintText: "Enter Password",
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(ForgotPasswordScreen());
                            // validationController.forgotPasswordFlag.value =
                            //     true;
                            // validationController.forgotPasswordPageIndex.value =
                            //     0;
                          },
                          child: Container(
                            width: Get.width,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: ColorPicker.navyBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.023),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget sizedBox() {
  return SizedBox(
    height: Get.height / 30,
  );
}
