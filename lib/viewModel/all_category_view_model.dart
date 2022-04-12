import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/all_category_repo.dart';
import 'package:skoolmonk/model/responseModel/all_category_response_model.dart';

class CategoryViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> allCategory() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AllCategoryResponse response = await AllCategoryRepo().allCategoryRepo();
      print('trsp==CategoryViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
