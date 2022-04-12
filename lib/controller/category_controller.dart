import 'dart:developer';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxString _selectedTitle = ''.obs;
  String mainCategoryIndex;
  String cateGorySlug;
  RxString get selectedTitle => _selectedTitle;
  categorySlug({String categorySlugName}) {
    cateGorySlug = categorySlugName;
    update();
  }

  mainCategoryIndexFind({String findMainCategoryIndex}) {
    mainCategoryIndex = findMainCategoryIndex;
    update();
  }

  void setSelectedTitle(String value) {
    _selectedTitle = value.obs;
    log('category=>$_selectedTitle');
    update();
  }
}
