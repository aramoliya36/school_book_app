import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/getuser_detail_repo.dart';
import 'package:skoolmonk/model/responseModel/get_user_detail_responce_model.dart';

class GetProfileViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getProfile() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetUserDetailResponce response =
          await GetUserDetailRepo().getUserDetail();
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
