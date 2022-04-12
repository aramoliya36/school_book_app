import 'package:get/get.dart';

class ColorController extends GetxController {
  RxInt _colorChange = 10.obs;

  RxInt get colorChange => _colorChange;
}
