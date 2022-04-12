import 'package:skoolmonk/model/responseModel/login_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class LoginRepo extends BaseService {
  Future<dynamic> login(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: loginURL, body: body, apitype: APIType.aPost);
    LoginResponce loginResponce = LoginResponce.fromJson(response);
    return loginResponce;
  }
}
