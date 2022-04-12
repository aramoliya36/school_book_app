import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/pre_post_payment_repo.dart';
import 'package:skoolmonk/model/reqestModel/pre_payment_call_requestModel.dart';
import 'package:skoolmonk/model/responseModel/pre_payment_response_model.dart';

class PrePaymentViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> prePaymentViewModel({PrePaymentReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PrePaymentCallResponseModel response =
          await PrePostPayment().prePostPayment(model.toJson());
      print('PrePaymentViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....PrePaymentViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
