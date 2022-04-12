import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';

import 'color_picker.dart';

class CommonTextStyle {
  static TextStyle appName = TextStyle(
    fontFamily: 'Krungthep',
    fontSize: Get.height * 0.025,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle appNameBlack = TextStyle(
    fontFamily: 'Krungthep',
    fontSize: Get.height * 0.025,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle bookName = TextStyle(
    fontFamily: 'Krungthep',
    fontSize: Get.height * 0.025,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle categoryTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.018,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle classTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.024,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle subClassTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.016,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle priceTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.017,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle price = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: ColorPicker.navyBlue,
    fontWeight: FontWeight.w500,
  );

  static TextStyle MRPTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.016,
    color: Colors.black.withOpacity(.6),
    fontWeight: FontWeight.w300,
  );
  static TextStyle MRP = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );
  static TextStyle cancelPrice = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.width * 0.028,
    color: Colors.black.withOpacity(.6),
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
  );
  static TextStyle cancelPriceTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: Colors.black,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.lineThrough,
  );
  static TextStyle taxIncludeStyle = TextStyle(
      color: Colors.black.withOpacity(.7), fontSize: Get.height * 0.011);
  static TextStyle aboutThisItemTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.016,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle cartItemSmallTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.015,
    color: const Color(0xff8e8e8e),
    fontWeight: FontWeight.w500,
  );
  static TextStyle taxInclude =
      TextStyle(color: Colors.black, fontSize: Get.height * 0.015);

  static TextStyle aboutTextTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.014,
    color: const Color(0xff8e8e8e),
    fontWeight: FontWeight.w300,
  );
  static TextStyle productTitle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.width * 0.03,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle redText = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.018,
    color: const Color(0xffc60300),
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttonText = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.018,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle drawerTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle filterTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: Get.height * 0.022);
  static TextStyle availableProductStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.016,
    color: const Color(0xff8e8e8e),
    fontWeight: FontWeight.w500,
  );
  static TextStyle searchTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.022,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle schoolDetailTextStyle = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w400,
  );
  static TextStyle register = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.022,
    color: ColorPicker.navyBlue,
    fontWeight: FontWeight.w700,
  );
  static TextStyle orText = TextStyle(
    fontFamily: 'Helvetica Neue',
    fontSize: Get.height * 0.02,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w300,
  );

  static TextStyle title =
      TextStyle(fontSize: Get.height * 0.023, fontWeight: FontWeight.w700);
  static TextStyle orderName =
      TextStyle(fontSize: Get.height * 0.021, fontWeight: FontWeight.w500);
  static TextStyle orderDate =
      TextStyle(fontSize: Get.height * 0.02, fontWeight: FontWeight.w300);
}
