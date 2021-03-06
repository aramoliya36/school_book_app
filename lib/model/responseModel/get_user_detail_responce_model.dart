// To parse this JSON data, do
//
//     final getUserDetailResponce = getUserDetailResponceFromJson(jsonString);

import 'dart:convert';

GetUserDetailResponce getUserDetailResponceFromJson(String str) =>
    GetUserDetailResponce.fromJson(json.decode(str));

String getUserDetailResponceToJson(GetUserDetailResponce data) =>
    json.encode(data.toJson());

class GetUserDetailResponce {
  GetUserDetailResponce({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetUserDetailResponce.fromJson(Map<String, dynamic> json) =>
      GetUserDetailResponce(
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
    this.userId,
    this.userSlug,
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.profilePic,
    this.emailHash,
    this.dob,
    this.gender,
    this.isMobileVerified,
  });

  String userId;
  String userSlug;
  String fname;
  String lname;
  String email;
  String mobile;
  String profilePic;
  String emailHash;
  String dob;
  String gender;
  String isMobileVerified;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        userSlug: json["user_slug"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        mobile: json["mobile"],
        profilePic: json["profile_pic"],
        emailHash: json["email_hash"],
        dob: json["dob"],
        gender: json["gender"],
        isMobileVerified: json["is_mobile_verified"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_slug": userSlug,
        "fname": fname,
        "lname": lname,
        "email": email,
        "mobile": mobile,
        "profile_pic": profilePic,
        "email_hash": emailHash,
        "dob": dob,
        "gender": gender,
        "is_mobile_verified": isMobileVerified,
      };
}
