import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/all_school_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class AllSchoolRepo extends BaseService {
  Future<dynamic> allSchoolRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();

    var url = allSchoolMURL + clientKey + '/' + deviceType + '/' + userId;
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    AllSchoolResponse allSchoolResponse = AllSchoolResponse.fromJson(response);

    return allSchoolResponse;
  }
}
