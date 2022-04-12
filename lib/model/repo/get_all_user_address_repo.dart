import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/get_all_user_address.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetAllUserAddressRepo extends BaseService {
  Future<GetAllUserAddressResponse> getAllUserAddressRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    //String userId = '11';
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url =
        getAllUserAddressURL + clientKey + '/' + deviceType + '/' + userId;
    log('---------------url GetAllUserAddressRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetAllUserAddressResponse getAllUserAddressResponse =
        GetAllUserAddressResponse.fromJson(response);

    return getAllUserAddressResponse;
  }
}
