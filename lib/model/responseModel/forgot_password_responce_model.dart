// To parse this JSON data, do
//
//     final forgotPasswordResponce = forgotPasswordResponceFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponce forgotPasswordResponceFromJson(String str) =>
    ForgotPasswordResponce.fromJson(json.decode(str));

String forgotPasswordResponceToJson(ForgotPasswordResponce data) =>
    json.encode(data.toJson());

class ForgotPasswordResponce {
  ForgotPasswordResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory ForgotPasswordResponce.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponce(
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
    this.mobile,
    this.otp,
    this.numOfOptSentToday,
  });

  String userId;
  String userSlug;
  String mobile;
  var otp;
  int numOfOptSentToday;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        userSlug: json["user_slug"],
        mobile: json["mobile"],
        otp: json["otp"],
        numOfOptSentToday: json["num_of_opt_sent_today"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_slug": userSlug,
        "mobile": mobile,
        "otp": otp,
        "num_of_opt_sent_today": numOfOptSentToday,
      };
}
