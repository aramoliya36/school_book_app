import 'package:get/get.dart';

class WishListController extends GetxController {
  String productUniqId;
  setProductUniqId({String value}) {
    productUniqId = value;
    update();
  }
}
