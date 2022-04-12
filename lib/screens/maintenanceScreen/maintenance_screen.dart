import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/circularprogress_indicator.dart';
import '../../common/servor_error_text.dart';
import '../../model/apis/api_response.dart';
import '../../model/responseModel/get_homepage_response_model.dart';
import '../../viewModel/get_homepage_viewmodel.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: GetBuilder<GetHomePageViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return circularProgress();
            }
            if (controller.apiResponse.status == Status.ERROR) {
              return Material(
                  color: Colors.white, child: Center(child: serverErrorText()));
            }
            if (controller.apiResponse.status == Status.COMPLETE) {
              GetHomePageResponse response = controller.apiResponse.data;
              var imgResp = response.response[0].maintenanceScreen[0];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      height: Get.height * 0.3,
                      width: Get.width,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      //   color: Color(0xFFA52F53),
                      // ),
                      child: imgResp.img == '' || imgResp.img.isEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/Mobile-App-Maintenance.jpeg',
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(imgResp.img.trim())),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        imgResp.message ?? '',
                        style: TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
