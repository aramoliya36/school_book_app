import 'dart:developer';

import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  // RxString _selectedTitle = ''.obs;
  //
  // RxString get selectedTitle => _selectedTitle;
  bool isRefres = false;
  setISRefresh({bool value}) {
    isRefres = value;
    update();
  }

  String selectedTitle = '';
  void setSelectedTitle(String value) {
    selectedTitle = value;
    log('subCate=>$selectedTitle');
    update();
  }

  String catSlugFilter;
  setCatSlugFilter({String slugName}) {
    catSlugFilter = slugName;
    update();
  }

  RxInt listEmptyProduct = 0.obs;

  void setListEmptyProduct({int value}) {
    listEmptyProduct.value = value;
    update();
  }

  RxInt filterProduct = 0.obs;

  void setFilterProduct({int value}) {
    listEmptyProduct.value = value;
    update();
  }

  RxInt header = 0.obs;

  void setHeader({int value}) {
    header.value = value;
    update();
  }

  bool isHeaderCall = false;

  void setHeaderTagCall({bool value}) {
    isHeaderCall = value;
    update();
  }

  int _productCallBack;

  int get productCallBack => _productCallBack;

  set productCallBack(int value) {
    _productCallBack = value;
    update();
  }

  bool _filterCallBack = false;

  bool get filterCallBack => _filterCallBack;

  set filterCallBack(bool value) {
    _filterCallBack = value;
    update();
  }
}
