import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/textStyle.dart';

Padding wishListTopHeaderText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       '1 Items in cart',
        //       style: TextStyle(
        //           fontSize: Get.height * 0.018, fontWeight: FontWeight.w700),
        //     ),
        //     Text('Total savings ₹16.00', style: CommonTextStyle.redText)
        //   ],
        // ),
        // Text(
        //   'Total price ₹87.00',
        //   style: CommonTextStyle.price,
        // )
      ],
    ),
  );
}
