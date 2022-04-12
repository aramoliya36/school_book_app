import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/update_mobile_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_mobile_req_model.dart';
import 'package:skoolmonk/model/responseModel/update_mobile_responce_model.dart';

class UpdateMobileViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateMobile(UpdateMobileNoReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateMobileNoResponce response =
          await UpdateMobileRepo().updateMobileRepo(model.toJson());
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
