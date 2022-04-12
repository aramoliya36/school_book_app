import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool _isLogin = false.obs;

  RxBool get isLogin => _isLogin;

  void setLogin(bool value) {
    _isLogin = value.obs;
    update();
  }
}
