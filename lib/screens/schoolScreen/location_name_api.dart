import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../model/services/api_service.dart';
import '../../model/services/base_service.dart';

/// get_school_countries
/// get_school_states_by_country_id
/// get_school_city_by_state_id
APIService apiService = APIService();

class LocationNameAPI extends BaseService {
  /// api for get country list....

  Map<String, String> header = {
    "Authorization": "${apiService.authorizationToken}",
    "Client-Service": "${apiService.clientServiceToken}",
    "Auth-Key": "${apiService.authKeyToken}",
    "Content-Type": "${apiService.contentTypeToken}",
  };
  Future getAllCountryName() async {
    String url = getSchoolCountries;
    // String url = "$kBaseURL/app/get_countries/1595922619X5f1fd8bb5f332/MOB";

    http.Response response = await http.get(Uri.parse(url), headers: header);
    return jsonDecode(response.body);
  }

  /// api to get state of selected country ...
  Future getAllStateOfCountry(int countryId) async {
    String url = "$getSchoolStatesByCountryId$countryId";
    log("URL GET ALL STATE $url");
    // String url =
    //     "$kBaseURL/app/get_states_by_country_id/1595922619X5f1fd8bb5f332/MOB/$countryId";

    http.Response response = await http.get(Uri.parse(url), headers: header);
    return jsonDecode(response.body);
  }

  /// api to get city of selected state ...
  Future getAllCityOfState(int stateId) async {
    String url = "$getSchoolCityByStateId$stateId";
    // "$kBaseURL/app/get_city_by_state_id/1595922619X5f1fd8bb5f332/MOB/$stateId";
    // get_school_states_by_country_id
    // get_school_city_by_state_id

    http.Response response = await http.get(Uri.parse(url), headers: header);
    return jsonDecode(response.body);
  }
/*
  /// get state city and pincode.......
  static getStateCityPin(String lat, String lng) async {
    String url = "$kBaseURL/user/get_state_city_pincode_from_latlng";

    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "$userId",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "latitudes": "$lat",
      "longitude": "$lng"
    };

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    return jsonDecode(response.body);
  }*/
}
