import 'dart:developer';

import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/responseModel/product_detail_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class ProductDetailRepo extends BaseService {
  Future<dynamic> productDetailRepo({String slugName}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    String userId = PreferenceManager.getTokenId() == null
        ? "0"
        : PreferenceManager.getTokenId();
    var url = getProductDetailURL +
        clientKey +
        '/' +
        deviceType +
        '/' +
        userId +
        '/' +
        slugName;
    log('---------------url productdetails----------${url}');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    ProductDetailResponse productDetailResponse =
        ProductDetailResponse.fromJson(response);

    return productDetailResponse;
  }
}
