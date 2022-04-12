import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/iconWidget.dart';

Row viewAllText() {
  return Row(
    children: [
      Spacer(),
      Text(
        'View All',
        style: TextStyle(
          fontFamily: 'Helvetica Neue',
          fontSize: Get.height * 0.018,
          color: const Color(0xff000000),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        width: Get.width * 0.01,
      ),
      IconWidget.viewAll
    ],
  );
}
