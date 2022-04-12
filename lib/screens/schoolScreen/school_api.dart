import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:skoolmonk/common/shared_preference.dart';

import '../../model/services/api_service.dart';
import '../../model/services/base_service.dart';

APIService apiService = APIService();

class SchoolAPI extends BaseService {
  Map<String, String> header = {
    "Authorization": "${apiService.authorizationToken}",
    "Client-Service": "${apiService.clientServiceToken}",
    "Auth-Key": "${apiService.authKeyToken}",
    "Content-Type": "${apiService.contentTypeToken}",
  };

  /// api to list all the school details.
  Future getAllSchoolList() async {
    String url = allSchoolURL;

    http.Response response = await http.get(
      Uri.parse(url),
      // headers: header,
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }

/*
  Future getSchoolAccess({String schoolSlug, String code}) async {
    String userId = PreferenceManager.getTokenId() ?? 0;
    String url =
        "$kBaseURL/app/verify_secure_school/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug/$code";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }*/
/*
  static Future getSchoolProductDetails(
      String schoolSlug, String userId) async {
    String url =
        "$kBaseURL/app/single_school/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(
      url,
      headers: header,
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }

  /// api to fetch products of selected sub category in school info page...
  static Future getSubcategoryProductsOfSchool(
      String userId, String schoolSlug, String subcategoryId) async {
    String url =
        "$kBaseURL/app/single_school_categories_product/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug/$subcategoryId";
    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
*/
  /// find school by location .....
  Future findSchoolByLocation(String userId, String countryId, String stateId,
      String cityId, String pincode) async {
    // String url =
    //     "$kBaseURL/app/find_school_by_location/1595922619X5f1fd8bb5f332/MOB/$userId/$countryId/$stateId/$cityId/$pincode";
    String url =
        "http://scprojects.in.net/projects/skoolmonk/api_/app/find_school_by_location/1595922666X5f1fd8bb5f662/MOB/$userId/$countryId/$stateId/$cityId/$pincode";
    // log("FIND SCHOOL BY LOCATION URL $url");
    http.Response response = await http.get(Uri.parse(url), headers: header);
    // log("FIND SCHOOL RESPONSE ${response.body}");
    return jsonDecode(response.body);
  }
}
