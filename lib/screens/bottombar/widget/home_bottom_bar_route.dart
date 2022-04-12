import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/screens/addCart/addcartscreen.dart';
import 'package:skoolmonk/screens/homeScreen/home_screen.dart';
import 'package:skoolmonk/screens/productDetailScreen/product_detail_screen.dart';
import 'package:skoolmonk/screens/wishlistScreen/wishlist_screen.dart';

import '../../subCategoryListScreen/sub_category_list_screen.dart';

BottomController homeController = Get.find();

Widget homeSubScreen() {
  switch (homeController.selectedScreen.value) {

    /* case 'SubcategoryScreen':
        return SubcategoryScreen();
        break;
      case 'CategoryScreen':
        return CategoryScreen();
        break;
      case 'SubCategoryList':
        return SubCategoryList();
        break;*/
    case 'ProductDetailScreen':
      return ProductDetailScreen(
        onPress: () {
          colorController.colorChange.value = 10;
          homeController.selectedScreen('HomeScreen');
        },
        willPopScope: () {
          colorController.colorChange.value = 10;

          homeController.selectedScreen('HomeScreen');
          return Future.value(false);
        },
      );
      break;
    case 'HomeScreen':
      return HomeScreen();
      break;
    case 'AddCartScreen':
      return AddCartScreen();
      break;
    case 'SubCategoryList':
      return SubCategoryList();
      break;
    case 'WishListScreen':
      return WishListScreen();
      break;

    default:
      return HomeScreen();
  }
}
