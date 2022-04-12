import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget filterButton(
    {String title, Color textColor, Color buttonColor, Function onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      height: Get.height * 0.05,
      width: Get.width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: buttonColor,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 3))
          ]),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: Get.height * 0.018,
              fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
