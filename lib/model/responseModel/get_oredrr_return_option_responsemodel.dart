// To parse this JSON data, do
//
//     final getOrderReturnReplaceResponse = getOrderReturnReplaceResponseFromJson(jsonString);

import 'dart:convert';

GetOrderReturnReplaceResponse getOrderReturnReplaceResponseFromJson(
        String str) =>
    GetOrderReturnReplaceResponse.fromJson(json.decode(str));

String getOrderReturnReplaceResponseToJson(
        GetOrderReturnReplaceResponse data) =>
    json.encode(data.toJson());

class GetOrderReturnReplaceResponse {
  GetOrderReturnReplaceResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetOrderReturnReplaceResponse.fromJson(Map<String, dynamic> json) =>
      GetOrderReturnReplaceResponse(
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
    this.type,
    this.typeText,
    this.optionName,
  });

  String type;
  String typeText;
  String optionName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        type: json["type"],
        typeText: json["type_text"],
        optionName: json["option_name"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "type_text": typeText,
        "option_name": optionName,
      };
}
