// To parse this JSON data, do
//
//     final removeCartResponse = removeCartResponseFromJson(jsonString);

import 'dart:convert';

RemoveCartResponse removeCartResponseFromJson(String str) =>
    RemoveCartResponse.fromJson(json.decode(str));

String removeCartResponseToJson(RemoveCartResponse data) =>
    json.encode(data.toJson());

class RemoveCartResponse {
  RemoveCartResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory RemoveCartResponse.fromJson(Map<String, dynamic> json) =>
      RemoveCartResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        response: json["response"] == null
            ? null
            : List<dynamic>.from(json["response"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x)),
      };
}
