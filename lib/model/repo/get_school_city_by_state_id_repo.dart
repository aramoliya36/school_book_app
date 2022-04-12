import 'package:skoolmonk/model/responseModel/get_country_by_state._responsemodel.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetStateByCountryRepo extends BaseService {
  Future<GetCountryByStateResponse> getStateByCountryRepo() async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";
    //String userId = '11';
    String countryId = '101';
    // String userId = PreferenceManager.getTokenId() == null
    //     ? "0"
    //     : PreferenceManager.getTokenId();
    var url =
        getStateByCountryURL + clientKey + '/' + deviceType + '/' + countryId;
    // log('---------------url GetStateByCountryRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetCountryByStateResponse getCountryByStateResponse =
        GetCountryByStateResponse.fromJson(response);

    return getCountryByStateResponse;
  }
}
