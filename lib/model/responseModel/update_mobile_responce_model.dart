// To parse this JSON data, do
//
//     final updateMobileNoResponce = updateMobileNoResponceFromJson(jsonString);

import 'dart:convert';

UpdateMobileNoResponce updateMobileNoResponceFromJson(String str) =>
    UpdateMobileNoResponce.fromJson(json.decode(str));

String updateMobileNoResponceToJson(UpdateMobileNoResponce data) =>
    json.encode(data.toJson());

class UpdateMobileNoResponce {
  UpdateMobileNoResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UpdateMobileNoResponce.fromJson(Map<String, dynamic> json) =>
      UpdateMobileNoResponce(
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
    this.mobile,
  });

  String userId;
  String mobile;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile": mobile,
      };
}
