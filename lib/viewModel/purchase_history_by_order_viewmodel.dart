import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/purchase_history_by_oreder_repo.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_by_order_responsemodel.dart';

class PurchaseHistoryByOrderViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> purchaseHistoryByOrderViewModel({String orderNumber}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PurchaseHistoryByOrderResponse response =
          await PurchaseHistoryByOrderRepo()
              .purchaseHistoryByOrderRepo(orderNumber: orderNumber);
      print('PurchaseHistoryByOrderViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....PurchaseHistoryByOrderViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  RxString orderNumber = ''.obs;

  /// currentTrack
  // bool _currentTrack = true;
  String subOrderNumber;
  // bool get currentTrack => _currentTrack;
  ///track show
  RxMap<String, bool> filterMapList = <String, bool>{}.obs;

  void addFilterMap({String key, bool value}) {
    if (filterMapList.containsKey(key)) {
      if (filterMapList[key] == true) {
        filterMapList[key] = false;
      } else {
        filterMapList[key] = true;
      }
    }
    update();
  }

  /// sub order drop
  RxMap<String, bool> subOrderDrop = <String, bool>{}.obs;

  void addSubOrderDrop({String key, bool value}) {
    if (subOrderDrop.containsKey(key)) {
      if (subOrderDrop[key] == true) {
        subOrderDrop[key] = false;
      } else {
        subOrderDrop[key] = true;
      }
    }
    update();
  }

  ///
  setCurrentTrack({String subOrderNumber1}) {
    //_currentTrack = !_currentTrack;
    subOrderNumber = subOrderNumber1;
    print('--------subOrderNumber-------$subOrderNumber');
    update();
  }

  /// cancel track
  bool _cancelTrack = true;

  bool get cancelTrack => _cancelTrack;

  setCancelTrack() {
    _cancelTrack = !_cancelTrack;
    update();
  }
}
