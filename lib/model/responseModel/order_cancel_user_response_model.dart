// To parse this JSON data, do
//
//     final orderCancelByResponse = orderCancelByResponseFromJson(jsonString);

import 'dart:convert';

OrderCancelByResponse orderCancelByResponseFromJson(String str) =>
    OrderCancelByResponse.fromJson(json.decode(str));

String orderCancelByResponseToJson(OrderCancelByResponse data) =>
    json.encode(data.toJson());

class OrderCancelByResponse {
  OrderCancelByResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory OrderCancelByResponse.fromJson(Map<String, dynamic> json) =>
      OrderCancelByResponse(
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
