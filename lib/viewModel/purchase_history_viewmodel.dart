import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/purchase_history_repo.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_responsemodel.dart';

class PurchaseHistoryViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> purchaseHistoryViewModel({String orderType}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PurchaseHistoryResponse response =
          await PurchaseHistoryRepo().purchaseHistoryRepo(orderType: orderType);
      print('PurchaseHistoryViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....PurchaseHistoryViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
