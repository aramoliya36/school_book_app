import 'package:skoolmonk/model/responseModel/payment.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class PaymentFinalRepo extends BaseService {
  Future<PaymentSuccessResponseModel> paymentFinalRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: paymentSuccessURL, body: body, apitype: APIType.aPost);
    PaymentSuccessResponseModel paymentSuccessResponseModel =
        PaymentSuccessResponseModel.fromJson(response);
    print('----------PaymentFinalRepo---------$response');
    return paymentSuccessResponseModel;
  }
}
