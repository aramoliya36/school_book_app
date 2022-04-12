import 'package:skoolmonk/model/responseModel/update_profile_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateProfileRepo extends BaseService {
  Future<dynamic> updateProfileRepo(Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
      url: updateProfileURL,
      body: body,
      apitype: APIType.aPost,
    );
    UpdateProfileResponse updateProfileResponse =
        UpdateProfileResponse.fromJson(response);
    return updateProfileResponse;
  }
}
