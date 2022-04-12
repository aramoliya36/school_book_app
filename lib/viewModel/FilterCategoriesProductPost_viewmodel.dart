import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/filter_categories_product_post_repo.dart';

import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/model/responseModel/filter_categories_product_post_response_model.dart';

class FilterCategoriesProductPostViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> filterCategoriesProductPostViewModel(
      {MainCategoriesSubcategoriesProductFilterRequest model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      MainCategoriesSubcategoriesProductFilterResponse response =
          await FilterCategoriesProductPostRepo()
              .filterCategoriesProductPostRepo(model.toJson());

      print('trsp=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("......FilterCategoriesProductPostViewModel...>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  String productUniqId;
  setProductUniqId({String value}) {
    productUniqId = value;

    update();
  }
}
