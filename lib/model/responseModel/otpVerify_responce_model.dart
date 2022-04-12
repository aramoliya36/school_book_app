// To parse this JSON data, do
//
//     final otpVerifyResponce = otpVerifyResponceFromJson(jsonString);

import 'dart:convert';

OtpVerifyResponce otpVerifyResponceFromJson(String str) => OtpVerifyResponce.fromJson(json.decode(str));

String otpVerifyResponceToJson(OtpVerifyResponce data) => json.encode(data.toJson());

class OtpVerifyResponce {
  OtpVerifyResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory OtpVerifyResponce.fromJson(Map<String, dynamic> json) => OtpVerifyResponce(
    status: json["status"],
    message: json["message"],
    count: json["count"],
    response: List<dynamic>.from(json["response"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "count": count,
    "response": List<dynamic>.from(response.map((x) => x)),
  };
}
