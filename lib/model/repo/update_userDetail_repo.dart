import 'package:skoolmonk/model/responseModel/update_userdetail_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateUserDetailRepo extends BaseService {
  Future<dynamic> updateUserDetail(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: updateUserDetailURL, body: body, apitype: APIType.aPost);
    UpdateUserDetailResponce updateUserDetailResponce =
        UpdateUserDetailResponce.fromJson(response);
    return updateUserDetailResponce;
  }
}
