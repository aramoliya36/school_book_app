import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/widget/bookSet_title.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/widget/school_detail_card.dart';
import 'package:skoolmonk/common/textfields.dart';

import 'access_dialog.dart';
import '../../common/app_bar.dart';
import '../../common/circularprogress_indicator.dart';
import '../../controller/bottom_controller.dart';
import '../../controller/school_controller.dart';
import 'location_name_api.dart';
import '../../model/responseModel/city_model.dart';
import '../../model/responseModel/country_model.dart';
import '../../model/responseModel/filter_school_by_location.dart';
import '../../model/responseModel/school_list_model.dart';
import '../../model/responseModel/search_suggestion_model.dart';
import '../../model/responseModel/state_model.dart';
import 'school_api.dart';

class SchoolTab extends StatefulWidget {
  @override
  _SchoolTabState createState() => _SchoolTabState();
}

SchoolController schoolController = Get.find();

class _SchoolTabState extends State<SchoolTab> {
  /// pincode controller...
  SchoolAPI schoolAPI = SchoolAPI();
  TextEditingController pincodeController; // = TextEditingController();

  /// get all the list of school...
  Future<SchoolListModel> getAllSchoolList() async {
    dynamic schoolList = await schoolAPI.getAllSchoolList();
    SchoolListModel _schoolListModel = SchoolListModel.fromJson(schoolList);
    return _schoolListModel;
  }

  /// get all the school list by the location wise filter....
  Future getLocationFilterWiseSchool(
      String countryId, String stateId, String cityId, String pinCode) async {
    String userId = PreferenceManager.getTokenId() ?? "0";
    pinCode = pinCode == null || pinCode.isEmpty ? "0" : pinCode;
    dynamic response = await schoolAPI.findSchoolByLocation(
        userId.toString(), countryId, stateId, cityId, pinCode ?? "0");
    if (response['response'].length > 0) {
      FilterSchoolByLocation _filterSchoolByLocation =
          FilterSchoolByLocation.fromJson(response);

      return _filterSchoolByLocation;
    } else {
      NoDataOrderModel _noDataModel = NoDataOrderModel.fromJson(response);
      return _noDataModel;
    }
  }

  // ColorPalette colorPalette = ColorPalette();

  autoFillFields() {
    schoolController.setFindSchoolByLocationSelected(false);
    schoolController.setSearchSchoolTabSelected(false);
    schoolController.setSelectedCountryIdForSchool(101);
  }

  BottomController bottomController = Get.find();

