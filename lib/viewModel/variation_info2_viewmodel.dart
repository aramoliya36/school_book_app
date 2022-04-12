import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/vaiation_stock_info2_repo.dart';
import 'package:skoolmonk/model/reqestModel/variation_info2_req.dart';
import 'package:skoolmonk/model/responseModel/variation_Info2_response_model.dart';

class VariationInfo2ViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> variationInfo2ViewModel(VariationInfo2ReqModel model) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      VariationInfo2Response response = await VariationStockInfo2Repo()
          .variationStockInfo2Repo(model.toJson());
      print('trsp=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".VariationInfo2ViewModel...Error.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
