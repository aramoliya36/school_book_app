import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/model/responseModel/filter_categories_product_post_response_model.dart';
import 'package:skoolmonk/model/responseModel/forgot_password_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class FilterCategoriesProductPostRepo extends BaseService {
  Future<MainCategoriesSubcategoriesProductFilterResponse>
      filterCategoriesProductPostRepo(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: filterCategoriesProductPostSuccessURL,
        body: body,
        apitype: APIType.aPost);
    MainCategoriesSubcategoriesProductFilterResponse
        filterCategoriesProductPostResponse =
        MainCategoriesSubcategoriesProductFilterResponse.fromJson(response);
    return filterCategoriesProductPostResponse;
  }
}