  @override
  void initState() {
    super.initState();
    pincodeController = TextEditingController();
    schoolController.setSelectedStateIdForSchool(0);
    schoolController.setSelectedCityIdForSchool(0);
    if (pincodeController.text.length > 0) {
      schoolController.setSelectedPinCodeForSchool("0");
    }
    autoFillFields();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildAppBar(SchoolController controller) {
      return CommonAppBar.commonAppBar(
          onPress: () {
            bottomController.setSelectedScreen('SchoolScreen');
            bottomController.bottomIndex.value = 1;
          },
          appTitle: 'School',
          leadingIcon: Icons.arrow_back_rounded);
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        bottomController.bottomIndex.value = 2;
        bottomController.setSelectedScreen('SchoolScreen');
        return Future.value(false);
      },
      child: SafeArea(
        child: GetBuilder<SchoolController>(
          builder: (controller) {
            return Scaffold(
              appBar: _buildAppBar(controller),
              body: FutureBuilder(
                future: getAllSchoolList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 16,
                                top: 20,
                                bottom: 20,
                                right: 10,
                              ),
                              padding: EdgeInsets.only(left: 5, top: 3),
                              height: width / 8,
                              width: width / 1.3,
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: TextField(
                                onTap: () {},
                                onChanged: (value) {
                                  if (value.length < 1) {
                                    controller
                                        .setSearchSchoolTabSelected(false);
                                    controller
                                        .setFindSchoolByLocationSelected(false);
                                  } else {
                                    controller.setSearchSchoolTabSelected(true);

                                    controller.schoolsToFilter.clear();
                                    snapshot.data.response.forEach((e) {
                                      if (e.schoolName
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase())) {
                                        controller
                                            .schoolsToFilterAddSingleSchool(e);
                                      }
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search School",
                                  hintStyle: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 18,
                                    color: Color(0xff515C6F),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xff515C6F),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => LocationDialog(
                                      width: width,
                                      pinCodeController: pincodeController,
                                      onCancelTap: () {
                                        Navigator.pop(context);
                                      },
                                      onSearchTap: () {
                                        /// assign zero if any fileds are null...

                                        int cityId = controller
                                            .selectedCityIdForSchool.value;
                                        controller
                                            .setSelectedCityIdForSchool(cityId);

                                        int stateId = controller
                                            .selectedStateIdForSchool.value;
                                        controller.setSelectedStateIdForSchool(
                                            stateId);

                                        int countryId = controller
                                                    .selectedCountryIdForSchool
                                                    .value ==
                                                null
                                            ? 0
                                            : controller
                                                .selectedCountryIdForSchool
                                                .value;
                                        controller
                                            .setSelectedCountryIdForSchool(
                                                countryId);

                                        controller.setSelectedPinCodeForSchool(
                                            pincodeController.text);

                                        controller
                                            .setFindSchoolByLocationSelected(
                                                true);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                child: Icon(Icons.location_on),
                              ),
                            )
                          ],
                        ),
                        controller.isFindSchoolByLocationSelected.value
                            ? FutureBuilder(
                                future: getLocationFilterWiseSchool(
                                    controller.selectedCountryIdForSchool.value
                                        .toString(),
                                    controller.selectedStateIdForSchool.value
                                        .toString(),
                                    controller.selectedCityIdForSchool.value
                                        .toString(),
                                    controller.selectedPinCodeForSchool.value),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.response.length > 0) {
                                      FilterSchoolByLocation
                                          _filterSchoolByLocation =
                                          snapshot.data;
                                      return Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 70),
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                snapshot.data.response.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  log("GET LOCATION FILTER TAP 1");
                                                  bottomController
                                                      .bottomIndex.value = 2;
                                                  bottomController
                                                      .setSelectedScreen(
                                                          "SchoolDetailScreen");
                                                  schoolController
                                                      .schoolSlugFindName(
                                                          schoolSlugSet:
                                                              snapshot
                                                                  .data
                                                                  .response[
                                                                      index]
                                                                  .schoolSlug);
                                                  schoolController
                                                      .setSelectedTitle(snapshot
                                                          .data
                                                          .response[index]
                                                          .schoolName);
                                                  controller
                                                          .selectedTitle.value =
                                                      "${snapshot.data.response[index].schoolName}";

                                                  controller.setSelectedSchoolSlug(
                                                      "${snapshot.data.response[index].schoolSlug}");

                                                  controller.setSelectedString =
                                                      "SchoolInfo";
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  height: 80,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  _filterSchoolByLocation
                                                                      .response[
                                                                          index]
                                                                      .schoolLogo
                                                                      .trim()),
                                                              fit: BoxFit
                                                                  .contain,
                                                              alignment:
                                                                  Alignment
                                                                      .center),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      15.0)),
                                                        ),
                                                        // padding: EdgeInsets.all(3),
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snapshot.data.response[index]
                                                                            .schoolName !=
                                                                        null
                                                                    ? '${snapshot.data.response[index].schoolName}'
                                                                    : '',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                ' ${snapshot.data.response[index].city}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          controller
                                              .isFindSchoolByLocationSelected
                                              .value = false;
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 50.0),
                                            SvgPicture.asset(
                                              'assets/icons/no_data.svg',
                                              height: 100,
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              'No Data',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  } else {
                                    return Container(
                                      child: circularProgress(),
                                    );
                                  }
                                })
                            : controller.isSearchSchoolTabSelected.value
                                ? Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 70),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount:
                                            controller.schoolsToFilter.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              log("GET LOCATION FILTER TAP 2");
                                              bottomController
                                                  .bottomIndex.value = 2;
                                              bottomController
                                                  .setSelectedScreen(
                                                      "SchoolDetailScreen");
                                              schoolController
                                                  .schoolSlugFindName(
                                                      schoolSlugSet: snapshot
                                                          .data
                                                          .response[index]
                                                          .schoolSlug);
                                              schoolController.setSelectedTitle(
                                                  snapshot.data.response[index]
                                                      .schoolName);

                                              controller.selectedTitle.value =
                                                  "${controller.schoolsToFilter[index].schoolName}";

                                              controller.selectedSchoolSlug
                                                      .value =
                                                  "${controller.schoolsToFilter[index].schoolSlug}";
                                              controller.selectedString.value =
                                                  "SchoolInfo";
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff3f3f3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                              height: 80,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              controller
                                                                  .schoolsToFilter[
                                                                      index]
                                                                  .schoolLogo
                                                                  .trim()),
                                                          fit: BoxFit.contain,
                                                          alignment:
                                                              Alignment.center),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      15.0)),
                                                    ),
                                                    // padding: EdgeInsets.all(3),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot
                                                                        .data
                                                                        .response[
                                                                            index]
                                                                        .schoolName !=
                                                                    null
                                                                ? '${controller.schoolsToFilter[index].schoolName},'
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            controller
                                                                        .schoolsToFilter[
                                                                            index]
                                                                        .city !=
                                                                    null
                                                                ? '${controller.schoolsToFilter[index].city}'
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 70),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),

                                        // gridDelegate:
                                        //     SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 2,
                                        //         childAspectRatio: 1.2),
                                        itemCount:
                                            snapshot.data.response.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              log("GET LOCATION FILTER TAP 3");
                                              bottomController
                                                  .bottomIndex.value = 2;
                                              bottomController
                                                  .setSelectedScreen(
                                                      "SchoolDetailScreen");
                                              schoolController
                                                  .schoolSlugFindName(
                                                      schoolSlugSet: snapshot
                                                          .data
                                                          .response[index]
                                                          .schoolSlug);
                                              schoolController.setSelectedTitle(
                                                  snapshot.data.response[index]
                                                      .schoolName);
                                              if (snapshot.data.response[index]
                                                      .isSchoolSecure ==
                                                  '1') {
                                                bool status = await Get.dialog(
                                                    accessDialog(
                                                        schoolSlug: snapshot
                                                            .data
                                                            .response[index]
                                                            .schoolSlug));
                                                if (status) {
                                                  controller
                                                          .selectedTitle.value =
                                                      "${snapshot.data.response[index].schoolName}";
                                                  controller.setSelectedSchoolSlug(
                                                      "${snapshot.data.response[index].schoolSlug}");

                                                  controller.selectedString
                                                      .value = "SchoolInfo";
                                                }
                                              } else {
                                                controller.setSelectedTitle(
                                                    "${snapshot.data.response[index].schoolName}");
                                                controller.setSelectedSchoolSlug(
                                                    "${snapshot.data.response[index].schoolSlug}");

                                                controller.setSelectedString =
                                                    "SchoolInfo";
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff3f3f3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                              height: 80,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot
                                                                  .data
                                                                  .response[
                                                                      index]
                                                                  .schoolLogo
                                                                  .trim()),
                                                          fit: BoxFit.contain,
                                                          alignment:
                                                              Alignment.center),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      15.0)),
                                                    ),
                                                    // padding: EdgeInsets.all(3),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot
                                                                        .data
                                                                        .response[
                                                                            index]
                                                                        .schoolName !=
                                                                    null
                                                                ? '${snapshot.data.response[index].schoolName}'
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                        .data
                                                                        .response[
                                                                            index]
                                                                        .city !=
                                                                    null
                                                                ? '${snapshot.data.response[index].city}'
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: circularProgress(),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget LocationDialog(
    {width,
    onSearchTap,
    onCancelTap,
    TextEditingController pinCodeController}) {
  // ColorPalette colorPalette = ColorPalette();
  LocationNameAPI locationNameAPI = LocationNameAPI();
  pinCodeController.clear();

  /// get all country
  Future<CountryModel> getAllCountry() async {
    dynamic response = await locationNameAPI.getAllCountryName();
    CountryModel _countryModel = CountryModel.fromJson(response);
    return _countryModel;
  }

  /// get all state of selected country
  Future getAllStateOfSelectedCountry(int countryId) async {
    dynamic response = await locationNameAPI.getAllStateOfCountry(countryId);
    // log("STATE RESPONSE $response");
    StateModel _stateModel = StateModel.fromJson(response);
    return _stateModel;
  }

  /// get all city of selected state
  Future<CityModel> getAllCityOfSelectedState(int stateId) async {
    dynamic response = await locationNameAPI.getAllCityOfState(stateId);
    CityModel _cityModel = CityModel.fromJson(response);
    return _cityModel;
  }

  int selectedCityIdForSchool,
      selectedCityIndexForSchool,
      selectedStateIdForSchool,
      selectedCountryIndexForSchool,
      selectedStateIndexForSchool;
  String selectedCountryIdForSchool;
  RxBool isCountry = false.obs;
  String selectedValue;

  return StatefulBuilder(builder: (context, dialogSetState) {
    SchoolController controller = Get.find();

    return Dialog(
      elevation: 100,
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        height: width,
        width: width - 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Search by Location',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
                SimpleTextfield("Pin Code",
                    controller: pinCodeController,
                    keyboardType: TextInputType.number),
                SizedBox(height: 20.0),
                FutureBuilder<CountryModel>(
                    future: getAllCountry(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int index1 = 0;
                        // print('country${snapshot.data.response[1].name}');
                        selectedCountryIdForSchool = snapshot.data.response
                            .firstWhere(
                                (element) =>
                                    element.name.toLowerCase() == "india",
                                orElse: () => null)
                            ?.countryId;
                        log("SELECTED COUNTRU ${selectedCountryIdForSchool}");
                        isCountry.value = true;

                        /*     snapshot.data.response.forEach((e) {
                          if ((e.name.toString().toLowerCase()) == "india") {
                            dialogSetState(() {
                              selectedCountryIndexForSchool = index1;
                              selectedCountryIdForSchool = int.parse(
                                  snapshot.data.response[index1].countryId);
                            });
                            // controller.setSelectedCountryIndexForSchool(index1);
                            //
                            // controller.setSelectedCountryIdForSchool(int.parse(
                            //     snapshot.data.response[index1].countryId));
                          }
                          index1++;
                        });*/
                        return FutureBuilder(
                            future: getAllStateOfSelectedCountry(
                                int.parse(selectedCountryIdForSchool)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data.response.length > 0) {
                                log("if  ...");

                                return Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.0),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: DropdownButton(
                                    onChanged: (v) {
                                      log("state id $v ");
                                    },
                                    underline: Container(),
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    value: null,
                                    hint: Text(selectedValue == null
                                        ? "Select state"
                                        : selectedValue),
                                    items: List.generate(
                                        snapshot.data.response.length,
                                        (index) => DropdownMenuItem(
                                              child: Text(
                                                '${snapshot.data.response[index].name}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value:
                                                  '${snapshot.data.response[index].stateId}',
                                              onTap: () {
                                                /*    controller
                                            .setSelectedCountryIndexForSchool(
                                                index);
                                        controller.setSelectedStateIdForSchool(
                                            int.parse(snapshot
                                                .data.response[index].stateId));
                                        controller
                                            .setSelectedCityIndexForSchool(0);*/
                                                controller
                                                    .setSelectedStateIdForSchool(
                                                        int.parse(snapshot
                                                            .data
                                                            .response[index]
                                                            .stateId));
                                                dialogSetState(() {
                                                  selectedValue = snapshot.data
                                                      .response[index].name;

                                                  selectedStateIdForSchool =
                                                      int.parse(snapshot
                                                          .data
                                                          .response[index]
                                                          .stateId);
                                                  selectedCityIndexForSchool =
                                                      0;
                                                });
                                                log("selectedValue $selectedValue");
                                              },
                                            )),
                                  ),
                                );
                              } else {
                                log("ELSE...");
                                return Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.0),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: DropdownButton(
                                    onChanged: (v) {},
                                    underline: Container(),
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    value: null,
                                    hint: Text("Select state"),
                                    items: List.generate(
                                        1,
                                        (index) => DropdownMenuItem(
                                              child: Text(
                                                'Select state',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value: 0,
                                              onTap: () {
                                                /*    controller
                                            .setSelectedCountryIndexForSchool(
                                                index);
                                        controller.setSelectedStateIdForSchool(
                                            int.parse(snapshot
                                                .data.response[index].stateId));
                                        controller
                                            .setSelectedCityIndexForSchool(0);*/

                                                dialogSetState(() {
                                                  selectedValue = snapshot.data
                                                      .response[index].name;

                                                  selectedStateIdForSchool =
                                                      int.parse(snapshot
                                                          .data
                                                          .response[index]
                                                          .stateId);
                                                  selectedCityIndexForSchool =
                                                      0;
                                                });
                                                log("selectedValue $selectedValue");
                                              },
                                            )),
                                  ),
                                );
                              }
                            });
                      } else {
                        return Container();
                      }
                    }),
                SizedBox(height: 20.0),
                FutureBuilder<CityModel>(
                    future: getAllCityOfSelectedState(
                        selectedStateIdForSchool ??
                            selectedCountryIndexForSchool),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.response.length > 0) {
                        controller.selectedCityIdForSchool(
                            int.parse(snapshot.data.response[0].cityId));
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            onChanged: (v) {},
                            underline: Container(),
                            isExpanded: true,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            value: snapshot
                                .data
                                .response[selectedCityIndexForSchool ??
                                    selectedCountryIndexForSchool]
                                .name,
                            items: List.generate(
                                snapshot.data.response.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                        '${snapshot.data.response[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      value:
                                          '${snapshot.data.response[index].name}',
                                      onTap: () {
                                        controller.selectedCityIdForSchool(
                                            int.parse(snapshot
                                                .data.response[index].cityId));
                                        // selectedCityIdForSchool = index;
                                        // selectedCityIndexForSchool = int.parse(
                                        //     snapshot
                                        //         .data.response[index].cityId);

                                        dialogSetState(() {
                                          selectedCityIndexForSchool = index;
                                          selectedCityIdForSchool = int.parse(
                                              snapshot
                                                  .data.response[index].cityId);
                                        });
                                      },
                                    )),
                          ),
                        );
                      } else {
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (value) {},
                            value: 'city',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text('City'),
                                value: 'city',
                              )
                            ],
                          ),
                        );
                        // return Center(child: circularProgress(),);
                      }
                    }),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: onCancelTap,
                      child: Container(
                        alignment: Alignment.center,
                        height: width / 8,
                        width: width / 2.8,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(18)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedCityIndexForSchool == null) {
                          controller.setSelectedCityIdForSchool(0);
                        }
                        if (selectedStateIdForSchool == null) {
                          controller.setSelectedStateIdForSchool(0);
                        }
                        if (pinCodeController.text.length > 0) {
                          controller.setSelectedPinCodeForSchool(
                              pinCodeController.text);
                        } else {
                          controller.setSelectedPinCodeForSchool("0");
                        }

                        onSearchTap();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: width / 8,
                        width: width / 2.8,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(18)),
                        child: Text(
                          "Search",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
