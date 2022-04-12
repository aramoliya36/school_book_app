import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/single_save_address.dart';
import 'package:skoolmonk/model/responseModel/single_address_save_response.dart';

class SingleAllUserAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> singleAllUserAddressViewModel() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      SingleAllUserAddressResponse response =
          await SingleAllUserAddressRepo().singleAllUserAddressRepo();
      print('SingleAllUserAddressViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....SingleAllUserAddressViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
