import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/auth_viewmodel.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';

import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/login_req_moel.dart';
import 'package:skoolmonk/model/responseModel/login_responce_model.dart';
import 'package:skoolmonk/screens/addCart/addcartscreen.dart';
import 'package:skoolmonk/screens/auth/SignIn/widget/sign_in_form.dart';
import 'package:skoolmonk/screens/auth/OTPVerify/otp_verify.dart';
import 'package:skoolmonk/screens/bottombar/navigation_bar.dart';
import 'package:skoolmonk/viewModel/login_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  Size deviceSize;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ValidationController validationController = Get.put(ValidationController());
  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  AuthController authController = Get.find();
  BottomController homeController = Get.find();
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    validationController.termCondition = false.obs;
    validationController.obscureText = true.obs;
    // _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return CommonAppBar.authAppBar(
        title: "Sign In",
        onPress: () {
          mobileNoTextEditingController.clear();
          passwordTextEditingController.clear();
          Get.back();
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
                width: Get.width,
                height: 300,
                child:
                    Image.asset('assets/images/sign_p.jpg', fit: BoxFit.cover),
              ),
              Container(
                height: Get.height,
                child: Column(
                  children: [
                    Form(key: _formKey, child: signInForm(context)),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    GetBuilder<LoginViewModel>(
                      builder: (controller) {
                        if (loginViewModel.apiResponse.status ==
                            Status.LOADING) {
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: authBottomButton(title: "SIGN IN", onTap: onSignInButtonTap),
        ),
      ],
    );
  }

  Future<void> onSignInButtonTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        validationController.progressVisible.value = true;
        LoginReqModel loginReqModel = LoginReqModel();
        loginReqModel.emailOrPhone = mobileNoTextEditingController.text;
        loginReqModel.password = passwordTextEditingController.text;
        await loginViewModel.login(loginReqModel);
        if (loginViewModel.apiResponse.status == Status.COMPLETE) {
          LoginResponce _loginRes = loginViewModel.apiResponse.data;
          PreferenceManager.setFnameId(_loginRes.response[0].fname);
          print("====login${_loginRes.status}");
          if (_loginRes.status == 200) {
            if (_loginRes.response[0].isMobileVerified == '0') {
              Get.to(OTPScreen(
                mobile: mobileNoTextEditingController.text,
                userId: "${_loginRes.response[0].userId}",
              ));
            } else {
              loginSuccess();
            }
          } else {
            CommonSnackBar.showSnackBar(
                msg: _loginRes.message, successStatus: false);
          }
        } else {
          CommonSnackBar.showSnackBar(msg: "Login Unsuccesfully");
        }
      }
    }
  }

  loginSuccess() async {
    LoginResponce loginResponce = loginViewModel.apiResponse.data;

    if (loginResponce.status == 200) {
      log(".....responce..${loginResponce.response[0].userId}");
      await PreferenceManager.setTokenId(loginResponce.response[0].userId);
      var userId = PreferenceManager.getTokenId();
      authController.setLogin(true);
      log("IS LOGIN STATUS  ${authController.isLogin.value}");

      CommonSnackBar.showSnackBar(
          msg: loginResponce.message, successStatus: true);
      Future.delayed(Duration(seconds: 2), () {
        mobileNoTextEditingController.clear();
        passwordTextEditingController.clear();
        Get.offAll(NavigationBarScreen());
        homeController.bottomIndex.value = 0;
        // Get.back();
      });
    } else {
      CommonSnackBar.showSnackBar(msg: loginResponce.message);
    }
  }
}
