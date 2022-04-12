import 'package:skoolmonk/model/responseModel/post_wishlist_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class PostProductWishRepo extends BaseService {
  Future<dynamic> postProductWishRepo(Map<String, dynamic> body) async {
    var response = await APIService()
        .getResponse(url: postWishListURL, body: body, apitype: APIType.aPost);
    PostWishListResponse postWishListResponse =
        PostWishListResponse.fromJson(response);
    return postWishListResponse;
  }
}
