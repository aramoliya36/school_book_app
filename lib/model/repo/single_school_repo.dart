import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/single_school_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class SingleSchoolRepo extends BaseService {
  Future<dynamic> singleSchoolRepo({String schoolSlug}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();

    var url = singleSchoolURL +
        clientKey +
        '/' +
        deviceType +
        '/' +
        userId +
        '/' +
        schoolSlug;
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    SingleSchoolResponse singleSchoolResponse =
        SingleSchoolResponse.fromJson(response);

    return singleSchoolResponse;
  }
}
