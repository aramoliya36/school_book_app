import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/cart_repo.dart';
import 'package:skoolmonk/model/responseModel/cart_response_model.dart';

class CartViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> cartViewModel({bool isLoading = true, String applyCode}) async {
    if (isLoading) {
      _apiResponse = ApiResponse.loading(message: 'Loading');
      update();
    }
    update();
    try {
      CartResponse response = await CartRepo().cartRepo(applyCode: applyCode);
      print('CartViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("...CartViewModel......>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  bool _checkoutPro = false;

  bool get checkoutPro => _checkoutPro;

  set checkoutPro(bool value) {
    _checkoutPro = value;
    update();
  }
}
