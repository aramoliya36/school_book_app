import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImageWidget {
  String imgPath = "assets/images";
  static SvgPicture appLogo = SvgPicture.asset(
    "assets/svg/app_logo_white_line.svg",
    height: Get.height * 0.14,
    width: Get.width * 0.14,
  );
}
