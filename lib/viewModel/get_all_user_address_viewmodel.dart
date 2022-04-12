import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_all_user_address_repo.dart';
import 'package:skoolmonk/model/responseModel/get_all_user_address.dart';

class GetAllUserAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getAllUserAddressViewModel() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      GetAllUserAddressResponse response =
          await GetAllUserAddressRepo().getAllUserAddressRepo();
      print('GetAllUserAddressViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetAllUserAddressViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
