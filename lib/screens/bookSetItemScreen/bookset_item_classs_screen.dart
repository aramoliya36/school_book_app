import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/controller/bookset_item_class_controller.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/screens/bookSetItemScreen/widget/bbokSet_detail_grid.dart';

class BookItemClassScreen extends StatelessWidget {
  BottomController bottomController = Get.find();
  BookItemClassController bookItemClassController = Get.find();
  SchoolDetailController schoolDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolDetailController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            bottomController.setSelectedScreen('schoolDetailScreen');
            return Future.value(false);
          },
          child: GetBuilder<SchoolDetailController>(
            builder: (controller) {
              return Scaffold(
                appBar: CommonAppBar.commonAppBar(
                    onPress: () {
                      bottomController.setSelectedScreen('schoolDetailScreen');
                    },
                    appTitle: controller.selectedTitle.value ?? '',
                    leadingIcon: Icons.arrow_back_rounded),
                body: _buildBody(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        // availableProduct(),
        bookSetDetailGrid(),
      ],
    );
  }

  Widget _buildAppBar(SchoolDetailController controller) {
    return CommonAppBar.commonAppBar(
        onPress: () {
          bottomController.setSelectedScreen('schoolDetailScreen');
        },
        appTitle: controller.singleProductDetailsList[0].categoryName,
        leadingIcon: Icons.arrow_back_rounded);
  }
}
