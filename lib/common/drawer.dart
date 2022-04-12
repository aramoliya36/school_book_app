import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/iconWidget.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/auth_viewmodel.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/screens/bottombar/widget/category_bottom_bar_route.dart';
import 'package:skoolmonk/screens/foegotpasswordScreen/forgot_password_screen.dart';
import 'package:skoolmonk/screens/myAddresses/my_addresses_screen.dart';
import 'package:skoolmonk/screens/orederHistory/order_history.dart';
import 'package:skoolmonk/screens/splash_screen.dart';
import 'package:skoolmonk/screens/submitFeedBack/submit_feedback.dart';
import 'package:skoolmonk/screens/webViewScreen/web_view_screen.dart';
import 'package:skoolmonk/screens/wishlistScreen/wishlist_screen.dart';

import '../controller/colorChange_Controller.dart';
import 'app_bar.dart';
import 'utility.dart';

class DrawerClassApp extends StatefulWidget {
  @override
  _DrawerClassAppState createState() => _DrawerClassAppState();
}

class _DrawerClassAppState extends State<DrawerClassApp> {
  ColorController colorController = Get.find();

  String isLogin = PreferenceManager.getTokenId();

  var drawerList = [];

  BottomController homeController = Get.find();
  AuthController authController = Get.find();

  @override
  void initState() {
    // TODO: implement initState

    drawerList = [
      {
        "icon": Icon(Icons.shopping_bag),
        "name": "My Orders",
      },
      {"icon": Icon(Icons.bookmark), "name": "Wishlist"},
      {"icon": Icon(Icons.location_on), "name": "My Addresses"},
      {"icon": Icon(Icons.grid_view), "name": "Shop By Category"},
      {"icon": Icon(Icons.school), "name": "Shop By School"},
      {"icon": Icon(Icons.lock), "name": "Change Password"},
      {"icon": Icon(Icons.feedback), "name": "Submit FeedBack"},
      {"icon": Icon(Icons.share), "name": "Share"},
      (Utility.termsConditionsLink == "")
          ? {'icon': SizedBox(), 'name': 'non'}
          : {
              "icon": Icon(Icons.check_box_sharp),
              "name": "Terms and Conditions"
            },
      (Utility.privacyPolicyLink == "")
          ? {'icon': SizedBox(), 'name': 'non'}
          : {"icon": Icon(Icons.privacy_tip), "name": "Privacy Policy"},
      (Utility.refundPolicyLink == "")
          ? {'icon': SizedBox(), 'name': 'non'}
          : {"icon": Icon(Icons.credit_card), "name": "Refund Policy"},
      (Utility.faqLink == "")
          ? {'icon': SizedBox(), 'name': 'non'}
          : {"icon": Icon(Icons.question_answer), "name": "Faq"},
      (Utility.helpLink == "")
          ? {'icon': SizedBox(), 'name': 'non'}
          : {"icon": Icon(Icons.help), "name": "Help"},
      (PreferenceManager.getTokenId() == null ||
              PreferenceManager.getTokenId() == '')
          ? {"icon": Icon(Icons.logout), "name": "LogIn"}
          : {"icon": Icon(Icons.logout), "name": "Logout"},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('--------------------fname--${PreferenceManager.getFnameId()}');
    String x;
    log("DATE ${drawerList.length}");
    return Container(
      height: Get.height,
      width: Get.width * 0.7,
      color: ColorPicker.navyBlue,
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: Get.height * 0.05,
              width: Get.width,
              color: ColorPicker.navyBlue,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.014),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 13,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Hi, ${PreferenceManager.getFnameId() ?? ' Guest'}",
                        style: CommonTextStyle.appNameBlack)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      buttonOnTap(drawerList[index]["name"], context);
                    },
                    child: drawerList[index]["name"] == 'non'
                        ? SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.01,
                                    horizontal: Get.height * 0.013),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Center(
                                        child: drawerList[index]["icon"],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      drawerList[index]["name"],
                                      style: CommonTextStyle.drawerTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 13,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              )
                            ],
                          ),
                  );
                },
                itemCount: drawerList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void buttonOnTap(String title, BuildContext context) async {
  Get.back();
  switch (title) {
    case 'My Orders':
      if (PreferenceManager.getTokenId() != null) {
        Get.to(OrderHistory());
      } else {
        Get.to(SignInScreen());
      }
      break;
    case 'Wishlist':
      colorController.colorChange.value = 1;
      Get.to(WishListScreen());
      break;
    case 'Shop By Category':
      homeController.bottomIndex.value = 1;
      homeController.setSelectedScreen('CategoryScreen');

      break;
    case 'Shop By School':
      homeController.bottomIndex.value = 2;
      homeController.setSelectedScreen('SchoolScreen');
      break;
    case 'Change Password':
      Get.to(ForgotPasswordScreen());
      break;
    case 'Logout':
      print('------id--before-------${PreferenceManager.getTokenId()}');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: MaterialButton(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Get.back();
                          await PreferenceManager.setTokenId('');
                          authController.isLogin.value = false;
                          PreferenceManager.allClearPreferenceManager();

                          print(
                              '------id--logout-------${PreferenceManager.getTokenId()}');
                          // homeController.selectedScreen.value = 'HomeScreen';
                          Get.to(SplashScreen());
                        },
                        color: ColorPicker.navyBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          // homeController.selectedScreen('HomeScreen');
                          // homeController.bottomIndex.value = 0;
                          Get.back();
                        },
                        color: ColorPicker.redColorApp,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            );
          });

      break;
    case 'LogIn':
      print('------login---------${PreferenceManager.getTokenId()}');

      Get.to(SignInScreen());
      break;
    case 'My Addresses':
      print('------My Addresses---------${PreferenceManager.getTokenId()}');

      Get.to(MyAddressScreen());
      break;
    case 'Terms and Conditions':
      Get.to(WebViewScreen(
        link: Utility.termsConditionsLink,
      ));
      break;
    case 'Privacy Policy':
      Get.to(WebViewScreen(
        link: Utility.privacyPolicyLink,
      ));
      break;
    case 'Submit FeedBack':
      if (PreferenceManager.getTokenId() != null) {
        Get.to(SubmitFeedBackScreen());
      } else {
        Get.to(SignInScreen());
      }
      break;
    case "Refund Policy":
      Get.to(WebViewScreen(
        link: Utility.refundPolicyLink,
      ));
      break;
    case 'Faq':
      Get.to(WebViewScreen(
        link: Utility.faqLink,
      ));
      break;
    case 'Help':
      Get.to(WebViewScreen(
        link: Utility.helpLink,
      ));
      break;
  }
}
