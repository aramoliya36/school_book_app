import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/delete_address_user_repo.dart';
import 'package:skoolmonk/model/reqestModel/delete_address_reqest.dart';
import 'package:skoolmonk/model/responseModel/delete_address_response.dart';

class DeleteAddressViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> deleteAddressViewModel({DeleteAddressReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      DeleteUserAddressResponse response =
          await DeleteAddressRepo().deleteAddressRepo(model.toJson());
      print('trsp=========DeleteAddressViewModel=====>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....DeleteAddressViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
