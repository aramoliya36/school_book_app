import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/OTPVerify_repo.dart';
import 'package:skoolmonk/model/reqestModel/otpVerify_req_model.dart';
import 'package:skoolmonk/model/responseModel/otpVerify_responce_model.dart';

class OTPVerifyViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> otpVerify(OTPVerifyReq model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      OtpVerifyResponce response =
          await OTPVerifyRepo().otpVerify(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
