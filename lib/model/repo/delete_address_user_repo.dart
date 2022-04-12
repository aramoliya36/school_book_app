import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';
import 'package:skoolmonk/model/responseModel/delete_address_response.dart';

class DeleteAddressRepo extends BaseService {
  Future<DeleteUserAddressResponse> deleteAddressRepo(
      Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: DeleteAddressURL, body: body, apitype: APIType.aPost);
    DeleteUserAddressResponse deleteUserAddressResponse =
        DeleteUserAddressResponse.fromJson(response);
    return deleteUserAddressResponse;
  }
}
