import 'dart:developer';

import 'package:get/get.dart';
import 'package:skoolmonk/model/responseModel/single_school_response.dart';

class SchoolDetailController extends GetxController {
  String titleSlugProductDetailsScreen;
  setTitleSlugProductDetailsScreen({String titleSlugProductDetails}) {
    titleSlugProductDetailsScreen = titleSlugProductDetails;
    update();
  }

  RxString _selectedTitle = ''.obs;

  RxString get selectedTitle => _selectedTitle;

  void setSelectedTitle(String value) {
    _selectedTitle = value.obs;
    log('subCate=>$_selectedTitle');
    update();
  }

  RxList<SchoolCatProduct> _schoolCatProductList = <SchoolCatProduct>[].obs;

  RxList<SchoolCatProduct> get schoolCatProductList => _schoolCatProductList;
  List<SchoolCatProduct> singleProductDetailsList = <SchoolCatProduct>[];
  void clearSingleProductDetailsList() {
    singleProductDetailsList.clear();
  }

  void setSchoolCatProductList(SchoolCatProduct value) {
    _schoolCatProductList.add(value);
    update();
  }

  void clearSchoolCatProductList() {
    _schoolCatProductList.clear();
    update();
  }
}
