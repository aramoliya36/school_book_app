import 'package:flutter/material.dart';
import 'package:skoolmonk/common/color_picker.dart';

Widget circularProgress() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(ColorPicker.navyBlue),
  ));
}
