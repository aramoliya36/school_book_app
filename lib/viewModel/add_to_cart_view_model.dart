import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/add_to_cart_repo.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/add_to_cart_response_model.dart';

class AddToCartViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> addToCartViewModel({AddToCartReq model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddToCartResponse response =
          await AddToCartRepo().addToCartRepo(model.toJson());
      print('trsp===AddToCartViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....AddToCartViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
