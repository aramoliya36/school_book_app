import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';
import 'package:skoolmonk/viewModel/get_homepage_viewmodel.dart';

class homePageBanner extends StatefulWidget {
  @override
  _homePageBannerState createState() => _homePageBannerState();
}

class _homePageBannerState extends State<homePageBanner> {
  CarouselController _controller = CarouselController();

  // int _changeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetHomePageViewModel>(
      builder: (controller) {
        GetHomePageResponse response = controller.apiResponse.data;

        return Column(
          children: [
            Container(
              height: Get.height * 0.25,
              width: Get.width,
              color: Colors.transparent,
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (val, reason) {
                    controller.changeIndex = val;
                  },
                  viewportFraction: 1.0,
                  height: Get.height * 0.25,

                  enlargeCenterPage: false,
                  // autoPlay: false,
                ),
                items: response.response[0].homeBanner
                    .map((item) => Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              item.img.trim(),
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: Get.height * 0.25,
                            ),
                          )),
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  response.response[0].homeBanner.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: Get.height * 0.005,
                          backgroundColor: controller.changeIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      )),
            )
          ],
        );
      },
    );
  }
}
