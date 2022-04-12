import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';
import 'package:skoolmonk/screens/webViewScreen/web_view_screen.dart';
import 'package:skoolmonk/viewModel/get_homepage_viewmodel.dart';
import 'package:skoolmonk/viewModel/register_view_model.dart';

final ValidationController validationController =
    Get.put(ValidationController());
GetHomePageViewModel _getHomePageViewModel = Get.find();

TextEditingController nameTextEditingController = TextEditingController();
TextEditingController lastNameTextEditingController = TextEditingController();

TextEditingController emailTextEditingController = TextEditingController();

TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController mobileNoTextEditingController = TextEditingController();

TextEditingController conformPasswordTextEditingController =
    TextEditingController();

DateTime selectedDate = DateTime.now();

Widget signUpForm(BuildContext context) {
  return Obx(() => Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
          child: Column(
            // shrinkWrap: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height / 25,
              ),

              ///Name...
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommanWidget.getTextFormField(
                      keyboardType: TextInputType.name,
                      labelText: "Full Name",
                      textEditingController: nameTextEditingController,
                      hintText: "Enter Full Name",
                      inputLength: 30,
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.nameEmptyValidation,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.017,
                  ),
                  Expanded(
                    flex: 2,
                    child: CommanWidget.getTextFormField(
                      keyboardType: TextInputType.name,
                      labelText: "Last Name",
                      textEditingController: lastNameTextEditingController,
                      hintText: "Enter Last Name",
                      inputLength: 30,
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.lastNameEmptyValidation,
                    ),
                  ),
                ],
              ),
              DateOfBirthPicker(),
              SizedBox(
                height: Get.height * 0.01,
              ),

              ///Mobile Number...
              CommanWidget.getTextFormField(
                keyboardType: TextInputType.phone,
                labelText: "Mobile No",
                textEditingController: mobileNoTextEditingController,
                inputLength: 10,
                regularExpression: Utility.digitsValidationPattern,
                validationMessage: Utility.mobileNumberInValidValidation,
                validationType: 'mobileno',
                hintText: "Enter Mobile No",
              ),

              ///Email...
              CommanWidget.getTextFormField(
                labelText: "Email Address",
                keyboardType: TextInputType.emailAddress,
                textEditingController: emailTextEditingController,
                validationType: Utility.emailText,
                hintText: "Enter Email Address",
                inputLength: 50,
                regularExpression: Utility.emailAddressValidationPattern,
                validationMessage: Utility.emailEmptyValidation,
              ),

              ///Password ...
              CommanWidget.getTextFormField(
                labelText: "Password (Minimum 8 Characters)",
                textEditingController: passwordTextEditingController,
                inputLength: 8,
                regularExpression: Utility.password,
                validationMessage: "Password is required",
                obscureOnTap: () {
                  validationController.passwordToggle();
                },
                obscureValue: validationController.passwordObscure.value,
                validationType: 'password',
                hintText: "Enter Password",
              ),

              ///Confirm Password ...
              CommanWidget.getTextFormField(
                labelText: "Conform Password (Minimum 8 Characters)",
                textEditingController: conformPasswordTextEditingController,
                inputLength: 8,
                regularExpression: Utility.password,
                validationMessage: "Conform Password is required",
                obscureOnTap: () {
                  validationController.confirmPasswordToggle();
                },
                obscureValue: validationController.confirmPasswordObscure.value,
                validationType: 'password',
                hintText: "Enter Conform Password",
              ),

              ///Terms & Condition

              _termsNCondition(),

              sizedBox(),
            ],
          ),
        ),
      ));
}

sizedBox() {
  return SizedBox(height: Get.width / 14);
}

