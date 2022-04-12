import 'package:skoolmonk/model/responseModel/update_address_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateAddressRepo extends BaseService {
  Future<UpdateAddressResponse> updateAddressRepo(
      Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: updateAddressURL, body: body, apitype: APIType.aPost);
    UpdateAddressResponse updateAddressResponse =
        UpdateAddressResponse.fromJson(response);
    print('----------UpdateAddressRepo---------$response');
    return updateAddressResponse;
  }
}
