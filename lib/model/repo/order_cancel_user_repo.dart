import 'package:skoolmonk/model/responseModel/order_cancel_user_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class OrderCancelUserRepo extends BaseService {
  Future<OrderCancelByResponse> orderCancelUserRepo(
      Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: orderCancelURL, body: body, apitype: APIType.aPost);
    OrderCancelByResponse orderCancelByResponse =
        OrderCancelByResponse.fromJson(response);
    print('----------OrderCancelUserRepo---------$response');
    return orderCancelByResponse;
  }
}
