import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/forgot_password_repo.dart';
import 'package:skoolmonk/model/reqestModel/forgot_password_req_model.dart';
import 'package:skoolmonk/model/responseModel/forgot_password_responce_model.dart';

class ForgotPasswordViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> forgotPassword(ForgotPasswordReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      ForgotPasswordResponce response =
          await ForgotPasswordRepo().forgotPasswordRepo(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
