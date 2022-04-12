import 'package:get/get.dart';

class FavouriteController extends GetxController {
  RxBool isFav = false.obs;

  void isFavo() {
    isFav = isFav.toggle();
  }
}
