import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/getotp_req_model.dart';
import 'package:skoolmonk/model/reqestModel/otpVerify_req_model.dart';
import 'package:skoolmonk/model/reqestModel/update_mobile_req_model.dart';
import 'package:skoolmonk/model/responseModel/getotp_responce_model.dart';
import 'package:skoolmonk/model/responseModel/otpVerify_responce_model.dart';
import 'package:skoolmonk/model/responseModel/update_mobile_responce_model.dart';

import 'package:skoolmonk/viewModel/get_otp_view_model.dart';
import 'package:skoolmonk/viewModel/otpVerify_view_model.dart';
import 'package:skoolmonk/viewModel/update_mobile_view_model.dart';

class UpdateMobileOTPScreen extends StatefulWidget {
  @override
  _UpdateMobileOTPScreenState createState() => _UpdateMobileOTPScreenState();
}

class _UpdateMobileOTPScreenState extends State<UpdateMobileOTPScreen> {
  Size deviceSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController mobileNoEditingController;
  TextEditingController otpEditingController;
  final ValidationController validationController =
      Get.put(ValidationController());
  GetOTPViewModel getOTPViewModel = Get.put(GetOTPViewModel());
  UpdateMobileViewModel updateMobileViewModel =
      Get.put(UpdateMobileViewModel());
  OTPVerifyViewModel otpVerifyViewModel = Get.put(OTPVerifyViewModel());
  @override
  void initState() {
    // TODO: implement initState

    mobileNoEditingController = TextEditingController();
    otpEditingController = TextEditingController();
    super.initState();
  }

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
                height: Get.height,
                child: Stack(
                  children: [
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      bottom: Get.height * 0.15,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: Get.height * 0.2,
                            width: Get.width * 0.2,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Form(key: _formKey, child: otpForm(context)),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<OTPVerifyViewModel>(
                      init: otpVerifyViewModel,
                      builder: (controller) {
                        if (otpVerifyViewModel.apiResponse.status ==
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
                    GetBuilder<GetOTPViewModel>(
                      init: getOTPViewModel,
                      builder: (controller) {
                        if (getOTPViewModel.apiResponse.status ==
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

              // SvgPicture.asset("assets/ig.svg"),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: authBottomButton(
            title: "VERIFY OTP",
            onTap: otpVerifyOnTap,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return CommonAppBar.authAppBar(
        title: "MobileNo. Update",
        onPress: () {
          Get.back();
          mobileNoEditingController.clear();
          otpEditingController.clear();
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

            ///Mobile Number...
            CommanWidget.getTextFormField(
                labelText: "New Mobile Number ",
                textEditingController: mobileNoEditingController,
                inputLength: 10,
                regularExpression: Utility.digitsValidationPattern,
                validationMessage: Utility.mobileNumberInValidValidation,
                validationType: 'mobileno',
                hintText: "Enter Mobile No"),
            authBottomButton(title: "GET OTP", onTap: getOTPButtontap),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinCodeTextField(
                appContext: context,

                pastedTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.02),
                length: 4,

                obscureText: false,
                obscuringCharacter: '*',
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
    FocusScope.of(context).unfocus();
    validationController.progressVisible.value = true;
    UpdateMobileNoReqModel updateMobile = UpdateMobileNoReqModel();
    updateMobile.userId = await PreferenceManager.getTokenId();
    updateMobile.phone = mobileNoEditingController.text;
    await updateMobileViewModel.updateMobile(updateMobile);

    if (updateMobileViewModel.apiResponse.status == Status.COMPLETE) {
      UpdateMobileNoResponce responce = updateMobileViewModel.apiResponse.data;

      if (responce.status == 200) {
        CommonSnackBar.showSnackBar(msg: responce.message, successStatus: true);

        GetOTPReqModel getOTPReqModel = GetOTPReqModel();
        getOTPReqModel.phone = responce.response[0].mobile.toString();
        getOTPReqModel.userId = PreferenceManager.getTokenId();
        await getOTPViewModel.getOtp(getOTPReqModel);
      } else {
        CommonSnackBar.showSnackBar(msg: responce.message);
      }
    } else {
      CommonSnackBar.showSnackBar(msg: "please try again! ");
    }
  }

  Future<void> otpVerifyOnTap() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      // log("LEN OTP ${otpEditingController.text.length}");
      GetOtpResponce responce = getOTPViewModel.apiResponse.data;
      if (otpEditingController.text.length == 4) {
        OTPVerifyReq otpVerifyReq = OTPVerifyReq();
        otpVerifyReq.phone = mobileNoEditingController.text;
        otpVerifyReq.userId = PreferenceManager.getTokenId();
        otpVerifyReq.otp = responce.response[0].otp.toString();
        await otpVerifyViewModel.otpVerify(otpVerifyReq);
        if (otpVerifyViewModel.apiResponse.status == Status.COMPLETE) {
          OtpVerifyResponce responce = otpVerifyViewModel.apiResponse.data;
          if (responce.status == 200) {
            if (responce.message ==
                "Mobile Number has been verified successfully!") {
              CommonSnackBar.showSnackBar(
                  msg: responce.message, successStatus: true);
              Future.delayed(Duration(seconds: 2), () {
                Get.back();
                responce.response[0].otp = "";
                mobileNoEditingController.clear();
              });
            } else {
              CommonSnackBar.showSnackBar(msg: responce.message);
            }
          } else {
            CommonSnackBar.showSnackBar(msg: "Please try again...");
          }
        } else {
          CommonSnackBar.showSnackBar(msg: "Please try again.");
        }
      }
    }
  }
}
