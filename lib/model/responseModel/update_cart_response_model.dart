// To parse this JSON data, do
//
//     final updateCartRespons = updateCartResponsFromJson(jsonString);

import 'dart:convert';

UpdateCartRespons updateCartResponsFromJson(String str) =>
    UpdateCartRespons.fromJson(json.decode(str));

String updateCartResponsToJson(UpdateCartRespons data) =>
    json.encode(data.toJson());

class UpdateCartRespons {
  UpdateCartRespons({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory UpdateCartRespons.fromJson(Map<String, dynamic> json) =>
      UpdateCartRespons(
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
