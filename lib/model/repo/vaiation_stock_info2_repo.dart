import 'package:skoolmonk/model/responseModel/variation_Info2_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class VariationStockInfo2Repo extends BaseService {
  Future<VariationInfo2Response> variationStockInfo2Repo(
      Map<String, dynamic> body) async {
    print('------------------re--------$body');

    var response = await APIService().getResponse(
        url: variationInfo2URL, body: body, apitype: APIType.aPost);
    print('------------------re--------OK');

    VariationInfo2Response variationInfo2Response =
        VariationInfo2Response.fromJson(response);
    return variationInfo2Response;
  }
}
