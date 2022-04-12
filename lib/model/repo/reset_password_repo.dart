
import 'package:skoolmonk/model/responseModel/reset_passsword_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class ResetPasswordRepo extends BaseService {
  Future<dynamic> resetPasswordRepo(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: resetpasswordURl, body: body, apitype: APIType.aPost);
    ResetPasswordResponce resetPasswordResponce = ResetPasswordResponce.fromJson(response);
    return resetPasswordResponce;
  }
}
