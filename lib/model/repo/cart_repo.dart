import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/cart_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class CartRepo extends BaseService {
  Future<dynamic> cartRepo({String applyCode}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    String applyCode1 = applyCode != null ? applyCode : '';
    var url = cartURL + clientKey + '/' + deviceType + '/' + userId;
    var urlApply = cartURL +
        clientKey +
        '/' +
        deviceType +
        '/' +
        userId +
        '/0/' +
        applyCode1;
    // log('---------------url CartRepo----------$url');
    // log('---------------url applyCode----------${applyCode1 != null ? urlApply : url}');
    var response = await APIService().getResponse(
        apitype: APIType.aGet, url: applyCode1 != null ? urlApply : url);
    CartResponse cartResponse = CartResponse.fromJson(response);

    return cartResponse;
  }
}
