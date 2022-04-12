import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDateOfBirth extends GetxController {
  RxString _dob = ''.obs;

  RxString get dob => _dob;

  void setDOB(String value) {
    _dob = value.obs;
    update();
  }
}
