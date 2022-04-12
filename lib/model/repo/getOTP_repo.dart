
import 'package:skoolmonk/model/responseModel/getotp_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetOTPRepo extends BaseService {
  Future<dynamic> getOTP(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: getOTPURL, body: body, apitype: APIType.aPost);
    GetOtpResponce getOtpResponce = GetOtpResponce.fromJson(response);
    return getOtpResponce;
  }
}
