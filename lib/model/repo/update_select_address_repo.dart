import 'package:skoolmonk/model/responseModel/update_select_address_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateSelectAddressRepo extends BaseService {
  Future<UpdateSelectAddressResponse> updateSelectAddressRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: updateSelectAddressAddressURL, body: body, apitype: APIType.aPost);
    UpdateSelectAddressResponse updateSelectAddressResponse =
        UpdateSelectAddressResponse.fromJson(response);
    print('----------UpdateSelectAddressRepo---------$response');
    return updateSelectAddressResponse;
  }
}
