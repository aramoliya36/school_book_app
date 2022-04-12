import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/utility.dart';

TextEditingController mobileNoTextEditingController = TextEditingController();

Widget forgotPasswordForm(BuildContext context) {
  return Material(
    child: Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: Get.height * 0.012),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // shrinkWrap: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(),

            ///Mobile Number...
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                child: Column(
                  children: [
                    CommanWidget.getTextFormField(
                      labelText: "Enter your mobile number",
                      textEditingController: mobileNoTextEditingController,
                      inputLength: 10,
                      regularExpression: Utility.digitsValidationPattern,
                      validationMessage: Utility.mobileNumberInValidValidation,
                      validationType: 'mobileno',
                      hintText: "Enter Mobile No",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget sizedBox() {
  return SizedBox(
    height: Get.height / 30,
  );
}
