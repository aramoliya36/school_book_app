import 'package:skoolmonk/model/responseModel/otpVerify_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';


class OTPVerifyRepo extends BaseService {
  Future<dynamic> otpVerify(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: otpVerifyURL, body: body, apitype: APIType.aPost);
    OtpVerifyResponce otpVerifyResponce = OtpVerifyResponce.fromJson(response);
    return otpVerifyResponce;
  }
}
