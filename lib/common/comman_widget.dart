import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/validation_controller.dart';

import 'color_picker.dart';

class CommanWidget {
  static ValidationController validationController =
      Get.put(ValidationController());
  static InputBorder outLineGrey = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: ColorPicker.textFormBorder, width: 1.0),
  );
  static InputBorder outLineRed = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  );

  static Widget getTextFormField(
      {String labelText,
      TextInputType keyboardType,
      TextEditingController textEditingController,
      bool isValidate,
      bool isEnable,
      String validationType,
      String regularExpression,
      int inputLength,
      String hintText,
      String validationMessage,
      String iconPath,
      int maxLine,
      Function obscureOnTap,
      IconData icon,
      bool obscureValue,
      Function onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
              color: ColorPicker.textLabel, fontSize: Get.height * 0.02),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Container(
          // height: 40,
          // color: Colors.lightGreen,
          child: Stack(
            children: [
              TextFormField(
                keyboardType: keyboardType,
                maxLines: maxLine == null ? 1 : maxLine,
                controller: textEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(inputLength),
                  FilteringTextInputFormatter.allow(RegExp(regularExpression))
                ],
                enableInteractiveSelection: false,
                enabled: isEnable != null ? isEnable : true,
                validator: (value) {
                  print("isValidate  $isValidate}");
                  return isValidate == false
                      ? null
                      : value.isEmpty
                          ? validationMessage
                          : validationType == "email"
                              ? Utility.validateUserName(value)
                              : validationType == "password"
                                  ? Utility.validatePassword(value)
                                  : validationType == "mobileno"
                                      ? value.length != 10
                                          ? Utility
                                              .mobileNumberInValidValidation
                                          : null
                                      : null;
                },
                style: TextStyle(
                    color: isEnable != null ? Color(0xff707070) : Colors.black,
                    fontSize: Get.height * 0.02),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: outLineGrey,
                  enabledBorder: outLineGrey,
                  disabledBorder: outLineGrey,
                  isDense: true,
                  isCollapsed: true,
                  suffix: GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      icon,
                      size: Get.height * 0.02,
                      color: ColorPicker.navyBlue,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                      top: Get.height * 0.013,
                      bottom: Get.height * 0.013,
                      left: Get.height * 0.019,
                      right: Get.height * 0.019),
                  errorBorder: outLineRed,
                  focusedErrorBorder: outLineRed,
                  hintText: hintText,
                ),
                obscureText:
                    validationType == 'password' ? obscureValue : false,
              ),
              validationType == 'password'
                  ? Positioned(
                      right: Get.height * 0.013,
                      top: Get.height * 0.01,
                      child: InkWell(
                        onTap: obscureOnTap,
                        child: Icon(
                          !validationController.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorPicker.navyBlue,
                          size: Get.height * 0.025,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.012,
        ),
      ],
    );
  }

  static void snackBar({String title, String message, SnackPosition position}) {
    Get.showSnackbar(GetBar(
      messageText: Text("$message"),
      title: title,
      duration: Duration(seconds: 2),
      snackPosition: position,
    ));
  }
}
