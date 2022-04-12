import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/MainCategoriesSubcategoriesProductFilter_repo.dart';

import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';

class MainCategoriesSubcategoriesProductFilterViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;
  updateSet() {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
  }

  Future<void> mainCategoriesSubcategoriesProductFilterViewModel(
      {MainCategoriesSubcategoriesProductFilterRequest model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();

    // update();
    try {
      MainCategoriesSubcategoriesProductFilterResponse response =
          await MainCategoriesSubcategoriesProductFilterRepo()
              .mainCategoriesSubcategoriesProductFilterRepo(model.toJson());

      print('trsp=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("......MainCategoriesSubcategoriesProductFilterViewModel...>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  bool _isEmpty = true;

  bool get isEmpty => _isEmpty;

  set isEmpty(bool value) {
    _isEmpty = value;
    update();
  }
}
