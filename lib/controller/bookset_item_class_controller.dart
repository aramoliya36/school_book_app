import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';

class BookItemClassController extends GetxController {
  RxString _selectedTitle = ''.obs;

  RxString get selectedTitle => _selectedTitle;

  void setSelectedTitle(String value) {
    _selectedTitle = value.obs;
    log('category=>$_selectedTitle');
    update();
  }
}
