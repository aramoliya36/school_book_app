import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/update_userDetail_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_user_detail_req_model.dart';
import 'package:skoolmonk/model/responseModel/update_userdetail_responce_model.dart';

class UpdateUserDetailViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateUserDetail(UpdateUserDetailReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateUserDetailResponce response =
          await UpdateUserDetailRepo().updateUserDetail(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
