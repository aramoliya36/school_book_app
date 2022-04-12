import 'package:skoolmonk/model/responseModel/remove_cart_response.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class RemoveCartRepo extends BaseService {
  Future<dynamic> removeCartRepo(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: removeCartURL, body: body, apitype: APIType.aPost);
    RemoveCartResponse removeCartResponse =
        RemoveCartResponse.fromJson(response);
    return removeCartResponse;
  }
}
