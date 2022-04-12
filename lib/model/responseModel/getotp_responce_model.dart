// To parse this JSON data, do
//
//     final getOtpResponce = getOtpResponceFromJson(jsonString);

import 'dart:convert';

GetOtpResponce getOtpResponceFromJson(String str) =>
    GetOtpResponce.fromJson(json.decode(str));

String getOtpResponceToJson(GetOtpResponce data) => json.encode(data.toJson());

class GetOtpResponce {
  GetOtpResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetOtpResponce.fromJson(Map<String, dynamic> json) => GetOtpResponce(
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
    this.otp,
    this.numOfOptSentToday,
  });

  String userId;
  String mobile;
  var otp;
  int numOfOptSentToday;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        mobile: json["mobile"],
        otp: json["otp"],
        numOfOptSentToday: json["num_of_opt_sent_today"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile": mobile,
        "otp": otp,
        "num_of_opt_sent_today": numOfOptSentToday,
      };
}
