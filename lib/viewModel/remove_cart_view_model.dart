import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/remove_cart_repo.dart';
import 'package:skoolmonk/model/reqestModel/remove_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/remove_cart_response.dart';

class RemoveCartViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> removeCartViewModel({RemoveReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RemoveCartResponse response =
          await RemoveCartRepo().removeCartRepo(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....RemoveCartViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
