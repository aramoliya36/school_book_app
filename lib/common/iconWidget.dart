import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';

class IconWidget {
  static SvgPicture search = SvgPicture.asset(
    "assets/svg/search.svg",
    height: Get.height * 0.025,
    color: Colors.white,
  );
  static SvgPicture yellowSearch = SvgPicture.asset("assets/svg/search.svg",
      color: Colors.white, height: Get.height * 0.025);
  static SvgPicture favourite = SvgPicture.asset(
    "assets/svg/fav.svg",
    height: Get.height * 0.025,
    color: Colors.white,
  );
  static SvgPicture yellowFavourite = SvgPicture.asset("assets/svg/fav.svg",
      color: Colors.white, height: Get.height * 0.025);
  static SvgPicture bell = SvgPicture.asset(
    "assets/svg/bell.svg",
    height: Get.height * 0.025,
    color: Colors.white,
  );
  static SvgPicture yellowbell = SvgPicture.asset("assets/svg/bell.svg",
      color: Colors.white, height: Get.height * 0.025);
  static SvgPicture shoppingcart = SvgPicture.asset(
    "assets/svg/shopping-cart.svg",
    height: Get.height * 0.025,
    color: Colors.white,
  );

  static SvgPicture yellowshoppingCart = SvgPicture.asset(
      "assets/svg/shopping-cart.svg",
      color: Colors.white,
      height: Get.height * 0.025);

  static SvgPicture viewAll =
      SvgPicture.asset("assets/icons/expand.svg", height: Get.height * 0.015);
  static SvgPicture expand =
      SvgPicture.asset("assets/icons/expand.svg", height: Get.height * 0.02);

  static SvgPicture order =
      SvgPicture.asset("assets/svg/order.svg", height: Get.height * 0.024);
  static SvgPicture wishList =
      SvgPicture.asset("assets/svg/fav.svg", height: Get.height * 0.024);
  static SvgPicture category =
      SvgPicture.asset("assets/svg/category.svg", height: Get.height * 0.024);
  static SvgPicture school =
      SvgPicture.asset("assets/svg/school.svg", height: Get.height * 0.024);
  static SvgPicture changePassword =
      SvgPicture.asset("assets/svg/password.svg", height: Get.height * 0.024);
  static SvgPicture feedback =
      SvgPicture.asset("assets/svg/feedback.svg", height: Get.height * 0.024);
  static SvgPicture share =
      SvgPicture.asset("assets/svg/share.svg", height: Get.height * 0.024);
  static SvgPicture termsAndCondition = SvgPicture.asset(
      "assets/svg/terms-and-conditions.svg",
      height: Get.height * 0.024);
  static SvgPicture privacyPolicy = SvgPicture.asset(
      "assets/svg/privacy-policy.svg",
      height: Get.height * 0.024);
  static SvgPicture logout =
      SvgPicture.asset("assets/svg/logout.svg", height: Get.height * 0.024);
  static SvgPicture filter = SvgPicture.asset(
    "assets/svg/filter.svg",
    height: Get.height * 0.03,
    color: Colors.white,
  );
}
