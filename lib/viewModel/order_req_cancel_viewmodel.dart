import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/order_eq_cancel_user_repo.dart';
import 'package:skoolmonk/model/reqestModel/order_req_cancel_user_req.dart';
import 'package:skoolmonk/model/responseModel/order_req_cancel_user_response_model.dart';

class OrderReqCancelUserViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> orderReqCancelUserViewModel(
      OrderReqCancelUserReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      OrderReqCancelByResponse response =
          await OrderReqCancelUserRepo().orderReqCancelUserRepo(model.toJson());
      print('trsp OrderReqCancelUserViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("..OrderReqCancelUserViewModel.......>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
