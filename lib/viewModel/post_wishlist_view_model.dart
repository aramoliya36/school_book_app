import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/product_in__user_wishlist_repo.dart';

import 'package:skoolmonk/model/reqestModel/post_wishlist_req_model.dart';
import 'package:skoolmonk/model/responseModel/post_wishlist_response_model.dart';

class PostWishListViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> postWishListViewModel({PostWishListReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      PostWishListResponse response =
          await PostProductWishRepo().postProductWishRepo(model.toJson());
      print('PostWishListViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....PostWishListViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
