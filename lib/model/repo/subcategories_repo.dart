import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/sub_category_header_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class SubCategories extends BaseService {
  Future<dynamic> subCategoriesGetDetails(
      {String categoryId, String categorySlug}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();

    var url = allSubCategoryURL +
        clientKey +
        '/' +
        deviceType +
        '/' +
        userId +
        '/' +
        categorySlug;
    print("==========================subCategories url=${url}");
    var response =
        await APIService().getResponse(url: url, apitype: APIType.aGet);
    SubCategoryHeaderResponse subCategoryHeaderResponse =
        SubCategoryHeaderResponse.fromJson(response);
    return subCategoryHeaderResponse;
  }
}
