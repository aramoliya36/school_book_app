// To parse this JSON data, do
//
//     final imageUploadResponse = imageUploadResponseFromJson(jsonString);

import 'dart:convert';

ImageUploadResponse imageUploadResponseFromJson(String str) =>
    ImageUploadResponse.fromJson(json.decode(str));

String imageUploadResponseToJson(ImageUploadResponse data) =>
    json.encode(data.toJson());

class ImageUploadResponse {
  ImageUploadResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) =>
      ImageUploadResponse(
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
    this.path,
  });

  String path;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}
