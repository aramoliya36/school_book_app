import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_order_return_replace_options_repo.dart';
import 'package:skoolmonk/model/responseModel/get_oredrr_return_option_responsemodel.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_by_order_responsemodel.dart';

class GetOrderReturnOptionViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getOrderReturnOptionViewModel({String returnReplaceType}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      GetOrderReturnReplaceResponse response = await GetOrderReturnReplaceRepo()
          .getOrderReturnReplaceRepo(returnReplaceType: returnReplaceType);
      print('GetOrderReturnOptionViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetOrderReturnOptionViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  OrderDetail returnReplaceSinglePro;
  setReturnReplaceSin({OrderDetail value}) {
    returnReplaceSinglePro = value;
    update();
  }

  List<Asset> images = List<Asset>();
  setImagePi({List<Asset> value}) {
    images = value;
    update();
  }

  String _error = 'No Error Dectected';

  List<ProductRe> returnReplaceListOfComplete;
  setReturnReplaceListOfComplete({List<ProductRe> value}) {
    returnReplaceListOfComplete = value;
    update();
  }

  bool _modelProgress = false;

  bool get modelProgress => _modelProgress;

  set modelProgress(bool value) {
    _modelProgress = value;
    update();
  }
}
