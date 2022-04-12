import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/filter_data_encoding.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/model/responseModel/filter_personal_call_response_model.dart';
import 'package:skoolmonk/screens/filterScreen/widget/filterButton.dart';
import 'package:skoolmonk/screens/filterScreen/widget/filter_body.dart';
import 'package:skoolmonk/viewModel/mainCategoriesSubcategoriesProductFilter_view_model.dart';

class FilterScreen extends StatefulWidget {
  final FilterPerosonalCallRespons response;
  final VoidCallback callBackFilter;
  const FilterScreen({this.response, this.callBackFilter});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterDataList filterDataList = Get.put(FilterDataList());
  MainCategoriesSubcategoriesProductFilterViewModel
      _mainCategoriesSubcategoriesProductFilterViewModel = Get.find();
  SubCategoryController subCategoryController = Get.find();
  MainCategoriesSubcategoriesProductFilterViewModel _filterResponse =
      Get.find();
  FilterDataController filterScreenController = Get.find();
  String categorySlug = "categorySlug", isCheckFilter;

  @override
  void initState() {
    super.initState();

    filterDataList.setSelectedFilterData("Publisher");
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Stack(
      children: [
        filterBody(filterDataList: filterDataList, response: widget.response),
        Positioned(
          bottom: Get.height * 0.06,
          child: Container(
            width: Get.width,
            // height: Get.height * 0.05,
            //color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.height * 0.027),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filterButton(
                      title: "CLOSE",
                      buttonColor: ColorPicker.redColorApp,
                      textColor: Colors.white,
                      onPress: () {
                        Get.back();
                      }),
                  filterButton(
                      title: "APPLY",
                      buttonColor: ColorPicker.navyBlue,
                      textColor: Colors.white,
                      onPress: () {
                        List<Map> listFilterEncode = [];
                        Map<String, List<String>> mapData;

                        filterScreenController.filterMapList
                            .forEach((key, value) {
                          List<String> _list = [];
                          String filterKey = jsonEncode("filter");
                          String filterSlugKey = jsonEncode("filter_slug");
                          String filterValue = jsonEncode("$key");
                          value.forEach((element) {
                            _list.add(jsonEncode(element));
                          });

                          listFilterEncode.add(
                              {filterKey: filterValue, filterSlugKey: _list});
                          mapData = filterScreenController.filterMapList;
                        });
                        if (filterScreenController.filterMapList.length > 0) {
                          PreferenceManager.getStorage
                              .write(categorySlug, listFilterEncode);
                          var filterDataSendApi =
                              PreferenceManager.getStorage.read(categorySlug);
                          Get.back();

                          MainCategoriesSubcategoriesProductFilterRequest
                              _user =
                              MainCategoriesSubcategoriesProductFilterRequest();
                          _user.userId = PreferenceManager.getTokenId() ?? '0';
                          _user.catSlug =
                              '${subCategoryController.catSlugFilter}';
                          _user.page = '0';
                          _user.count = 'NO';
                          _user.perpage = '15';
                          _user.filter = '$filterDataSendApi';

                          _filterResponse
                              .mainCategoriesSubcategoriesProductFilterViewModel(
                                  model: _user)
                              .then((value) {
                            MainCategoriesSubcategoriesProductFilterResponse
                                _res = _filterResponse.apiResponse.data;
                            print(
                                '------RES-------${_res.response[0].product.length}');
                            print("It's call filter in filter");
                            subCategoryController.productCallBack =
                                _res.response[0].product.length;
                            subCategoryController.filterCallBack = true;
                            //filterScreenController.clearFilterMap();
                            // Get.back();
                          });
                        } else {
                          return CommonSnackBar.showSnackBar(
                              msg: 'Please Select Category ');
                        }

                        // print("filtered$filtered");
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
