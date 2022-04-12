import 'package:get/get.dart';
import 'package:skoolmonk/common/purchase_history_delivered_repo.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_delivered_responsemodel.dart';

class PurchaseHistoryDeliveredViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> purchaseHistoryDeliveredViewModel({String orderType}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PurchaseHistoryDeliveredResponse response =
          await PurchaseHistoryDeliveredRepo()
              .purchaseHistoryDeliveredRepo(orderType: orderType);
      print('PurchaseHistoryDeliveredViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....PurchaseHistoryDeliveredViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
