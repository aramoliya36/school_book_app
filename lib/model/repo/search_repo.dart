import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class SearchRepo extends BaseService {
  APIService apiService = APIService();

  /// api to search products...
  Future searchProductHomePage(String productName, String userId) async {
    String url = "$searchProductURL$userId/$productName";

    Map<String, String> header = {
      "Authorization": "${apiService.authorizationToken}",
      "Client-Service": "${apiService.clientServiceToken}",
      "Auth-Key": "${apiService.authKeyToken}",
      "Content-Type": "${apiService.contentTypeToken}",
    };
    Map<String, dynamic> body = {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_find": "$productName"
    };
    print("URL SEARCH --> $url");
    print("REQUEST IS SEARCH --> $body");

    http.Response response = await http.get(Uri.parse(url), headers: header);
    // http.Response response = await http.post(url, headers: header, body: body);

    print("RESPONSE IS SEARCH --> ${response.body}");

    return jsonDecode(response.body);
  }

  Future searchSuggestion(String productName, String userId) async {
    String url = "$findSuggestionURL";

    // String url =
    //     "$kBaseURL/product/find/1595922619X5f1fd8bb5f332/MOB/$userId/$productName";

    Map<String, String> header = {
      "Authorization": "${apiService.authorizationToken}",
      "Client-Service": "${apiService.clientServiceToken}",
      "Auth-Key": "${apiService.authKeyToken}",
      "Content-Type": "${apiService.contentTypeToken}",
    };
    Map<String, dynamic> body = {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_find": "$productName"
    };
    print("URL SEARCH --> $url");
    print("REQUEST IS SEARCH --> $body");

    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: body);
    // http.Response response = await http.post(url, headers: header, body: body);

    print("RESPONSE IS SEARCH --> ${response.body}");

    return jsonDecode(response.body);
  }
}
