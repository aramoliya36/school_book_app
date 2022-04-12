import 'package:skoolmonk/model/responseModel/pre_payment_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class PrePostPayment extends BaseService {
  Future<PrePaymentCallResponseModel> prePostPayment(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: prePostPaymentURL, body: body, apitype: APIType.aPost);
    PrePaymentCallResponseModel paymentCallResponseModel =
        PrePaymentCallResponseModel.fromJson(response);
    print('----------AddAddressRepo---------$response');
    return paymentCallResponseModel;
  }
}
