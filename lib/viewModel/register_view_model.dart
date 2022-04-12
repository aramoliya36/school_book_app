import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/register_repo.dart';
import 'package:skoolmonk/model/reqestModel/signup_req_model.dart';
import 'package:skoolmonk/model/responseModel/signup_responce_model.dart';

class RegisterViewModel extends GetxController {
  RxString _dob = ''.obs;

  RxString get dob => _dob;

  void setDOB(String value) {
    _dob = value.obs;
    update();
  }

  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> signUp(SignUpReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SignUpResponce response = await RegisterRepo().register(model.toJson());
      _apiResponse = ApiResponse.complete(response);
      //  print(response);
    } catch (e) {
      print('error.....$e');
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
