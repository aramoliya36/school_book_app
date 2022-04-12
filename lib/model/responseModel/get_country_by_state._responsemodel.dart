// To parse this JSON data, do
//
//     final getCountryByStateResponse = getCountryByStateResponseFromJson(jsonString);

import 'dart:convert';

GetCountryByStateResponse getCountryByStateResponseFromJson(String str) =>
    GetCountryByStateResponse.fromJson(json.decode(str));

String getCountryByStateResponseToJson(GetCountryByStateResponse data) =>
    json.encode(data.toJson());

class GetCountryByStateResponse {
  GetCountryByStateResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetCountryByStateResponse.fromJson(Map<String, dynamic> json) =>
      GetCountryByStateResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.stateId,
    this.name,
    this.countryId,
  });

  String stateId;
  String name;
  String countryId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        stateId: json["state_id"] == null ? null : json["state_id"],
        name: json["name"] == null ? null : json["name"],
        countryId: json["country_id"] == null ? null : json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId == null ? null : stateId,
        "name": name == null ? null : name,
        "country_id": countryId == null ? null : countryId,
      };
}
