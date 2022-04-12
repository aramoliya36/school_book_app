import 'package:skoolmonk/model/responseModel/update_user_app_info_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateUserAppInfoRepo extends BaseService {
  Future<UpdateUserAppInfoResponse> updateUserAppInfoRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: updateUserAppInfoURL, body: body, apitype: APIType.aPost);
    UpdateUserAppInfoResponse updateSelectAddressResponse =
        UpdateUserAppInfoResponse.fromJson(response);
    print('----------UpdateUserAppInfoRepo---------$response');
    return updateSelectAddressResponse;
  }
}
