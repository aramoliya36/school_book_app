// To parse this JSON data, do
//
//     final updateUserAppInfoResponse = updateUserAppInfoResponseFromJson(jsonString);

import 'dart:convert';

UpdateUserAppInfoResponse updateUserAppInfoResponseFromJson(String str) => UpdateUserAppInfoResponse.fromJson(json.decode(str));

String updateUserAppInfoResponseToJson(UpdateUserAppInfoResponse data) => json.encode(data.toJson());

class UpdateUserAppInfoResponse {
  UpdateUserAppInfoResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UpdateUserAppInfoResponse.fromJson(Map<String, dynamic> json) => UpdateUserAppInfoResponse(
    status: json["status"],
    message: json["message"],
    count: json["count"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
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
  });

  String userId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
