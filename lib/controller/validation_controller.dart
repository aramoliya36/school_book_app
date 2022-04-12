import 'package:get/get.dart';

class ValidationController extends GetxController {
  RxBool forgotPasswordFlag = false.obs;
  RxInt forgotPasswordPageIndex = 0.obs;
  RxBool progressVisible = false.obs;
  RxBool termCondition = false.obs;
  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;
  RxBool loginPasswordObscure = true.obs;
  RxBool passwordObscure = true.obs;
  RxBool confirmPasswordObscure = true.obs;
  void updateWidget() {
    update();
  }

  void chnageTC() {
    print("Controllar call");
    termCondition = termCondition.toggle();
    update();
  }

  void toggleText() {
    obscureText = obscureText.toggle();
    update();
  }

  void loginPasswordToggle() {
    loginPasswordObscure = loginPasswordObscure.toggle();
    update();
  }

  void passwordToggle() {
    passwordObscure = passwordObscure.toggle();
    update();
  }

  void confirmPasswordToggle() {
    confirmPasswordObscure = confirmPasswordObscure.toggle();
    update();
  }
}
