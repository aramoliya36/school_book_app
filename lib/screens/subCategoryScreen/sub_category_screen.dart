import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/category_controller.dart';
import 'package:skoolmonk/screens/subCategoryScreen/widget/sub_category_list.dart';

class SubcategoryScreen extends StatefulWidget {
  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  int currentIndex;
  BottomController homeController = Get.find();
  // SubCategoryController subCategoryController = Get.find();
  @override
  void initState() {
    print('--------selectedScreen---------${homeController.selectedScreen}');
    print('--------bottomIndex---------${homeController.bottomIndex}');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return WillPopScope(
            onWillPop: () {
              homeController.setSelectedScreen('CategoryScreen');
              return Future.value(false);
            },
            child:
                Scaffold(appBar: _buildAppBar(controller), body: _buildBody()));
      },
    );
  }

  Widget _buildAppBar(CategoryController controller) {
    return CommonAppBar.commonAppBar(
        onPress: () {
          homeController.setSelectedScreen('CategoryScreen');
        },
        appTitle: controller.selectedTitle.value ?? '',
        leadingIcon: Icons.arrow_back_rounded);
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(Get.height * 0.02),
      child: SubCategoryList(),
    );
  }
}
