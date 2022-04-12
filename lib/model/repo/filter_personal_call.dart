import 'package:skoolmonk/model/responseModel/filter_personal_call_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class FilterPersonalCallBottomRepo extends BaseService {
  Future<dynamic> filterPersonalCallBottomRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: mainCategoriesSubcategoriesProductFilterURL,
        body: body,
        apitype: APIType.aPost);
    print(
        "========FilterPersonalCallBottomRepo================== url=$mainCategoriesSubcategoriesProductFilterURL");

    FilterPerosonalCallRespons filterPersonalCallResponse =
        FilterPerosonalCallRespons.fromJson(response);
    return filterPersonalCallResponse;
  }
}
