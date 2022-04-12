import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/textStyle.dart';

Material bottomButton({Function onpress}) {
  return Material(
    child: Ink(
      height: Get.height * 0.05,
      width: Get.width,
      color: ColorPicker.navyBlue,
      child: InkWell(
        onTap: onpress,
        child: Center(
          child: Text(
            'Proceed To Checkout',
            style: CommonTextStyle.buttonText,
          ),
        ),
      ),
    ),
  );
}
