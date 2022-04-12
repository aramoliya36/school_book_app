import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/category_controller.dart';
import 'package:skoolmonk/screens/categoryScreen/widget/product_grid.dart';
import 'package:skoolmonk/viewModel/all_category_view_model.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  BottomController homeController = Get.find();
  CategoryViewModel categoryViewModel = Get.find();
  CategoryController categoryController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    print('------bottomIndex   --------${homeController.bottomIndex}');
    print('------selectedScreen--------${homeController.selectedScreen}');
    super.initState();
    categoryViewModel.allCategory();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        homeController.bottomIndex.value = 0;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {
          // Navigator.pop(context);
          homeController.bottomIndex.value = 0;
          homeController.setSelectedScreen('');
        },
        appTitle: "Category",
        leadingIcon: Icons.arrow_back_rounded);
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: productGrid(),
    );
  }
}
