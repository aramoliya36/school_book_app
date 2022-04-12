import 'package:skoolmonk/model/responseModel/signup_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';
import 'dart:developer' as dev;

class RegisterRepo extends BaseService {
  Future<SignUpResponce> register(Map<String, dynamic> body) async {
    dev.log("$registerURL");
    var response = await APIService()
        .getResponse(url: registerURL, body: body, apitype: APIType.aPost);

    SignUpResponce signUpResponce = SignUpResponce.fromJson(response);
    print(signUpResponce);
    return signUpResponce;
  }
}
