import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/circularprogress_indicator.dart';
import '../../common/servor_error_text.dart';
import '../../common/textStyle.dart';
import '../../model/apis/api_response.dart';
import '../../model/responseModel/get_homepage_response_model.dart';
import '../../viewModel/get_homepage_viewmodel.dart';
import '../bottombar/navigation_bar.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  PageController _pageContoller = PageController(initialPage: 0);
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetHomePageViewModel>(
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
          var data = response.response[0].appScreen;
          return Scaffold(
            bottomNavigationBar: ButtonBar(
              children: [
                MaterialButton(
                  onPressed: () {
                    print(data.length);
                    if (currentPage >= 0) {
                      currentPage++;
                      if (data.length == currentPage) {
                        setState(() {
                          currentPage = 0;

                          Get.offAll(NavigationBarScreen());
                        });
                      }
                    }
                    print("Next-------$currentPage");
                    _pageContoller.jumpToPage(currentPage);
                  },
                  child: Text('Next'),
                ),
              ],
            ),
            body: SafeArea(
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: PageView.builder(
                    itemCount: data.length,
                    onPageChanged: (value) {
                      currentPage = value;
                    },
                    controller: _pageContoller,
                    itemBuilder: (context, index) => Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage('${data[index].img.trim()}'))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "${data[index].message ?? ''}",
                            style: CommonTextStyle.classTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
