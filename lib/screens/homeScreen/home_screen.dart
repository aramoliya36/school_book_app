import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/drawer.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';
import 'package:skoolmonk/screens/homeScreen/widget/banner.dart';
import 'package:skoolmonk/screens/homeScreen/widget/category_headerar.dart';
import 'package:skoolmonk/screens/homeScreen/widget/view_all_text.dart';
import 'package:skoolmonk/viewModel/get_homepage_viewmodel.dart';

import '../../common/color_picker.dart';
import '../../common/textStyle.dart';
import '../schoolDetailScreen/widget/class_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomController homeController = Get.find();
  GetHomePageViewModel _getHomePageViewModel = Get.find();
  SchoolController _schoolController = Get.find();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    GetHomePageResponse responsePop = _getHomePageViewModel.apiResponse.data;
    if (_getHomePageViewModel.isHomePopUp) {
      Future.delayed(Duration(seconds: 1), () {
        var imageRespo = responsePop.response[0].popupScreen[0];

        if (imageRespo.show == '1') {
          if (_getHomePageViewModel.isHomePopUp) {
            _getHomePageViewModel.setHomePopup();
            Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  // barrierDismissible: false,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: [
                        Container(
                          width: Get.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  imageRespo.title ?? '',
                                  style: CommonTextStyle.appNameBlack,
                                ),
                              ),
                              Container(
                                height: Get.height / 4,
                                child: Image.network(
                                  imageRespo.img.trim(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  imageRespo.message ?? "",
                                  style: CommonTextStyle.categoryTextStyle,
                                ),
                              ),
                              MaterialButton(
                                child: Text(
                                  'Close',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: ColorPicker.redColorApp,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            });
          }
        }
      });
    } else {
      _getHomePageViewModel.getHomePageViewModel();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          drawer: DrawerClassApp(),
          key: globalKey,
          appBar: _buildAppBar(),
          body: _buildBody()),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        appTitle: "SkoolMonk",
        leadingIcon: Icons.menu,
        onPress: () {
          globalKey.currentState.openDrawer();
        });
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<GetHomePageViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return Container(
                  height: Get.height / 1.2,
                  width: Get.width,
                  child: Center(child: circularProgress()));
            }
            if (controller.apiResponse.status == Status.ERROR) {
              return Material(
                  color: Colors.white, child: Center(child: serverErrorText()));
            }
            if (controller.apiResponse.status == Status.COMPLETE) {
              GetHomePageResponse response = controller.apiResponse.data;
              AppConfig appConfig = response.response[0].appConfig[0];
              Utility.privacyPolicyLink = appConfig.privacyPolicyLink;
              Utility.termsConditionsLink = appConfig.termsAndConditionsLink;
              Utility.refundPolicyLink = appConfig.refundPolicyLink;
              Utility.helpLink = appConfig.otherLink;
              Utility.perPageSize = int.parse(appConfig.perPage);
              Utility.isMultiFilter = appConfig.multiFilter;
              Utility.faqLink = appConfig.faqLink;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox(),
                  categoryHeader(response),
                  InkWell(
                      onTap: () {
                        homeController.bottomIndex.value = 1;
                      },
                      child: viewAllText()),
                  sizedBox(),
                  homePageBanner(),

                  sizedBox(),
                  Text("Shop By Class", style: CommonTextStyle.classTextStyle),
                  sizedBox(),
                  // ClassGrid(responseData:response),
                  MyClassBook(
                    responseData: response,
                  ),
                  InkWell(
                    onTap: () {
                      if (response
                          .response[0].schoolBanner[0].schoolSlug.isNotEmpty) {
                        _schoolController.schoolSlugFindName(
                            schoolSlugSet: response
                                .response[0].schoolBanner[0].schoolSlug);
                        homeController.bottomIndex(2);
                        homeController.selectedScreen('SchoolDetailScreen');
                      } else {
                        // homeController.bottomIndex(2);
                        // homeController.selectedScreen('SchoolScreen');
                      }

                      // homeController.selectedScreen()
                    },
                    child: Container(
                      height: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          response.response[0].schoolBanner[0].schoolBanner
                              .trim(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  InkWell(onTap: () {}, child: viewAllText()),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: response.response[0].publisher.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 150,
                            child: response.response[0].publisher[index]
                                    .filterImg.isEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: commonImage(
                                          heightImage: 30, widthImage: 30),
                                    ),
                                  )
                                : Image.network(
                                    response
                                        .response[0].publisher[index].filterImg
                                        .trim(),
                                    fit: BoxFit.cover,
                                  ),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(onTap: () {}, child: viewAllText()),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: response.response[0].brand.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 150,
                            child: response
                                    .response[0].brand[index].filterImg.isEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: commonImage(
                                          heightImage: 30, widthImage: 30),
                                    ),
                                  )
                                : Image.network(
                                    response.response[0].brand[index].filterImg
                                        .trim(),
                                    fit: BoxFit.cover,
                                  ),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      },
                    ),
                  ),
                  // ListView.builder(
                  //   itemCount: response.response[0].subject.length,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       width: Get.width / 10,
                  //       height: Get.height / 14,
                  //       decoration: BoxDecoration(
                  //           gradient: LinearGradient(
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //               colors: [
                  //             ColorPicker.navyBlue,
                  //             ColorPicker.navyBlue.withOpacity(.9),
                  //             ColorPicker.navyBlue.withOpacity(.8),
                  //             ColorPicker.navyBlue.withOpacity(.6),
                  //             ColorPicker.navyBlue.withOpacity(.8),
                  //             ColorPicker.navyBlue.withOpacity(.9),
                  //             ColorPicker.navyBlue,
                  //           ])),
                  //       child: InkWell(
                  //         onTap: () {
                  //           // _subCategoryController.setCatSlugFilter(
                  //           //     slugName: widget.responseData.response[0]
                  //           //         .responseClass[index].filterSlug);
                  //           homeController.setSelectedScreen('SubCategoryList');
                  //           homeController.bottomIndex(1);
                  //           // print(
                  //           //     '---class filter----${widget.responseData.response[0].responseClass[index].filterSlug}');
                  //         },
                  //         child: Padding(
                  //           padding: EdgeInsets.only(
                  //               top: Get.height * 0.013,
                  //               bottom: Get.height * 0.013),
                  //           child: Center(
                  //             child: Text(
                  //               '',
                  //               style: CommonTextStyle.subClassTextStyle,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  SizedBox sizedBox() {
    return SizedBox(
      height: Get.height * 0.02,
    );
  }
}
