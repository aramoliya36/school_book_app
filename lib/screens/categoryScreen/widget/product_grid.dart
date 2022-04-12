import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/category_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/all_category_response_model.dart';
import 'package:skoolmonk/viewModel/all_category_view_model.dart';

import '../../../common/circularprogress_indicator.dart';

BottomController homeController = Get.find();
CategoryController categoryController = Get.find();
CategoryViewModel categoryViewModel = Get.find();
Widget productGrid() {
  return GetBuilder<CategoryViewModel>(
    builder: (controller) {
      if (controller.apiResponse.status == Status.COMPLETE) {
        AllCategoryResponse response = controller.apiResponse.data;
        categoryController.mainCategoryIndexFind(
            findMainCategoryIndex: response.response[0].categoryId);
        print(
            "===========================categoryid=${categoryController.mainCategoryIndex}");
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Get.height * 0.02,
                crossAxisSpacing: Get.height * 0.02),
            itemCount: response.response.length,
            itemBuilder: (context, index) {
              return Material(
                child: Ink(
                  height: Get.height * 0.14,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorPicker.navyBlue)),
                  child: InkWell(
                    onTap: () {
                      homeController.setSelectedScreen('SubcategoryScreen');
                      categoryController.setSelectedTitle(
                          response.response[index].categoryName);
                      categoryController.categorySlug(
                          categorySlugName: response.response[index].catSlug);
                      print(
                          '---category slug---${categoryController.cateGorySlug}');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        response.response[index].categoryImg.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: commonImage(
                                  heightImage: Get.height * 0.038,
                                ),
                              )
                            : Image.network(
                                response.response[index].categoryImg.trim(),
                                height: Get.height * 0.13,
                              ),
                        Text(
                          response.response[index].categoryName,
                          style: TextStyle(fontSize: Get.height * 0.018),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }
      if (controller.apiResponse.status == Status.ERROR) {
        return Text("Server error");
      }
      return Center(child: circularProgress());
    },
  );
}
