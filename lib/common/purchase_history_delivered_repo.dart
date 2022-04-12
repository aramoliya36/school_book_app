import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_delivered_responsemodel.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class PurchaseHistoryDeliveredRepo extends BaseService {
  Future<PurchaseHistoryDeliveredResponse> purchaseHistoryDeliveredRepo(
      {String orderType}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = purchaseHistoryURL + orderType + '/' + userId;
    log('---------------url PurchaseHistoryDeliveredRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    PurchaseHistoryDeliveredResponse purchaseHistoryDeliveredResponse =
        PurchaseHistoryDeliveredResponse.fromJson(response);

    return purchaseHistoryDeliveredResponse;
  }
}
