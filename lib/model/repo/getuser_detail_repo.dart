import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/get_user_detail_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetUserDetailRepo extends BaseService {
  Future<dynamic> getUserDetail() async {
    String userId = PreferenceManager.getTokenId();
    String url = getUserDetailURL + userId;
    var response =
        await APIService().getResponse(url: url, apitype: APIType.aGet);
    GetUserDetailResponce getUserDetailResponce =
        GetUserDetailResponce.fromJson(response);
    return getUserDetailResponce;
  }
}
