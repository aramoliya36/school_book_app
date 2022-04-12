import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';

import 'package:skoolmonk/model/responseModel/single_address_save_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class SingleAllUserAddressRepo extends BaseService {
  Future<SingleAllUserAddressResponse> singleAllUserAddressRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    //String userId = '11';
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url =
        getAllUserAddressURL + clientKey + '/' + deviceType + '/' + userId;
    log('---------------url SingleAllUserAddressRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    SingleAllUserAddressResponse singleAllUserAddressResponse =
        SingleAllUserAddressResponse.fromJson(response);

    return singleAllUserAddressResponse;
  }
}
