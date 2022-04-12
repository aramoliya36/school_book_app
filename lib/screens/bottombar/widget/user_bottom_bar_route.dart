import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/screens/addCart/addcartscreen.dart';
import 'package:skoolmonk/screens/user/update_user_profile.dart';
import 'package:skoolmonk/screens/wishlistScreen/wishlist_screen.dart';

BottomController homeController = Get.find();

Widget userSubScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserUpdateProfileScreen':
      return UserUpdateProfileScreen();
      break;
    case 'AddCartScreen':
      return AddCartScreen();
      break;
    case 'WishListScreen':
      return WishListScreen();
      break;
    default:
      return UserUpdateProfileScreen();
  }
}
