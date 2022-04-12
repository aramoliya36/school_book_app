import 'package:skoolmonk/model/responseModel/order_req_cancel_user_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class OrderReqCancelUserRepo extends BaseService {
  Future<OrderReqCancelByResponse> orderReqCancelUserRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: orderReqCancelURL, body: body, apitype: APIType.aPost);
    OrderReqCancelByResponse orderReqCancelByResponse =
        OrderReqCancelByResponse.fromJson(response);
    print('----------OrderReqCancelUserRepo---------$response');
    return orderReqCancelByResponse;
  }
}
