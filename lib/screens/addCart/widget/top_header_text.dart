import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/model/responseModel/cart_response_model.dart';

Padding cartListTopHeaderText({CartResponse response}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            response.response.isEmpty
                ? SizedBox()
                : Text(
                    '${response.count ?? ''} Items in cart',
                    style: TextStyle(
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w700),
                  ),
          ],
        ),
        response.response.isEmpty
            ? SizedBox()
            : Text(
                'Total price ₹${response.response[0].cartInfo[0].finalTotalPrice ?? ''}',
                style: CommonTextStyle.price,
              )
      ],
    ),
  );
}
