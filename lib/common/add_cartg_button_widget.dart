import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_picker.dart';

class AddToCartWidget {
  addToCartNormal({Function onTap}) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      child: Ink(
        height: Get.height * 0.04,
        width: Get.width * 0.19,
        decoration: BoxDecoration(
            color: ColorPicker.navyBlue,
            borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.shopping_cart,
                size: Get.height * 0.03,
                color: Colors.white,
              ),
              Text(
                "ADD",
                style:
                    TextStyle(fontSize: Get.height * 0.02, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
