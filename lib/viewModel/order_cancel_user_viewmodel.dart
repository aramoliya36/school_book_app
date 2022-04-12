import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/order_cancel_user_repo.dart';
import 'package:skoolmonk/model/reqestModel/order_cancel_user_req.dart';
import 'package:skoolmonk/model/responseModel/order_cancel_user_response_model.dart';

class OrderCancelUserViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> orderCancelUserViewModel(OrderCancelUserReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      OrderCancelByResponse response =
          await OrderCancelUserRepo().orderCancelUserRepo(model.toJson());
      print('trsp OrderCancelUserViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("..OrderCancelUserViewModel.......>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
