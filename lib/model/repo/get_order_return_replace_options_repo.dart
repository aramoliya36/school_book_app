import 'dart:developer';
import 'package:skoolmonk/model/responseModel/get_oredrr_return_option_responsemodel.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetOrderReturnReplaceRepo extends BaseService {
  Future<GetOrderReturnReplaceResponse> getOrderReturnReplaceRepo(
      {String returnReplaceType}) async {
    var url = getOrderReturnReplaceURL + returnReplaceType;
    log('---------------url GetOrderReturnReplaceRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetOrderReturnReplaceResponse getOrderReturnReplaceResponse =
        GetOrderReturnReplaceResponse.fromJson(response);

    return getOrderReturnReplaceResponse;
  }
}
