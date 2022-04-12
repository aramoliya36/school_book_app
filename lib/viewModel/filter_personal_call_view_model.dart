import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/filter_personal_call.dart';

import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/filter_personal_call_response_model.dart';

class FilterPersonalCallBottomViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> filterPersonalCallBottomViewModel(
      {MainCategoriesSubcategoriesProductFilterRequest model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      FilterPerosonalCallRespons response = await FilterPersonalCallBottomRepo()
          .filterPersonalCallBottomRepo(model.toJson());

      print('trsp=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("......FilterPersonalCallBottomViewModel...>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
