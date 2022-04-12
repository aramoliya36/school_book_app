import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static void showSnackBar({String msg, bool successStatus = false}) {
    Get.showSnackbar(GetBar(
      message: msg,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: successStatus ? Colors.green : Colors.red,
    ));
  }
}
