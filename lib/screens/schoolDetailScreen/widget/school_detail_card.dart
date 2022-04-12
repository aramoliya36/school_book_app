import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/single_school_response.dart';
import 'package:skoolmonk/viewModel/single_school_viewmodel.dart';

import '../../../common/circularprogress_indicator.dart';

SingleSchoolViewModelController schoolViewModelController = Get.find();
Widget schoolDetailCard() {
  return GetBuilder<SingleSchoolViewModelController>(
    builder: (controller) {
      if (controller.apiResponse.status == Status.COMPLETE) {
        SingleSchoolResponse response = controller.apiResponse.data;

        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          elevation: 7,
          child: Container(
            height: Get.height * 0.35,
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            response.response[0].school[0].schoolBanners[0]
                                .schoolImg
                                .trim(),
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        response.response[0].school[0].schoolName,
                        style: CommonTextStyle.appNameBlack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        "${"${response.response[0].school[0].address}" ?? ''},${response.response[0].school[0].city ?? ''},${response.response[0].school[0].pincode ?? ''},${response.response[0].school[0].state ?? ''},${response.response[0].school[0].countries ?? ''}",
                        style: TextStyle(fontSize: Get.height * 0.02),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Center(child: circularProgress());
      }
    },
  );
}
