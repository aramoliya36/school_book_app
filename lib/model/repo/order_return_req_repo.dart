import 'package:skoolmonk/model/responseModel/order_return_req_responsemodel.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class OrderReturnRepo extends BaseService {
  Future<OrderReturnReqResponse> orderReturnRepo(
      {Map<String, dynamic> body, String typeReturnReplace}) async {
    var response = await APIService().getResponse(
        url: typeReturnReplace == '1' ? orderReturnReqURL : orderREPLACEReqURL,
        body: body,
        apitype: APIType.aPost);
    OrderReturnReqResponse orderReturnReqResponse =
        OrderReturnReqResponse.fromJson(response);
    print('----------OrderReturnRepo---------$response');
    return orderReturnReqResponse;
  }
}
