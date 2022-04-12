import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/update_address_repo.dart';
import 'package:skoolmonk/model/reqestModel/update_address_reqmodel.dart';
import 'package:skoolmonk/model/responseModel/update_address_response.dart';

class UpdateAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateAddressViewModel({UpdateAddressReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateAddressResponse response =
          await UpdateAddressRepo().updateAddressRepo(model.toJson());
      print('UpdateAddressViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....UpdateAddressViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
