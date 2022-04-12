import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/adress_controller.dart';
import 'package:skoolmonk/model/responseModel/get_address_user_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetUserAddressRepo extends BaseService {
  AddressId _addressId = AddressId();
  Future<UserAddressResponse> getUserAddressRepo({String slugName}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = getUserAddressURL + clientKey + '/' + deviceType + '/' + userId;
    log('---------------url GetUserAddressRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    UserAddressResponse _userAddressResponse =
        UserAddressResponse.fromJson(response);

    return _userAddressResponse;
  }
}
