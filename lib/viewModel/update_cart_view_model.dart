import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/update_cart_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/update_cart_response_model.dart';

class UpdateCartViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateCartViewModel({UpdateCartReq model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateCartRespons response =
          await UpdateCartRepo().updateCartRepo(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....UpdateCartViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
