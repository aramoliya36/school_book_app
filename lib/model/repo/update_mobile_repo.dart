import 'package:skoolmonk/model/responseModel/update_mobile_responce_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateMobileRepo extends BaseService {
  Future<dynamic> updateMobileRepo(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: updateMobileNoURL, body: body, apitype: APIType.aPost);
    UpdateMobileNoResponce updateMobileNoResponce =
        UpdateMobileNoResponce.fromJson(response);
    return updateMobileNoResponce;
  }
}
