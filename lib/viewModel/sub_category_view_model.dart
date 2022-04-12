import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/subcategories_repo.dart';

class SubCategoryViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> subCategory({String categoryId, String categorySlug}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      dynamic response = await SubCategories().subCategoriesGetDetails(
          categoryId: categoryId, categorySlug: categorySlug);
      print('sub_category response=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
