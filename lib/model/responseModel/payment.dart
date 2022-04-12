// To parse this JSON data, do
//
//     final paymentSuccessResponseModel = paymentSuccessResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentSuccessResponseModel paymentSuccessResponseModelFromJson(String str) =>
    PaymentSuccessResponseModel.fromJson(json.decode(str));

String paymentSuccessResponseModelToJson(PaymentSuccessResponseModel data) =>
    json.encode(data.toJson());

class PaymentSuccessResponseModel {
  PaymentSuccessResponseModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory PaymentSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentSuccessResponseModel(
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
