import 'package:skoolmonk/model/responseModel/post_add_address_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class AddAddressRepo extends BaseService {
  Future<dynamic> addAddressRepo(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: addAddressURL, body: body, apitype: APIType.aPost);
    AddAddressResponse addAddressResponse =
        AddAddressResponse.fromJson(response);
    print('----------AddAddressRepo---------$response');
    return addAddressResponse;
  }
}
