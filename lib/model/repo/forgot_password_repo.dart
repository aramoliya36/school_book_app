
import 'package:skoolmonk/model/responseModel/forgot_password_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class ForgotPasswordRepo extends BaseService {
  Future<dynamic> forgotPasswordRepo(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: forgotPasswordURL, body: body, apitype: APIType.aPost);
    ForgotPasswordResponce forgotPasswordResponce =
        ForgotPasswordResponce.fromJson(response);
    return forgotPasswordResponce;
  }
}
