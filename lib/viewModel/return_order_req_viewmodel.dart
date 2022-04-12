import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/order_return_req_repo.dart';
import 'package:skoolmonk/model/reqestModel/return_order_req_model.dart';
import 'package:skoolmonk/model/responseModel/order_return_req_responsemodel.dart';

class ReturnOrderReqViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> returnOrderReqViewModel(
      {ReturnOrderReqModel model, String typeReturnReplace}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      OrderReturnReqResponse response = await OrderReturnRepo().orderReturnRepo(
          body: model.toJson(), typeReturnReplace: typeReturnReplace);
      print('trsp=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
