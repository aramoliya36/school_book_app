import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/whish_list_count_methode.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/cart_count_controller.dart';
import 'package:skoolmonk/screens/bottombar/widget/category_bottom_bar_route.dart';
import 'package:skoolmonk/screens/bottombar/widget/home_bottom_bar_route.dart';
import 'package:skoolmonk/screens/bottombar/widget/school_bottom_bar_route.dart';
import 'package:skoolmonk/screens/bottombar/widget/user_bottom_bar_route.dart';
import 'package:skoolmonk/screens/homescreen/home_screen.dart';
import 'package:skoolmonk/screens/schoolScreen/school_screen.dart';
import 'package:skoolmonk/screens/user/update_user_profile.dart';
import 'package:skoolmonk/viewModel/cart_repo_view_model.dart';

import '../../common/cart_count_method.dart';
import '../../common/shared_preference.dart';
import '../../common/shared_preference.dart';
import '../../common/shared_preference.dart';
import '../../model/responseModel/cart_response_model.dart';
import '../schoolScreen/school_tab.dart';
import '../categoryScreen/category_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _pageIndex = 0;
  BottomController homeController = Get.find();
  List<Widget> tabPages = [
    HomeScreen(),
    CategoryScreen(),
    // SchoolScreen(),
    SchoolTab(),
    UserUpdateProfileScreen()
  ];
  List<Map<String, String>> bottomBarData = [
    {
      "title": "Home",
      "Icon": "assets/svg/home_tab_icon.svg",
    },
    {
      "title": "Category",
      "Icon": "assets/svg/category_tab_icon.svg",
    },
    {
      "title": "School",
      "Icon": "assets/svg/school_icon_ytab.svg",
    },
    {
      "title": "User",
      "Icon": "assets/svg/user_tab_icon.svg",
    },
  ];
  CartAndWishCountController _cartCountController = Get.find();

  @override
  void initState() {
    String userId = PreferenceManager.getTokenId();
    print('USERID PREFERENCEMANAGER$userId');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorPicker.navyBlue,
      statusBarIconBrightness: Brightness.light,
    ));
    homeController.bottomIndex.value = 0;

    if (userId != null) {
      countSetCart();
      countSetWishCart();
    } else {
      print('USER NOT LOGIN');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        body: homeController.selectedScreen.value != ''
            ? homeController.bottomIndex.value == 0
                ? homeSubScreen()
                : homeController.bottomIndex.value == 1
                    ? categorySubScreen()
                    : homeController.bottomIndex.value == 2
                        ? schoolSubScreen()
                        : userSubScreen()
            : tabPages[homeController.bottomIndex.value],
      );
    });
  }

  Widget bottomNavigationBar() {
    return homeController.selectedScreen.value == 'AddCartScreen'
        ? SizedBox()
        : Container(
            height: Get.height * 0.07,
            width: Get.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomBarData
                  .map((e) => InkResponse(
                        onTap: () {
                          onTabTapped(bottomBarData.indexOf(e));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: SvgPicture.asset(
                                e["Icon"],
                                color: homeController.bottomIndex.value ==
                                        bottomBarData.indexOf(e)
                                    ? ColorPicker.navyBlue
                                    : Colors.grey,
                              )),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                e["title"],
                                style: TextStyle(
                                    color: homeController.bottomIndex.value ==
                                            bottomBarData.indexOf(e)
                                        ? ColorPicker.navyBlue
                                        : Colors.grey,
                                    fontSize: Get.height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  void onTabTapped(int index) {
    homeController.bottomIndex.value = index;
    var milna = index;
    if (index == 0) {
      homeController.selectedScreen('HomeScreen');
    }
    if (index == 1) {
      homeController.selectedScreen('HomeScreen');
    }
    if (index == 2) {
      homeController.selectedScreen('SchoolScreen');
    }
    if (index == 3) {
      homeController.selectedScreen('UserUpdateProfileScreen');
    }
  }
}
