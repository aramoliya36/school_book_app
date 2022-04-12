import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/reset_password_repo.dart';
import 'package:skoolmonk/model/reqestModel/reset_password_req_model.dart';
import 'package:skoolmonk/model/responseModel/reset_passsword_responce_model.dart';

class ResetPasswordViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> resetPassword(ResetPasswordReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      ResetPasswordResponce response =
          await ResetPasswordRepo().resetPasswordRepo(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
