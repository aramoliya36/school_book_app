import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/signup_req_model.dart';
import 'package:skoolmonk/model/responseModel/signup_responce_model.dart';
import 'package:skoolmonk/screens/auth/OTPVerify/otp_verify.dart';
import 'package:skoolmonk/screens/auth/SignUp/widget/sign_up_form.dart';
import 'package:skoolmonk/viewModel/get_homepage_viewmodel.dart';
import 'package:skoolmonk/viewModel/register_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
  Size deviceSize;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetHomePageViewModel _getHomePageViewModel = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    // _getHomePageViewModel.getHomePageViewModel();

    validationController.termCondition = false.obs;
    validationController.obscureText = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Stack _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          padding: EdgeInsets.only(bottom: 20),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                  height: Get.height * 0.2,
                  child: Lottie.asset("assets/svg/sign_up_lottie.json")),
              Form(key: _formKey, child: signUpForm(context)),
            ],
          ),
        ),
        GetBuilder<RegisterViewModel>(builder: (RegisterViewModel controller) {
          return Positioned(
            bottom: 0,
            child: authBottomButton(
              title: "REGISTER",
              onTap: () {
                signUpButon(controller);
              },
            ),
          );
        }),
        GetBuilder<RegisterViewModel>(
          builder: (controller) {
            if (registerViewModel.apiResponse.status == Status.LOADING) {
              return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(ColorPicker.navyBlue),
                    ),
                  ));
            } else {
              return SizedBox();
            }
          },
        )
      ],
    );
  }

  Future<void> signUpButon(RegisterViewModel controller) async {
    if (_formKey.currentState.validate()) {
      if (!validationController.termCondition.value) {
        CommonSnackBar.showSnackBar(msg: "Please select TERMS AND CONDITION");
        return;
      }

      if (controller.dob.value == null || controller.dob.value == "") {
        CommonSnackBar.showSnackBar(msg: "Please select date of birth");
        return;
      }
      FocusScope.of(context).unfocus();

      if (passwordTextEditingController.text ==
          conformPasswordTextEditingController.text) {
        SignUpReqModel signUpReqModel = SignUpReqModel();
        signUpReqModel.fname = nameTextEditingController.text;
        signUpReqModel.lname = lastNameTextEditingController.text;
        signUpReqModel.email = emailTextEditingController.text;
        signUpReqModel.phone = mobileNoTextEditingController.text;
        signUpReqModel.password = passwordTextEditingController.text;
        signUpReqModel.dob = controller.dob.value.toString();
        signUpReqModel.confirmPassword =
            conformPasswordTextEditingController.text;
        await registerViewModel.signUp(signUpReqModel);

        if (registerViewModel.apiResponse.status == Status.COMPLETE) {
          SignUpResponce responce = registerViewModel.apiResponse.data;
          if (responce.status == 200) {
            if (responce.response[0].alreadyExists == "1") {
              CommonSnackBar.showSnackBar(msg: responce.message);

              return;
            }
            CommonSnackBar.showSnackBar(
                msg: responce.message, successStatus: true);
            Future.delayed(Duration(seconds: 2), () {
              Get.off(OTPScreen(
                mobile: mobileNoTextEditingController.text,
                userId: "${responce.response[0].userId}",
              ));
              nameTextEditingController.clear();
              lastNameTextEditingController.clear();
              emailTextEditingController.clear();
              mobileNoTextEditingController.clear();
              passwordTextEditingController.clear();
              conformPasswordTextEditingController.clear();

              registerViewModel.setDOB("");
            });
          } else {
            CommonSnackBar.showSnackBar(
              msg: responce.message,
            );
          }
        } else {
          CommonSnackBar.showSnackBar(
            msg: "Registration failed",
          );
        }
      } else {
        CommonSnackBar.showSnackBar(
          msg: "Password not miss Match",
        );
      }
    }
  }

  AppBar _buildAppBar() {
    return CommonAppBar.authAppBar(
        title: "Sign Up",
        onPress: () {
          Get.back();
          nameTextEditingController.clear();
          lastNameTextEditingController.clear();
          emailTextEditingController.clear();
          mobileNoTextEditingController.clear();
          passwordTextEditingController.clear();
          conformPasswordTextEditingController.clear();
        });
  }
}
