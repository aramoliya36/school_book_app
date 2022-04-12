import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'color_picker.dart';

Widget commonImage({double heightImage, double widthImage}) {
  return SvgPicture.asset(
    'assets/svg/grey_logo.svg',
    color: Colors.grey.withOpacity(.5),
    fit: BoxFit.contain,
    height: heightImage,
    width: heightImage,
  );
}

Widget homePageCommon({double heightImage, double widthImage}) {
  return ClipRRect(
    child: Container(
        height: Get.height * 0.1,
        width: Get.width * 0.16,
        decoration:
            BoxDecoration(color: ColorPicker.navyBlue, shape: BoxShape.circle),
        child: Icon(
          Icons.school,
          color: Colors.white,
        )),
  );
}
