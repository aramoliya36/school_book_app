import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/forgot_password_req_model.dart';
import 'package:skoolmonk/model/responseModel/forgot_password_responce_model.dart';
import 'package:skoolmonk/screens/foegotpasswordScreen/widget/forgot_password_form.dart';
import 'package:skoolmonk/screens/resetpasswordscreen/reset_password_screen.dart';
import 'package:skoolmonk/viewModel/forgot_password_view_model.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Size deviceSize;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValidationController validationController =
      Get.put(ValidationController());
  ForgotPasswordViewModel forgotPasswordViewModel =
      Get.put(ForgotPasswordViewModel());
  // LoginViewModel loginViewModel = Get.put(LoginViewModel());

  @override
  void initState() {
    // TODO: implement initState
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
        title: "Forgot Password",
        onPress: () {
          Get.back();
          mobileNoTextEditingController.clear();
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
                child: Image.asset('assets/images/forgot_image.jpg'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(key: _formKey, child: forgotPasswordForm(context)),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
              GetBuilder<ForgotPasswordViewModel>(
                init: forgotPasswordViewModel,
                builder: (controller) {
                  if (forgotPasswordViewModel.apiResponse.status ==
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
                child: authBottomButton(
                  title: "GET OTP",
                  onTap: onForgotButtonTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onForgotButtonTap() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      validationController.progressVisible.value = true;
      ForgotPasswordReqModel forgotPasswordReqModel = ForgotPasswordReqModel();
      forgotPasswordReqModel.phone = mobileNoTextEditingController.text;
      await forgotPasswordViewModel.forgotPassword(forgotPasswordReqModel);
      if (forgotPasswordViewModel.apiResponse.status == Status.COMPLETE) {
        ForgotPasswordResponce responce =
            forgotPasswordViewModel.apiResponse.data;
        if (responce.status == 200) {
          Future.delayed(Duration(seconds: 2), () {
            Get.off(ResetPasswordScreen(
              mobile: responce.response[0].mobile.toString(),
            ));
            mobileNoTextEditingController.clear();
          });
        } else {
          CommonSnackBar.showSnackBar(msg: responce.message);
        }
      } else {
        CommonSnackBar.showSnackBar(msg: "Please try again!");
      }
    }
  }
}
