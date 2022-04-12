import 'package:skoolmonk/model/responseModel/add_to_cart_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class AddToCartRepo extends BaseService {
  Future<dynamic> addToCartRepo(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: addToCartURL, body: body, apitype: APIType.aPost);
    print('  addtocart----$response');
    AddToCartResponse addToCartResponse = AddToCartResponse.fromJson(response);
    return addToCartResponse;
  }
}
