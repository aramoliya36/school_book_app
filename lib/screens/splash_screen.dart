import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skoolmonk/AppVersionFile/app_version_file.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/imageWidget.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/reqestModel/update_app_info_reqestmodel.dart';
import 'package:skoolmonk/screens/sliderScren/sliderScreen.dart';
import 'package:skoolmonk/viewModel/update_user_app_info_viewmodel.dart';

import '../model/responseModel/get_homepage_response_model.dart';
import '../viewModel/get_homepage_viewmodel.dart';
import 'bottombar/navigation_bar.dart';
import 'package:get/get.dart';

import 'maintenanceScreen/maintenance_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetHomePageViewModel _getHomePageViewModel = Get.find();
  UpdateUserAppInfoViewModel _updateUserAppInfoViewModel = Get.find();
  UpdateAppInfoRequestModel _updateAppInfoRequestModel =
      UpdateAppInfoRequestModel();
  Future mainTenanceScreen() async {
    await _getHomePageViewModel.getHomePageViewModel();
    GetHomePageResponse response = _getHomePageViewModel.apiResponse.data;
    // print('${response.status}');
    var homeResponse = response.response[0];
    if (homeResponse.maintenanceScreen[0].show == '1') {
      Get.offAll(MaintenanceScreen());
    } else {
      if (homeResponse.appScreen[0].show == '1') {
        Get.offAll(SliderScreen());
      } else {
        Get.offAll(NavigationBarScreen());
      }
    }
  }

  updateAppInfoMethod() async {
    String _fcmId = PreferenceManager.getFcmToken();
    String _currentUserId = PreferenceManager.getTokenId();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    UpdateAppInfoRequestModel _updateAppInfoRequestModel =
        UpdateAppInfoRequestModel();
    _updateAppInfoRequestModel.uniqueId = DateTime.now().toString();
    _updateAppInfoRequestModel.osInfoMobile = Platform.isAndroid
        ? 'isAndroid'
        : Platform.isIOS
            ? 'isIos'
            : '';
    _updateAppInfoRequestModel.fcmIdToken = _fcmId;
    _updateAppInfoRequestModel.currentUserId = _currentUserId;
    _updateAppInfoRequestModel.appVersion = AppVersionFileClass.kAppVersion;
    _updateAppInfoRequestModel.modelNameMobile = androidInfo.model;
    _updateUserAppInfoViewModel.updateUserAppInfoViewModel(
        model: _updateAppInfoRequestModel);
  }

  @override
  void initState() {
    print(
        '------PreferenceManager.getFcmToken()------${PreferenceManager.getTokenId()}');
    if (PreferenceManager.getTokenId() != null) {
      updateAppInfoMethod();
    }
    Timer(Duration(seconds: 3), () {
      mainTenanceScreen();
      //Get.offAll(NavigationBarScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.navyBlue,
      body: Center(child: ImageWidget.appLogo),
    );
  }
}
