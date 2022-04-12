// To parse this JSON data, do
//
//     final orderReqCancelByResponse = orderReqCancelByResponseFromJson(jsonString);

import 'dart:convert';

OrderReqCancelByResponse orderReqCancelByResponseFromJson(String str) =>
    OrderReqCancelByResponse.fromJson(json.decode(str));

String orderReqCancelByResponseToJson(OrderReqCancelByResponse data) =>
    json.encode(data.toJson());

class OrderReqCancelByResponse {
  OrderReqCancelByResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory OrderReqCancelByResponse.fromJson(Map<String, dynamic> json) =>
      OrderReqCancelByResponse(
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
