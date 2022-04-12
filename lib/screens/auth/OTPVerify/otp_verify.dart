import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/controller/auth_viewmodel.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/getotp_req_model.dart';
import 'package:skoolmonk/model/reqestModel/otpVerify_req_model.dart';
import 'package:skoolmonk/model/responseModel/getotp_responce_model.dart';
import 'package:skoolmonk/model/responseModel/otpVerify_responce_model.dart';

import 'package:skoolmonk/viewModel/get_otp_view_model.dart';
import 'package:skoolmonk/viewModel/otpVerify_view_model.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  final String userId;

  const OTPScreen({Key key, this.mobile, this.userId}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Size deviceSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find();

  TextEditingController otpEditingController;
  final ValidationController validationController =
      Get.put(ValidationController());
  @override
  void initState() {
    // TODO: implement initState
    getOTPButtontap();
    otpEditingController = TextEditingController();
    super.initState();
  }

  GetOTPViewModel getOTPViewModel = GetOTPViewModel();
  OTPVerifyViewModel otpVerifyViewModel = OTPVerifyViewModel();

  @override
  Widget build(BuildContext context) {
    // print("userID>>>>>>>>${widget.userId}");
    // print("mobile>>>>>>>>${widget.mobile}");
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
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
                height: 400,
                child: Image.asset(
                  'assets/images/otp_verify.jpg',
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Form(key: _formKey, child: otpForm(context)),
              SizedBox(
                height: Get.height * 0.03,
              ),
              GetBuilder<OTPVerifyViewModel>(
                init: otpVerifyViewModel,
                builder: (controller) {
                  if (otpVerifyViewModel.apiResponse.status == Status.LOADING) {
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
              GetBuilder<GetOTPViewModel>(
                init: getOTPViewModel,
                builder: (controller) {
                  if (getOTPViewModel.apiResponse.status == Status.LOADING) {
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: authBottomButton(
                  title: "VERIFY OTP",
                  onTap: otpVerifyOnTap,
                ),
              ),
              // SvgPicture.asset("assets/ig.svg"),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return CommonAppBar.authAppBar(
        title: "OTP Verify",
        onPress: () {
          otpEditingController.clear();
          Get.back();
        });
  }

  Widget otpForm(BuildContext context) {
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
            Text(
              'OTP has been sent to your registered mobile number ${widget.mobile}',
              style: TextStyle(color: ColorPicker.navyBlue, fontSize: 16),
            ),

            ///Mobile Number...
            // CommanWidget.getTextFormField(
            //     labelText: "Mobile Number Verification",
            //     textEditingController: mobileNoEditingController,
            //     inputLength: 10,
            //     isEnable: false,
            //     regularExpression: Utility.digitsValidationPattern,
            //     validationMessage: Utility.mobileNumberInValidValidation,
            //     validationType: 'mobileno',
            //     hintText: "Enter Mobile No"),
            // authBottomButton(title: "GET OTP", onTap: getOTPButtontap),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinCodeTextField(
                appContext: context,
                obscuringCharacter: '*',

                pastedTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.02),
                length: 4,

                obscureText: false,
                animationType: AnimationType.none,
                validator: (v) {
                  if (v.length < 4) {
                    return "otp is required";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  selectedFillColor: Colors.white,
                  disabledColor: Colors.red,
                  activeColor: Colors.grey,
                  selectedColor: ColorPicker.navyBlue,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: Get.height * 0.06,
                  fieldWidth: Get.width * 0.11,
                  activeFillColor: Colors.white,
                  // hasError ? Colors.orange : Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(fontSize: Get.height * 0.02, height: 1.6),
                backgroundColor: Colors.white,
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
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getOTPButtontap() async {
    validationController.progressVisible.value = true;
    GetOTPReqModel getOTPReqModel = GetOTPReqModel();
    getOTPReqModel.phone = widget.mobile;
    getOTPReqModel.userId = widget.userId.toString();
    getOTPViewModel.getOtp(getOTPReqModel);
  }

  Future<void> otpVerifyOnTap() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      log("LEN OTP ${otpEditingController.text.length}");
      if (otpEditingController.text.length == 4) {
        GetOtpResponce responce = getOTPViewModel.apiResponse.data;
        OTPVerifyReq otpVerifyReq = OTPVerifyReq();
        otpVerifyReq.phone = widget.mobile;
        otpVerifyReq.userId = widget.userId.toString();
        otpVerifyReq.otp = responce.response[0].otp.toString();
        await otpVerifyViewModel.otpVerify(otpVerifyReq);
        if (otpVerifyViewModel.apiResponse.status == Status.COMPLETE) {
          OtpVerifyResponce responce = otpVerifyViewModel.apiResponse.data;
          if (responce.status == 200) {
            if (responce.message ==
                "Mobile Number has been verified successfully!") {
              CommonSnackBar.showSnackBar(
                  msg: responce.message, successStatus: true);

              authController.setLogin(true);

              Future.delayed(Duration(seconds: 2), () {
                Get.back();
              });
            } else {
              CommonSnackBar.showSnackBar(msg: responce.message);
            }
          } else {
            CommonSnackBar.showSnackBar(msg: "Please try again...");
          }
        } else {
          CommonSnackBar.showSnackBar(msg: "Please try again.sd");
        }
      }
    }
  }
}
