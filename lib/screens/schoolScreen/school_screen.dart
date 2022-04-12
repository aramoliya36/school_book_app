import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/drawer.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/all_school_responce_model.dart';
import 'package:skoolmonk/viewModel/all_school_view_model.dart';

import '../../common/circularprogress_indicator.dart';

class SchoolScreen extends StatefulWidget {
  final String schoolName;
  final String address;
  final String countries;
  final String state;
  final String city;

  const SchoolScreen(
      {Key key,
      this.schoolName,
      this.address,
      this.countries,
      this.state,
      this.city})
      : super(key: key);

  @override
  _SchoolScreenState createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  BottomController homeController = Get.find();

  SchoolController schoolController = Get.find();
  SchoolViewModel schoolViewModel = Get.find();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schoolViewModel.allSchool();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        homeController.bottomIndex.value = 0;

        return Future.value(false);
      },
      child: Scaffold(
        drawer: DrawerClassApp(),
        key: globalKey,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          InkWell(
            onTap: () {
              homeController.bottomIndex.value = 2;
              homeController.selectedScreen('SchoolTab');
            },
            child: Container(
              height: Get.height * 0.052,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Get.height * 0.03,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          'Search Result',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.location_on,
                        size: Get.height * 0.03,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Expanded(child: GetBuilder<SchoolViewModel>(
            builder: (controller) {
              if (controller.apiResponse.status == Status.COMPLETE) {
                AllSchoolResponse response = controller.apiResponse.data;
                return ListView.builder(
                    itemCount: response.response.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            homeController
                                .setSelectedScreen("schoolDetailScreen");
                            schoolController.schoolSlugFindName(
                                schoolSlugSet:
                                    response.response[index].schoolSlug);
                            schoolController.setSelectedTitle(
                                response.response[index].schoolName);
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: Get.height * 0.13,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Container(
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.23,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            response.response[index].schoolLogo
                                                .trim(),
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        response.response[index].schoolName,
                                        overflow: TextOverflow.ellipsis,
                                        style: CommonTextStyle
                                            .schoolDetailTextStyle,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Text(
                                        response.response[index].landmark,
                                        overflow: TextOverflow.ellipsis,
                                        style: CommonTextStyle.MRPTextStyle,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (controller.apiResponse.status == Status.ERROR) {
                return Center(child: Text("Server error"));
              }
              return Center(child: circularProgress());
            },
          ))
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        appTitle: "School",
        leadingIcon: Icons.menu,
        onPress: () {
          globalKey.currentState.openDrawer();
        });
  }
}
