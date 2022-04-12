// To parse this JSON data, do
//
//     final orderReturnReqResponse = orderReturnReqResponseFromJson(jsonString);

import 'dart:convert';

OrderReturnReqResponse orderReturnReqResponseFromJson(String str) =>
    OrderReturnReqResponse.fromJson(json.decode(str));

String orderReturnReqResponseToJson(OrderReturnReqResponse data) =>
    json.encode(data.toJson());

class OrderReturnReqResponse {
  OrderReturnReqResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory OrderReturnReqResponse.fromJson(Map<String, dynamic> json) =>
      OrderReturnReqResponse(
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
