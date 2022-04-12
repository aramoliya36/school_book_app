import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/filter_controller.dart';
import 'package:skoolmonk/controller/filter_data_encoding.dart';
import 'package:skoolmonk/model/responseModel/filter_personal_call_response_model.dart';

import '../../../common/shared_preference.dart';

class FilterDataList extends GetxController {
  RxString _selectedFilterData = "Publisher".obs;

  RxString get selectedFilterData => _selectedFilterData;

  void setSelectedFilterData(String value) {
    _selectedFilterData = value.obs;

    update();
  }
}

filterBody(
    {FilterDataList filterDataList, FilterPerosonalCallRespons response}) {
  FilterDataController filterScreenController = Get.find();
  return Column(
    mainAxisSize: MainAxisSize.min,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          width: Get.width / 3,
          decoration: BoxDecoration(
              //color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: MaterialButton(
              height: 30,
              minWidth: 100,
              color: Colors.white,
              child: Text(
                'Filter Data',
                style: TextStyle(color: ColorPicker.navyBlue, fontSize: 20),
              ),
              onPressed: () {
                filterScreenController.clearFilterMap();
                PreferenceManager.getStorage.write("categorySlug", "");

                Get.back();
              },
            ),
          ),
        ),
      ),
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<FilterController>(
              builder: (controller) {
                return Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40))),
                      child: ListView.builder(
                        itemCount: response.response[0].filters.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, subIndex) {
                          return GestureDetector(
                              onTap: () {
                                String indexFilterTypeName = response
                                    .response[0]
                                    .filters[subIndex]
                                    .filterTypeName;
                                controller.clearFilterList();
                                controller.setMainFilterTage(
                                    saveMainFilter: response.response[0]
                                        .filters[subIndex].filterTypeName);
                                print(
                                    '----------tag name------${response.response[0].filters[subIndex].filterTypeName}');

                                response.response[0].filters.forEach((element) {
                                  if (element.filterTypeName ==
                                      indexFilterTypeName) {
                                    controller.clearSchoolCatProductList();
                                    controller.setSchoolCatProductList(
                                        value: element);
                                    element.filterData.forEach((subElement) {
                                      controller.setFilterData(
                                          value: subElement.filterName);
                                      // setFilterData();
                                    });
                                  }
                                });
                                print(
                                    '----------------------data-----lisr--${controller.filterData}');
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                decoration: BoxDecoration(
                                    color: response
                                                .response[0]
                                                .filters[subIndex]
                                                .filterTypeName ==
                                            controller.mainFilterTag
                                        ? Color(0xfff4f4f4)
                                        : Colors.white,
                                    border: Border.symmetric(
                                        horizontal:
                                            BorderSide(color: Colors.grey))),
                                child: Center(
                                    child: Text(
                                  '${response.response[0].filters[subIndex].filterTypeName ?? ''}',
                                  style: CommonTextStyle.filterTextStyle,
                                )),
                              ));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<FilterController>(
              builder: (controller) {
                return Expanded(
                  flex: 4,
                  child: Container(
                    height: Get.height,
                    child: controller.schoolCatFilterList.isEmpty
                        ? Center(child: Text('Select Category'))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                      height: Get.height * 0.8,
                                      child: ListView.builder(
                                        itemCount: controller
                                            .schoolCatFilterList.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          // String filterName =
                                          //     controller.filterData[subIndex];
                                          // String filterSlug =
                                          //     controller.filterData[subIndex];
                                          return ListView.builder(
                                            itemCount: controller
                                                .schoolCatFilterList[index]
                                                .filterData
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, subIndex) {
                                              String filterName = controller
                                                  .schoolCatFilterList[index]
                                                  .filterTypeName;
                                              String filterSlug = controller
                                                  .schoolCatFilterList[index]
                                                  .filterData[subIndex]
                                                  .filterSlug;
                                              return SizedBox(
                                                height: Get.height * 0.05,
                                                child: GetBuilder<
                                                    FilterDataController>(
                                                  builder: (subController) {
                                                    return Utility
                                                                .isMultiFilter ==
                                                            "yes"
                                                        ? CheckboxListTile(
                                                            controlAffinity:
                                                                ListTileControlAffinity
                                                                    .leading,
                                                            title: Text(
                                                              controller
                                                                  .schoolCatFilterList[
                                                                      index]
                                                                  .filterData[
                                                                      subIndex]
                                                                  .filterName,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.02),
                                                            ),
                                                            value: subController
                                                                    .filterMapList
                                                                    .isEmpty
                                                                ? false
                                                                : !subController
                                                                        .filterMapList
                                                                        .containsKey(
                                                                            filterName)
                                                                    ? false
                                                                    : subController
                                                                            .filterMapList[filterName]
                                                                            .contains(filterSlug)
                                                                        ? true
                                                                        : false,
                                                            //  value:subController.filterMapList.isEmpty?false:!subController.filterMapList.value.containsKey(filterName)
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            activeColor:
                                                                ColorPicker
                                                                    .navyBlue,
                                                            checkColor:
                                                                Colors.white,
                                                            onChanged:
                                                                (bool value) {
                                                              subController.addFilterMap(
                                                                  key:
                                                                      filterName,
                                                                  value:
                                                                      filterSlug);
                                                              print(
                                                                  '-----check ---box---value${subController.filterMapList}');
                                                            },
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15),
                                                                child: Text(
                                                                  controller
                                                                      .schoolCatFilterList[
                                                                          index]
                                                                      .filterData[
                                                                          subIndex]
                                                                      .filterName,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Radio(
                                                                activeColor:
                                                                    ColorPicker
                                                                        .navyBlue,
                                                                groupValue: subController
                                                                        .filterMapList
                                                                        .isEmpty
                                                                    ? null
                                                                    : !subController
                                                                            .filterMapList
                                                                            .value
                                                                            .containsKey(filterName)
                                                                        ? null
                                                                        : subController.filterMapList.value[filterName].contains(filterSlug)
                                                                            ? filterSlug
                                                                            : null,
                                                                value:
                                                                    filterSlug,
                                                                onChanged:
                                                                    (value) {
                                                                  subController.addRadioFilterMap(
                                                                      key:
                                                                          filterName,
                                                                      value:
                                                                          filterSlug);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            filterScreenController.clearFilterMap();
            PreferenceManager.getStorage.write("categorySlug", "");

            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              'Clear all',
              style: TextStyle(
                  color: ColorPicker.navyBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}
