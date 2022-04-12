import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/reset_password_req_model.dart';
import 'package:skoolmonk/model/responseModel/reset_passsword_responce_model.dart';
import 'package:skoolmonk/viewModel/get_profile.dart';
import 'package:skoolmonk/viewModel/reset_password_view_model.dart';

TextEditingController passwordTextEditingController = TextEditingController();

class ResetPasswordScreen extends StatefulWidget {
  final String mobile;

  const ResetPasswordScreen({this.mobile});
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileNoEditingController;
  TextEditingController otpEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  ResetPasswordViewModel resetPasswordViewModel =
      Get.put(ResetPasswordViewModel());
  GetProfileViewModel _getProfileViewModel = Get.find();

  ValidationController validationController = Get.put(ValidationController());
  @override
  void initState() {
    // TODO: implement initState

    mobileNoEditingController = TextEditingController(text: "${widget.mobile}");
    // otpEditingController = TextEditingController(text: "${widget.otp}");
    validationController.obscureText = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return CommonAppBar.authAppBar(
        title: "Reset Password",
        onPress: () {
          Get.back();
          passwordTextEditingController.clear();
          mobileNoEditingController.clear();
          confirmPasswordTextEditingController.clear();
        });
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.deepOrange,
                width: Get.width,
                height: Get.height / 4,
                child: Image.asset(
                  'assets/images/otp_vi.PNG',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Form(key: _formKey, child: resetPasswordForm(context)),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
              GetBuilder<ResetPasswordViewModel>(
                builder: (controller) {
                  if (controller.apiResponse.status == Status.LOADING) {
                    return Container(
                        color: Colors.black26,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorPicker.navyBlue),
                          ),
                        ));
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
                child: authBottomButton(
                    title: "Reset Password", onTap: resetButtonOnTap),
              ),

              // SvgPicture.asset("assets/ig.svg"),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> resetButtonOnTap() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      log("LEN OTP ${otpEditingController.text.length}");
      if (otpEditingController.text.length == 4) {
        if (passwordTextEditingController.text ==
            confirmPasswordTextEditingController.text) {
          ResetPasswordReqModel resetPassword = ResetPasswordReqModel();
          resetPassword.phone = widget.mobile.toString();
          resetPassword.otp = otpEditingController.text;
          resetPassword.password = passwordTextEditingController.text;
          resetPassword.confirmPassword =
              confirmPasswordTextEditingController.text;

          await resetPasswordViewModel.resetPassword(resetPassword);

          if (resetPasswordViewModel.apiResponse.status == Status.COMPLETE) {
            ResetPasswordResponce responce =
                resetPasswordViewModel.apiResponse.data;
            if (responce.status == 200) {
              CommonSnackBar.showSnackBar(
                  msg: responce.message, successStatus: true);
              Future.delayed(Duration(seconds: 2), () {
                Get.back();
                passwordTextEditingController.clear();
                confirmPasswordTextEditingController.clear();
              });
            } else {
              CommonSnackBar.showSnackBar(msg: responce.message);
            }
          } else {
            CommonSnackBar.showSnackBar(msg: "Please try again!");
          }
        } else {
          CommonSnackBar.showSnackBar(
              msg: "Password and confirm password does not match!");
        }
      }
    }
  }

  Widget resetPasswordForm(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // shrinkWrap: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),

            ///Mobile Number...
            Text(
              'OTP has been sent to your registered mobile number ${widget.mobile}',
              style: TextStyle(),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v.length < 4) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.grey,
                      selectedColor: Colors.grey,
                      selectedFillColor: Colors.white),

                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20, height: 1.6),
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: otpEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      // currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                )),
            CommanWidget.getTextFormField(
              labelText: "Password (Minimum 8 Characters)",
              textEditingController: passwordTextEditingController,
              inputLength: 30,
              obscureValue: true,
              regularExpression: Utility.password,
              validationMessage: "Password is required",
              validationType: 'password',
              hintText: "Enter Password",
            ),

            ///Confirm Password ...
            CommanWidget.getTextFormField(
              labelText: "Conform Password (Minimum 8 Characters)",
              textEditingController: confirmPasswordTextEditingController,
              inputLength: 30,
              obscureValue: true,
              regularExpression: Utility.password,
              validationMessage: "Conform Password is required",
              validationType: 'password',
              hintText: "Enter Conform Password",
            ),
          ],
        ),
      ),
    );
  }
}
