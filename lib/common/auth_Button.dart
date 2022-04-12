import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';

Widget authBottomButton({title, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        alignment: Alignment.center,
        width: Get.width,
        height: Get.height / 20,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(13.0),
          color: ColorPicker.navyBlue,
          /*    boxShadow: [
              BoxShadow(
                color: const Color(0x6117a2b8),
                offset: Offset(0, 10),
                blurRadius: 40,
              ),
            ],*/
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: Get.height * 0.023),
          textAlign: TextAlign.left,
        )),
  );
}