Widget _termsNCondition() {
  // GetHomePageResponse _res = _getHomePageViewModel.apiResponse.data;
  return Row(
    //  mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: Get.height * 0.05,
        width: Get.width * 0.06,
        child: Checkbox(
          value: validationController.termCondition.value,
          fillColor: MaterialStateProperty.all(
            ColorPicker.navyBlue,
          ),
          onChanged: (value) {
            print("T&C Chnage --> " +
                validationController.termCondition.value.toString());

            validationController.termCondition.value =
                !validationController.termCondition.value;
            // validationController.chnageTC();
          },
          focusColor: ColorPicker.navyBlue,
          checkColor: Colors.white,
          activeColor: ColorPicker.navyBlue,
        ),
      ),
      SizedBox(
        width: Get.width * 0.025,
      ),
      GetBuilder<GetHomePageViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.COMPLETE) {
            GetHomePageResponse response = controller.apiResponse.data;
            return Expanded(
              flex: 2,
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: Get.height * 0.022,
                    color: const Color(0xff797b8b),
                  ),
                  children: [
                    // I agree to the TERMS & CONDITION and PRIVACY POLICY
                    TextSpan(
                      text: 'I agree to the ',
                    ),
                    TextSpan(
                      text: 'TERMS & CONDITION',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('TERMS & CONDITION');
                          Get.to(WebViewScreen(
                            link: response.response[0].appConfig[0]
                                .termsAndConditionsLink,
                          ));

                          // Single tapped.
                        },
                      style: TextStyle(
                        color: ColorPicker.navyBlue,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'PRIVACY POLICY',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('TERMS & CONDITION');
                          Get.to(WebViewScreen(
                            link: response
                                .response[0].appConfig[0].privacyPolicyLink,
                          ));

                          // Single tapped.
                        },
                      style: TextStyle(
                        color: ColorPicker.navyBlue,
                      ),
                    ),
                    TextSpan(
                      text: ' policy.',
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    ],
  );
  //return GetBuilder<GetHomePageViewModel>(
  // builder: (controller) {
  //   if (controller.apiResponse.status == Status.COMPLETE) {
  //     print(
  //         '-=----privacyPolicyLink-------${_res.response[0].appConfig[0].privacyPolicyLink}');
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: Get.height * 0.05,
  //           width: Get.width * 0.06,
  //           child: Checkbox(
  //             value: validationController.termCondition.value,
  //             onChanged: (value) {
  //               print("T&C Chnage --> " +
  //                   validationController.termCondition.value.toString());
  //
  //               validationController.termCondition.value =
  //                   !validationController.termCondition.value;
  //               // validationController.chnageTC();
  //             },
  //             checkColor: Colors.white,
  //             activeColor: ColorPicker.yellow,
  //           ),
  //         ),
  //         SizedBox(
  //           width: Get.width * 0.025,
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: Row(
  //             children: [
  //               Text(
  //                 'I agree to the ',
  //               ),
  //               Text(
  //                 'TERMS & CONDITION',
  //                 style: TextStyle(
  //                   color: ColorPicker.yellow,
  //                 ),
  //               ),
  //               Text(
  //                 ' and ',
  //               ),
  //               Text(
  //                 'PRIVACY POLICY',
  //                 style: TextStyle(
  //                   color: ColorPicker.yellow,
  //                 ),
  //               ),
  //               Text(
  //                 ' policy.',
  //               ),
  //             ],
  //           ),
  //         ),
  //         // Expanded(
  //         //   flex: 2,
  //         //   child: Text.rich(
  //         //     TextSpan(
  //         //       style: TextStyle(
  //         //         fontFamily: 'Roboto',
  //         //         fontSize: Get.height * 0.022,
  //         //         color: const Color(0xff797b8b),
  //         //       ),
  //         //       children: [
  //         //         // I agree to the TERMS & CONDITION and PRIVACY POLICY
  //         //         TextSpan(
  //         //           text: 'I agree to the ',
  //         //         ),
  //         //         TextSpan(
  //         //           text: 'TERMS & CONDITION',
  //         //           style: TextStyle(
  //         //             color: ColorPicker.yellow,
  //         //           ),
  //         //         ),
  //         //         TextSpan(
  //         //           text: ' and ',
  //         //         ),
  //         //         TextSpan(
  //         //           text: 'PRIVACY POLICY',
  //         //           style: TextStyle(
  //         //             color: ColorPicker.yellow,
  //         //           ),
  //         //         ),
  //         //         TextSpan(
  //         //           text: ' policy.',
  //         //         ),
  //         //       ],
  //         //     ),
  //         //     textAlign: TextAlign.left,
  //         //   ),
  //         // ),
  //       ],
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // },
  //);
}

class DateOfBirthPicker extends StatefulWidget {
  @override
  _DateOfBirthPickerState createState() => _DateOfBirthPickerState();
}

class _DateOfBirthPickerState extends State<DateOfBirthPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of Birth",
          style: TextStyle(
              color: ColorPicker.textLabel, fontSize: Get.height * 0.02),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: GetBuilder<RegisterViewModel>(
            builder: (RegisterViewModel controller) {
              return Container(
                height: Get.height * 0.05,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.height * 0.02,
                    vertical: Get.height * 0.009),
                child: Text(
                  "${controller.dob.value != "" ? controller.dob.value : "D-O-B"}",
                  style: TextStyle(
                      fontSize: Get.height * 0.02, color: Colors.black),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: const Color(0xffffffff),
                  border:
                      Border.all(width: 1.0, color: ColorPicker.textFormBorder),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String dob = formatter.format(picked);
      RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
      registerViewModel.setDOB(dob);
    }
  }
}
