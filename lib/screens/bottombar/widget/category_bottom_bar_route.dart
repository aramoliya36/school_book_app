import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/screens/addCart/addcartscreen.dart';
import 'package:skoolmonk/screens/categoryScreen/category_screen.dart';
import 'package:skoolmonk/screens/productDetailScreen/product_detail_screen.dart';
import 'package:skoolmonk/screens/subCategoryListScreen/sub_category_list_screen.dart';
import 'package:skoolmonk/screens/subCategoryScreen/sub_category_screen.dart';
import 'package:skoolmonk/screens/wishlistScreen/wishlist_screen.dart';

BottomController homeController = Get.find();

Widget categorySubScreen() {
  print("..>>>>>>${homeController.selectedScreen.value}");
  switch (homeController.selectedScreen.value) {
    case 'CategoryScreen':
      return CategoryScreen();
      break;
    case 'SubcategoryScreen':
      return SubcategoryScreen();
      break;
    case 'WishListScreen':
      return WishListScreen();
      break;
    case 'AddCartScreen':
      return AddCartScreen();
      break;

    case 'SubCategoryList':
      return SubCategoryList(
        onPress: () {
          homeController.selectedScreen('SubcategoryScreen');
        },
        willPopScope: () {
          homeController.selectedScreen('SubcategoryScreen');
          return Future.value(false);
        },
      );
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
      return CategoryScreen();
  }
}
