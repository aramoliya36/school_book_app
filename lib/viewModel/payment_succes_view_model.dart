import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/payment_final_status_repo.dart';
import 'package:skoolmonk/model/reqestModel/payment_req_model.dart';
import 'package:skoolmonk/model/responseModel/payment.dart';

class PaymentSuccessViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> paymentSuccessViewModel({PaymentSuccessReq model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PaymentSuccessResponseModel response =
          await PaymentFinalRepo().paymentFinalRepo(model.toJson());
      print('PaymentSuccessViewModel =>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("..PaymentSuccessViewModel.......>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
