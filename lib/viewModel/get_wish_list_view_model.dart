import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_wish_list_repo.dart';
import 'package:skoolmonk/model/responseModel/get_wish_list_response_model.dart';

class GetWishListViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getWishListViewModel() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetWishListResponseModel response =
          await GetWishListRepo().getWishListRepo();
      print("....GetWishListViewModel...try..>$response");

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetWishListViewModel...catch...>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
