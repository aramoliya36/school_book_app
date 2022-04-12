import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/getOTP_repo.dart';
import 'package:skoolmonk/model/reqestModel/getotp_req_model.dart';
import 'package:skoolmonk/model/responseModel/getotp_responce_model.dart';

class GetOTPViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getOtp(GetOTPReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetOtpResponce response = await GetOTPRepo().getOTP(model.toJson());
      print('trsp==GetOTPViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
