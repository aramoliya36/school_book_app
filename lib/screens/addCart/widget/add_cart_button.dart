import 'package:flutter/material.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/textStyle.dart';

Widget addCartButton({String title, Function onPress}) {
  return Material(
    child: Ink(
      decoration: BoxDecoration(
          color: ColorPicker.navyBlue, borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: CommonTextStyle.buttonText,
          ),
        ),
      ),
    ),
  );
}
