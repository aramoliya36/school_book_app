import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/all_category_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class AllCategoryRepo extends BaseService {
  Future<dynamic> allCategoryRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = allCategoryURL + clientKey + '/' + deviceType + '/' + userId;
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    AllCategoryResponse allCategoryResponse =
        AllCategoryResponse.fromJson(response);

    return allCategoryResponse;
  }
}
