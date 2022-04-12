import 'dart:developer';

import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class MainCategoriesSubcategoriesProductFilterRepo extends BaseService {
  Future<dynamic> mainCategoriesSubcategoriesProductFilterRepo(
      Map<String, dynamic> body) async {
    print('========body========$body');
    var response = await APIService().getResponse(
        url: mainCategoriesSubcategoriesProductFilterURL,
        body: body,
        apitype: APIType.aPost);

    MainCategoriesSubcategoriesProductFilterResponse
        mainCategoriesSubcategoriesProductFilterResponse =
        MainCategoriesSubcategoriesProductFilterResponse.fromJson(response);
    return mainCategoriesSubcategoriesProductFilterResponse;
  }
}
