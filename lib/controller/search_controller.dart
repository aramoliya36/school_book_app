import 'package:get/get.dart';

class SearchController extends GetxController {
  RxString _searchProduct = ''.obs;

  RxString get searchProduct => _searchProduct;

  void setSearchProduct(String value) {
    _searchProduct = value.obs;
    update();
  }
}
