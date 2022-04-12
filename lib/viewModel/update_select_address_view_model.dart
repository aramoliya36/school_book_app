import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/update_select_address_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_select_req.dart';
import 'package:skoolmonk/model/responseModel/update_select_address_response.dart';

class UpdateSelectAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateSelectAddressViewModel(
      {UpdateSelectAddressReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateSelectAddressResponse response = await UpdateSelectAddressRepo()
          .updateSelectAddressRepo(model.toJson());
      print('UpdateSelectAddressViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....UpdateSelectAddressViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
