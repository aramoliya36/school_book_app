import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/product_detail_repo.dart';
import 'package:skoolmonk/model/responseModel/product_detail_response_model.dart';

class ProductDetailViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> productDetailViewModel(
      {String slugName, bool isLoading = true}) async {
    if (isLoading) {
      _apiResponse = ApiResponse.loading(message: 'Loading');
      update();
    }
    try {
      ProductDetailResponse response =
          await ProductDetailRepo().productDetailRepo(slugName: slugName);
      // await ProductDetailRepo()
      //     .productDetailRepo(slugName: 'variation-product-check');
      print('ProductDetailViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....ProductDetailViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// Variation dropDw
  String dropdownValue;

  setDropdownValue(String value) {
    dropdownValue = value;
    update();
  }

  String dropdownValue1;

  setDropdownValue1(String value) {
    dropdownValue1 = value;
    update();
  }

  List sendListVariationInfo2 = [];
  setListVariationInfo2({Map info2Value}) {
    sendListVariationInfo2.add(info2Value);
    update();
  }
}
