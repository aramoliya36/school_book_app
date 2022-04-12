// To parse this JSON data, do
//
//     final addAddressResponse = addAddressResponseFromJson(jsonString);

import 'dart:convert';

AddAddressResponse addAddressResponseFromJson(String str) =>
    AddAddressResponse.fromJson(json.decode(str));

String addAddressResponseToJson(AddAddressResponse data) =>
    json.encode(data.toJson());

class AddAddressResponse {
  AddAddressResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) =>
      AddAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.userId,
    this.userAddressId,
  });

  String userId;
  int userAddressId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"] == null ? null : json["user_id"],
        userAddressId:
            json["user_address_id"] == null ? null : json["user_address_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "user_address_id": userAddressId == null ? null : userAddressId,
      };
}
