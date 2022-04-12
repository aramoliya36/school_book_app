import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/iconWidget.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/category_controller.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';

import '../../../controller/bottom_controller.dart';
import '../../subCategoryListScreen/sub_category_list_screen.dart';

BottomController homeController = Get.find();
CategoryController categoryController = Get.find();

Container categoryHeader(GetHomePageResponse response) {
  return Container(
    height: Get.height * 0.13,
    width: Get.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: response.response[0].category.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              categoryController.categorySlug(
                  categorySlugName:
                      response.response[0].category[index].catSlug);
              // subCategoryController.setCatSlugFilter(
              //     slugName: response.response[0].category[index].catSlug);
              homeController.setSelectedScreen('SubcategoryScreen');
              homeController.bottomIndex(1);
            },
            child: Row(
              children: [
                categories(
                    response.response[0].category[index].categoryImg.trim(),
                    response.response[0].category[index].categoryName ?? ''),
                SizedBox(
                  width: Get.width * 0.03,
                )
              ],
            ),
          );
        }),
  );
}

Widget categories(String categoryIcon, String categoryTitle) {
  return Column(
    children: [
      Container(
        height: Get.height * 0.1,
        width: Get.width * 0.16,
        decoration:
            BoxDecoration(color: ColorPicker.navyBlue, shape: BoxShape.circle),
        child: Center(
          child: categoryIcon == '' || categoryIcon.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    'assets/svg/grey_logo.svg',
                    color: Colors.white,
                    fit: BoxFit.contain,
                    // height: heightImage,
                    // width: heightImage,
                  ),
                )
              : Image.network(
                  categoryIcon,
                  height: Get.height * 0.04,
                  fit: BoxFit.cover,
                ),
        ),
      ),
      Text(categoryTitle, style: CommonTextStyle.categoryTextStyle)
    ],
  );
}
