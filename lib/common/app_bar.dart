import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/auth_viewmodel.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/cart_count_controller.dart';
import 'package:skoolmonk/controller/colorChange_Controller.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/screens/bottombar/widget/category_bottom_bar_route.dart';
import 'package:skoolmonk/screens/searchScreen/search_screen.dart';

import '../screens/addCart/addcartscreen.dart';
import '../screens/bottombar/widget/category_bottom_bar_route.dart';
import 'iconWidget.dart';
import 'shared_preference.dart';

ColorController colorController = Get.find();
AuthController authController = Get.find();

class CommonAppBar {
  static Widget commonAppBar({
    IconData leadingIcon,
    String appTitle,
    Function onPress,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorPicker.navyBlue,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          toolbarHeight: Get.height * 0.06,
          backgroundColor: ColorPicker.navyBlue,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: onPress,
              child: Icon(
                leadingIcon,
                color: Colors.white,
                size: Get.height * 0.04,
              ),
            ),
          ),
          title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GetBuilder<BottomController>(
                builder: (controllerBottom) {
                  return GetBuilder<ColorController>(
                    builder: (ColorController controller) {
                      return Row(
                        children: [
                          Container(
                            width: Get.width * 0.37,
                            child: Text(
                              " ${appTitle ?? ""}",
                              style: CommonTextStyle.appName,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          (controllerBottom.bottomIndex == 1 &&
                                      controllerBottom.selectedScreen ==
                                          'HomeScreen' ||
                                  controllerBottom.selectedScreen ==
                                      'CategoryScreen')
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    if (controller.colorChange.value != 10) {
                                      Get.back();
                                    }
                                    colorController.colorChange.value = 0;
                                    Get.to(SearchScreen());
                                  },
                                  child: colorController.colorChange.value == 0
                                      ? IconWidget.yellowSearch
                                      : IconWidget.search),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Badge(
                            toAnimate: false,
                            badgeColor: ColorPicker.redColorApp,
                            ignorePointer: true,
                            badgeContent: Container(
                                height: Get.height / 70,
                                width: Get.width / 70,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPicker.redColorApp),
                                child: GetBuilder<AuthController>(
                                  builder: (controller) {
                                    log("VALUE ${controller.isLogin.value}");
                                    return PreferenceManager.getTokenId() !=
                                                null &&
                                            PreferenceManager.getTokenId() != ''
                                        ? GetBuilder<
                                            CartAndWishCountController>(
                                            builder: (cartCountController) {
                                              return CircleAvatar(
                                                backgroundColor:
                                                    ColorPicker.redColorApp,
                                                maxRadius: 7,
                                                child: Text(
                                                  '${cartCountController.wishListCount ?? "0"}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Get.width / 40),
                                                ),
                                              );
                                            },
                                          )
                                        : controller.isLogin.value == true
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    ColorPicker.redColorApp,
                                                maxRadius: 7,
                                                child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Get.width / 40),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    ColorPicker.redColorApp,
                                                maxRadius: 7,
                                                child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Get.width / 40),
                                                ),
                                              );
                                  },
                                )),
                            position: BadgePosition.topEnd(top: -6, end: -5),
                            child: InkWell(
                                onTap: () {
                                  print(
                                      'Color INDEX :${controller.colorChange.value}');
                                  if (controller.colorChange.value != 10) {
                                    Get.back();
                                  }
                                  var _currentUserId =
                                      PreferenceManager.getTokenId();
                                  if (_currentUserId == null) {
                                    return Get.to(SignInScreen());
                                  } else {
                                    colorController.colorChange.value = 1;
                                    homeController
                                        .selectedScreen('WishListScreen');
                                  }
                                },
                                child: colorController.colorChange.value == 1
                                    ? IconWidget.yellowFavourite
                                    : IconWidget.favourite),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          (controllerBottom.bottomIndex == 1 &&
                                      controllerBottom.selectedScreen ==
                                          'HomeScreen' ||
                                  controllerBottom.selectedScreen ==
                                      'CategoryScreen')
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    // if (controller.colorChange.value != 5) {
                                    //   Get.back();
                                    // }
                                    // colorController.colorChange.value = 2;
                                  },
                                  child: colorController.colorChange.value == 2
                                      ? IconWidget.yellowbell
                                      : IconWidget.bell),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Badge(
                            ignorePointer: true,
                            toAnimate: false,
                            badgeColor: ColorPicker.redColorApp,
                            badgeContent: Container(
                              height: Get.height / 70,
                              width: Get.width / 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPicker.redColorApp),
                              child: GetBuilder<AuthController>(
                                builder: (controller) {
                                  log("VALUE ${controller.isLogin.value}");
                                  return PreferenceManager.getTokenId() !=
                                              null &&
                                          PreferenceManager.getTokenId() != ''
                                      ? GetBuilder<CartAndWishCountController>(
                                          builder: (cartCountController) {
                                            return Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${cartCountController.cartCount ?? "0"}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Get.width / 40),
                                              ),
                                            );
                                          },
                                        )
                                      : controller.isLogin.value == true
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Get.width / 40),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  ColorPicker.redColorApp,
                                              maxRadius: 7,
                                              child: Text(
                                                '0',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Get.width / 40),
                                              ),
                                            );
                                },
                              ),
                            ),
                            position: BadgePosition.topEnd(top: -6, end: -5),
                            child: InkWell(
                                onTap: () {
                                  if (controller.colorChange.value != 10) {
                                    homeController
                                        .selectedScreen('AddCartScreen');
                                  }
                                  colorController.colorChange.value = 3;
                                  var _currentUserId =
                                      PreferenceManager.getTokenId();
                                  if (_currentUserId == null) {
                                    return Get.to(SignInScreen());
                                  } else {
                                    //Get.to(AddCartScreen());

                                    homeController
                                        .selectedScreen('AddCartScreen');
                                    // homeController.bottomIndex(0);
                                    Get.back();

                                    // Get.to(() => AddCartScreen());
                                  }
                                },
                                child: colorController.colorChange.value == 3
                                    ? IconWidget.yellowshoppingCart
                                    : IconWidget.shoppingcart),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                    },
                  );
                },
              ))),
    );
  }

  static AppBar authAppBar({String title, Function onPress}) {
    return AppBar(
      toolbarHeight: Get.height * 0.06,
      backgroundColor: ColorPicker.navyBlue,
      leading: GestureDetector(
          onTap: onPress,
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          )),
      title: Text(
        title,
        style: CommonTextStyle.appName,
      ),
    );
  }
}
