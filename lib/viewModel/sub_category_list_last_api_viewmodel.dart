import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/MainCategoriesSubcategoriesProductFilter_repo.dart';
import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';

class SubCategoryListLastViewModelController extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future subCategoryListLastViewModelController(
      {MainCategoriesSubcategoriesProductFilterRequest model,
      bool isLoading = true}) async {
    if (isLoading) {
      _apiResponse = ApiResponse.loading(message: 'Loading');
      update();
    }
    try {
      MainCategoriesSubcategoriesProductFilterResponse response =
          await MainCategoriesSubcategoriesProductFilterRepo()
              .mainCategoriesSubcategoriesProductFilterRepo(model.toJson());

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  int _pageIndex;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    update();
  }

  bool _isAddRightNow = false;

  bool get isAddRightNow => _isAddRightNow;

  set isAddRightNow(bool value) {
    _isAddRightNow = value;
    update();
  }
}
