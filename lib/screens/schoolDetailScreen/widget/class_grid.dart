import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/single_school_response.dart';
import 'package:skoolmonk/viewModel/single_school_viewmodel.dart';

import '../../../common/circularprogress_indicator.dart';
import '../../../controller/sub_category_controller.dart';
import '../../../model/responseModel/get_homepage_response_model.dart';

class MyClassBook extends StatefulWidget {
  final GetHomePageResponse responseData;

  const MyClassBook({Key key, this.responseData}) : super(key: key);
  @override
  _MyClassBookState createState() => _MyClassBookState();
}

class _MyClassBookState extends State<MyClassBook> {
  SubCategoryController _subCategoryController = Get.find();
  BottomController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount: widget.responseData.response[0].responseClass.length,
      itemBuilder: (BuildContext context, int index) {
        String classData =
            widget.responseData.response[0].responseClass[index].filterName;
        return Container(
          width: Get.width / 10,
          height: Get.height / 14,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                ColorPicker.navyBlue,
                ColorPicker.navyBlue.withOpacity(.9),
                ColorPicker.navyBlue.withOpacity(.8),
                ColorPicker.navyBlue.withOpacity(.6),
                ColorPicker.navyBlue.withOpacity(.8),
                ColorPicker.navyBlue.withOpacity(.9),
                ColorPicker.navyBlue,
              ])),
          child: InkWell(
            onTap: () {
              _subCategoryController.setCatSlugFilter(
                  slugName: widget.responseData.response[0].responseClass[index]
                      .filterSlug);
              homeController.setSelectedScreen('SubCategoryList');
              homeController.bottomIndex(1);
              print(
                  '---class filter----${widget.responseData.response[0].responseClass[index].filterSlug}');
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.013, bottom: Get.height * 0.013),
              child: Center(
                child: Text(
                  classData ?? '',
                  style: CommonTextStyle.subClassTextStyle,
                ),
              ),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }
}

class ClassGrid extends StatelessWidget {
  SingleSchoolViewModelController schoolViewModelController = Get.find();

  BottomController bottomController = Get.find();
  SchoolDetailController schoolDetailController = Get.find();
  SubCategoryController subCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleSchoolViewModelController>(
      builder: (controller) {
        if (controller.apiResponse.status == Status.COMPLETE) {
          SingleSchoolResponse response = controller.apiResponse.data;

          return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            itemCount: response.response[0].schoolCat.length,
            itemBuilder: (BuildContext context, int index) {
              var _data = response.response[0].schoolCat[index];
              return Container(
                width: Get.width / 10,
                height: Get.height / 14,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      ColorPicker.navyBlue,
                      ColorPicker.navyBlue.withOpacity(.9),
                      ColorPicker.navyBlue.withOpacity(.8),
                      ColorPicker.navyBlue.withOpacity(.6),
                      ColorPicker.navyBlue.withOpacity(.8),
                      ColorPicker.navyBlue.withOpacity(.9),
                      ColorPicker.navyBlue,
                    ])),
                child: InkWell(
                  onTap: () {
                    subCategoryController.setCatSlugFilter(
                        slugName: _data.catSlug);
                    schoolDetailController.setSelectedTitle(_data.categoryName);
                    subCategoryController.setSelectedTitle(_data.categoryName);
                    bottomController.setSelectedScreen('SubCategoryList');
                    bottomController.bottomIndex.value = 2;
                    schoolDetailController.setSelectedTitle(_data.categoryName);

                    schoolDetailController.clearSchoolCatProductList();

                    var schoolClass = _data.categoryName;

                    response.response[0].schoolCatProduct.forEach(
                      (element) {
                        if (element.categoryName == schoolClass) {
                          schoolDetailController
                              .setSchoolCatProductList(element);
                        }
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.013, bottom: Get.height * 0.013),
                    child: Center(
                      child: Text(
                        "${response.response[0].schoolCat[index].categoryName ?? ""}",
                        style: CommonTextStyle.subClassTextStyle,
                      ),
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          );
        } else {
          return Center(child: circularProgress());
        }
      },
    );
  }
}
