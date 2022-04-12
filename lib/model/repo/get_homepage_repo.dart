import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetHomePageRepo extends BaseService {
  Future<GetHomePageResponse> getHomePageRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = getHomePage + clientKey + '/' + deviceType + '/' + userId;
    log('---------------url GetHomePageRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetHomePageResponse getHomePageResponse =
        GetHomePageResponse.fromJson(response);

    return getHomePageResponse;
  }
}
