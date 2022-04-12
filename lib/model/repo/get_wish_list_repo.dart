import 'dart:developer';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/adress_controller.dart';
import 'package:skoolmonk/model/responseModel/get_wish_list_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetWishListRepo extends BaseService {
  AddressId _addressId = AddressId();
  Future<GetWishListResponseModel> getWishListRepo({String slugName}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = getWishListURL + clientKey + '/' + deviceType + '/' + userId;
    log('---------------url GetWishListRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetWishListResponseModel getWishListResponseModel =
        GetWishListResponseModel.fromJson(response);

    return getWishListResponseModel;
  }
}
