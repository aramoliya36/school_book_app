import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_controller.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/widget/bookSet_title.dart';
import 'package:skoolmonk/screens/schoolDetailScreen/widget/school_detail_card.dart';
import 'package:skoolmonk/viewModel/single_school_viewmodel.dart';

class SchoolDetailScreen extends StatefulWidget {
  @override
  _SchoolDetailScreenState createState() => _SchoolDetailScreenState();
}

class _SchoolDetailScreenState extends State<SchoolDetailScreen> {
  BottomController bottomController = Get.find();
  SchoolController schoolController = Get.find();
  SingleSchoolViewModelController schoolViewModelController = Get.find();
  @override
  void initState() {
    super.initState();
    schoolViewModelController.singlSchool(
        schoolSlug: schoolController.schoolSlugName);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            bottomController.setSelectedScreen('SchoolScreen');
            return Future.value(false);
          },
          child: Scaffold(
            appBar: _buildAppBar(controller),
            body: _buildBody(),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          schoolDetailCard(),
          SizedBox(
            height: Get.height * 0.03,
          ),
          bookSet()
        ],
      ),
    );
  }

  Widget _buildAppBar(SchoolController controller) {
    return CommonAppBar.commonAppBar(
        onPress: () {
          bottomController.setSelectedScreen('SchoolScreen');
        },
        appTitle: controller.selectedTitle.value ?? '',
        leadingIcon: Icons.arrow_back_rounded);
  }
}
