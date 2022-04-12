import 'package:get/get_state_manager/get_state_manager.dart';

class CartAndWishCountController extends GetxController {
  int cartCount;

  ///Cart Count

  setCartCountResponse({int value}) {
    cartCount = value;
    update();
  }

  ///wish list coun
  int wishListCount;
  setWishCountResponse({int value}) {
    wishListCount = value;
    update();
  }
}
