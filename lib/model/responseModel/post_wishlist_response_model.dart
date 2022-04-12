// To parse this JSON data, do
//
//     final postWishListResponse = postWishListResponseFromJson(jsonString);

import 'dart:convert';

PostWishListResponse postWishListResponseFromJson(String str) =>
    PostWishListResponse.fromJson(json.decode(str));

String postWishListResponseToJson(PostWishListResponse data) =>
    json.encode(data.toJson());

class PostWishListResponse {
  PostWishListResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory PostWishListResponse.fromJson(Map<String, dynamic> json) =>
      PostWishListResponse(
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
    this.productId,
    this.status,
  });

  String userId;
  String productId;
  String status;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "status": status == null ? null : status,
      };
}
