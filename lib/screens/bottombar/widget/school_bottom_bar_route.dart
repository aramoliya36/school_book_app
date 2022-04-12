import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/screens/addCart/addcartscreen.dart';
import 'package:skoolmonk/screens/bookSetItemScreen/bookset_item_classs_screen.dart';
import 'package:skoolmonk/screens/productDetailScreen/product_detail_screen.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/school_detail_screen.dart';
import 'package:skoolmonk/screens/wishlistScreen/wishlist_screen.dart';
import '../../schoolScreen/school_tab.dart';
import '../../subCategoryListScreen/sub_category_list_screen.dart';

BottomController homeController = Get.find();

Widget schoolSubScreen() {
  print('---BOTTOM SCHOOL--${homeController.selectedScreen}');
  switch (homeController.selectedScreen.value) {
    case 'SchoolScreen':
      return SchoolTab();
      break;
    case 'SchoolDetailScreen':
      return SchoolDetailScreen();
      break;
    // case 'SchoolScreen':
    //   return SchoolScreen();
    //   break;
    case 'SubCategoryList':
      return SubCategoryList(
        onPress: () {
          homeController.selectedScreen('SchoolDetailScreen');
        },
        willPopScope: () {
          homeController.selectedScreen('SchoolDetailScreen');

          return Future.value(false);
        },
      );
      break;
    case 'BookItemClassScreen':
      return BookItemClassScreen();
      break;
    case 'AddCartScreen':
      return AddCartScreen();
      break;
    case 'WishListScreen':
      return WishListScreen();
      break;
    case 'ProductDetailScreen':
      return ProductDetailScreen(
        onPress: () {
          homeController.selectedScreen('SubCategoryList');
        },
        willPopScope: () {
          homeController.selectedScreen('SubCategoryList');
          return Future.value(false);
        },
      );
      break;

    default:
      return SchoolTab();
  }
}
