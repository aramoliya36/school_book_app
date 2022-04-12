// To parse this JSON data, do
//
//     final prePaymentCallResponseModel = prePaymentCallResponseModelFromJson(jsonString);

import 'dart:convert';

PrePaymentCallResponseModel prePaymentCallResponseModelFromJson(String str) =>
    PrePaymentCallResponseModel.fromJson(json.decode(str));

String prePaymentCallResponseModelToJson(PrePaymentCallResponseModel data) =>
    json.encode(data.toJson());

class PrePaymentCallResponseModel {
  PrePaymentCallResponseModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory PrePaymentCallResponseModel.fromJson(Map<String, dynamic> json) =>
      PrePaymentCallResponseModel(
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
    this.orderTotalCost,
    this.userId,
    this.orderNo,
    this.userName,
    this.userEmail,
    this.userMobile,
    this.userAddress1,
    this.userAddress2,
    this.userCountries,
    this.userState,
    this.userCity,
    this.userPincode,
  });

  String orderTotalCost;
  String userId;
  String orderNo;
  String userName;
  String userEmail;
  String userMobile;
  String userAddress1;
  String userAddress2;
  String userCountries;
  String userState;
  String userCity;
  String userPincode;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        orderTotalCost: json["order_total_cost"],
        userId: json["user_id"],
        orderNo: json["order_no"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userMobile: json["user_mobile"],
        userAddress1: json["user_address1"],
        userAddress2: json["user_address2"],
        userCountries: json["user_countries"],
        userState: json["user_state"],
        userCity: json["user_city"],
        userPincode: json["user_pincode"],
      );

  Map<String, dynamic> toJson() => {
        "order_total_cost": orderTotalCost,
        "user_id": userId,
        "order_no": orderNo,
        "user_name": userName,
        "user_email": userEmail,
        "user_mobile": userMobile,
        "user_address1": userAddress1,
        "user_address2": userAddress2,
        "user_countries": userCountries,
        "user_state": userState,
        "user_city": userCity,
        "user_pincode": userPincode,
      };
}
