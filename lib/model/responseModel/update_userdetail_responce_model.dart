// To parse this JSON data, do
//
//     final updateUserDetailResponce = updateUserDetailResponceFromJson(jsonString);

import 'dart:convert';

UpdateUserDetailResponce updateUserDetailResponceFromJson(String str) =>
    UpdateUserDetailResponce.fromJson(json.decode(str));

String updateUserDetailResponceToJson(UpdateUserDetailResponce data) =>
    json.encode(data.toJson());

class UpdateUserDetailResponce {
  UpdateUserDetailResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UpdateUserDetailResponce.fromJson(Map<String, dynamic> json) =>
      UpdateUserDetailResponce(
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
    this.userId,
  });

  String userId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
