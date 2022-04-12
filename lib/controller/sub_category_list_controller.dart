import 'package:get/get.dart';

class SubCategoryListController extends GetxController {
  String productUniqId;
  setProductUniqId({String value}) {
    productUniqId = value;
    update();
  }
}
