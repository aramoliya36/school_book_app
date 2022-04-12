// To parse this JSON data, do
//
//     final resetPasswordResponce = resetPasswordResponceFromJson(jsonString);

import 'dart:convert';

ResetPasswordResponce resetPasswordResponceFromJson(String str) =>
    ResetPasswordResponce.fromJson(json.decode(str));

String resetPasswordResponceToJson(ResetPasswordResponce data) =>
    json.encode(data.toJson());

class ResetPasswordResponce {
  ResetPasswordResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory ResetPasswordResponce.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponce(
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
    this.userSlug,
  });

  String userId;
  String userSlug;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        userSlug: json["user_slug"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_slug": userSlug,
      };
}
