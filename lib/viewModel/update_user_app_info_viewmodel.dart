import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/update_user_app_info_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_app_info_reqestmodel.dart';
import 'package:skoolmonk/model/responseModel/update_user_app_info_response_model.dart';

class UpdateUserAppInfoViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateUserAppInfoViewModel(
      {UpdateAppInfoRequestModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateUserAppInfoResponse response =
          await UpdateUserAppInfoRepo().updateUserAppInfoRepo(model.toJson());
      print('UpdateUserAppInfoViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....UpdateUserAppInfoViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
