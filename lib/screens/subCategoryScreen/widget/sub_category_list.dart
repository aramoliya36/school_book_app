import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/category_controller.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/sub_category_header_response_model.dart';
import 'package:skoolmonk/viewModel/sub_category_view_model.dart';

import '../../../common/circularprogress_indicator.dart';

class SubCategoryList extends StatefulWidget {
  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  int currentIndex;
  BottomController homeController = Get.find();
  SubCategoryController subCategoryController = Get.find();
  SubCategoryViewModel subCategoryViewModel = Get.find();
  CategoryController categoryController = Get.find();
  navigatorProductGrid(SubCategoryHeaderResponse response) {
    subCategoryController
        .setSelectedTitle(response.response[0].categoryName ?? '');
    subCategoryController.setCatSlugFilter(
        slugName: response.response[0].catSlug);
    Future.delayed(Duration(seconds: 1), () {
      homeController.selectedScreen('SubCategoryList');
    });
  }

  @override
  void initState() {
    super.initState();
    subCategoryViewModel.subCategory(
      categorySlug: categoryController.cateGorySlug,
      categoryId: categoryController.mainCategoryIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GetBuilder<SubCategoryViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.COMPLETE) {
            SubCategoryHeaderResponse response = controller.apiResponse.data;
            if (response.response[0].subcategory.isEmpty) {
              navigatorProductGrid(response);
              return SizedBox();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });

                        subCategoryController.setCatSlugFilter(
                            slugName: response
                                .response[0].subcategory[index].catSlug);
                        subCategoryController.setSelectedTitle(response
                            .response[0].subcategory[index].categoryName);
                        print(
                            '---title for app -${response.response[0].subcategory[index].categoryName}');
                        print(
                            '---------------subCategoryController Slug=====${response.response[0].subcategory[index].catSlug}');
                        homeController.setSelectedScreen('SubCategoryList');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              response
                                  .response[0].subcategory[index].categoryName,
                              style: TextStyle(
                                  fontSize: Get.height * 0.02,
                                  color: currentIndex == index
                                      ? ColorPicker.navyBlue
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset(
                              "assets/svg/double_arrow_icon.svg",
                              height: Get.height * 0.02,
                              color: currentIndex == index
                                  ? ColorPicker.navyBlue
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                );
              },
              itemCount: response.response[0].subcategory.isEmpty
                  ? 1
                  : response.response[0].subcategory.length,
            );
          } else {
            return Center(
              child: circularProgress(),
            );
          }
        },
      ),
    );
  }
}
