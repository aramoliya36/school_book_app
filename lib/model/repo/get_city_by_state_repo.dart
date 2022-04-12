import 'package:skoolmonk/model/responseModel/get_city_by_state.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class GetCityByStateRepo extends BaseService {
  Future<GetCityByCountryResponse> getCityByStateRepo({String stateId}) async {
    String clientKey = "1595922666X5f1fd8bb5f662";
    String deviceType = "MOB";

    var url = getCityByStateURL + clientKey + '/' + deviceType + '/' + stateId;
    // log('---------------url GetCityByStateRepo----------$url');
    var response =
        await APIService().getResponse(apitype: APIType.aGet, url: url);
    GetCityByCountryResponse getCityByCountryResponse =
        GetCityByCountryResponse.fromJson(response);

    return getCityByCountryResponse;
  }
}
