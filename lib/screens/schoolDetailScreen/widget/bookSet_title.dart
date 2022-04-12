import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/widget/class_grid.dart';

Widget bookSet() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BookSet",
          style: CommonTextStyle.appNameBlack,
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        ClassGrid()
      ],
    ),
  );
}
