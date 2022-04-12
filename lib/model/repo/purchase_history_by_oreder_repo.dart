import 'dart:developer';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_by_order_responsemodel.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class PurchaseHistoryByOrderRepo extends BaseService {
  Future<PurchaseHistoryByOrderResponse> purchaseHistoryByOrderRepo(
      {String orderNumber}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = purchaseHistoryByOrderURL + userId + '/' + orderNumber;
    log('---------------url PurchaseHistoryByOrderRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    PurchaseHistoryByOrderResponse purchaseHistoryByOrderResponse =
        PurchaseHistoryByOrderResponse.fromJson(response);

    return purchaseHistoryByOrderResponse;
  }
}
