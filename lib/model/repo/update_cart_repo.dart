import 'package:skoolmonk/model/responseModel/update_cart_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class UpdateCartRepo extends BaseService {
  Future<dynamic> updateCartRepo(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: updateCartURL, body: body, apitype: APIType.aPost);
    UpdateCartRespons updateCartRespons = UpdateCartRespons.fromJson(response);
    return updateCartRespons;
  }
}
