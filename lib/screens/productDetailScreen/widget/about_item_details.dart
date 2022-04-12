import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/model/responseModel/product_detail_response_model.dart';

Column aboutItemDetail(ProductDetailResponse response) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('About this item', style: CommonTextStyle.aboutThisItemTextStyle),
      SizedBox(
        height: Get.height * 0.02,
      ),
      Html(
        data: """${response.response[0].productDescription}""",
        defaultTextStyle: TextStyle(
          fontFamily: 'Helvetica Neue',
          fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}
