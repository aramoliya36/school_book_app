// To parse this JSON data, do
//
//     final getCityByCountryResponse = getCityByCountryResponseFromJson(jsonString);

import 'dart:convert';

GetCityByCountryResponse getCityByCountryResponseFromJson(String str) =>
    GetCityByCountryResponse.fromJson(json.decode(str));

String getCityByCountryResponseToJson(GetCityByCountryResponse data) =>
    json.encode(data.toJson());

class GetCityByCountryResponse {
  GetCityByCountryResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetCityByCountryResponse.fromJson(Map<String, dynamic> json) =>
      GetCityByCountryResponse(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.cityId,
    this.name,
    this.stateId,
  });

  String cityId;
  String name;
  String stateId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        cityId: json["city_id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "name": name,
        "state_id": stateId,
      };
}
