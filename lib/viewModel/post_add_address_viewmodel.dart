import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/add_address_repo.dart';
import 'package:skoolmonk/model/reqestModel/post_add_address_reqest.dart';
import 'package:skoolmonk/model/responseModel/post_add_address_response_model.dart';

class AddAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> addAddressViewModel({AddAddressReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddAddressResponse response =
          await AddAddressRepo().addAddressRepo(model.toJson());
      print('AddAddressViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....AddAddressViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
