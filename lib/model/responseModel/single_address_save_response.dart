// To parse this JSON data, do
//
//     final singleAllUserAddressResponse = singleAllUserAddressResponseFromJson(jsonString);

import 'dart:convert';

SingleAllUserAddressResponse singleAllUserAddressResponseFromJson(String str) =>
    SingleAllUserAddressResponse.fromJson(json.decode(str));

String singleAllUserAddressResponseToJson(SingleAllUserAddressResponse data) =>
    json.encode(data.toJson());

class SingleAllUserAddressResponse {
  SingleAllUserAddressResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<SingleMyResponse> response;

  factory SingleAllUserAddressResponse.fromJson(Map<String, dynamic> json) =>
      SingleAllUserAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        response: json["response"] == null
            ? null
            : List<SingleMyResponse>.from(
                json["response"].map((x) => SingleMyResponse.fromJson(x))),
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

class SingleMyResponse {
  SingleMyResponse(
      {this.userAddressId,
      this.userId,
      this.fname,
      this.mname,
      this.lname,
      this.email,
      this.mobile,
      this.country,
      this.state,
      this.city,
      this.address1,
      this.address2,
      this.pincode,
      this.latitudes,
      this.longitude,
      this.isSelected,
      this.city_id,
      this.state_id});

  String userAddressId;
  String userId;
  String fname;
  String mname;
  String lname;
  String email;
  String mobile;
  String country;
  String state;
  String city;
  String city_id;
  String state_id;
  String address1;
  String address2;
  String pincode;
  String latitudes;
  String longitude;
  String isSelected;

  factory SingleMyResponse.fromJson(Map<String, dynamic> json) =>
      SingleMyResponse(
        userAddressId:
            json["user_address_id"] == null ? null : json["user_address_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fname: json["fname"] == null ? null : json["fname"],
        mname: json["mname"] == null ? null : json["mname"],
        lname: json["lname"] == null ? null : json["lname"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        state_id: json["state_id"] == null ? null : json["state_id"],
        city_id: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        latitudes: json["latitudes"] == null ? null : json["latitudes"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        isSelected: json["is_selected"] == null ? null : json["is_selected"],
      );

  Map<String, dynamic> toJson() => {
        "user_address_id": userAddressId == null ? null : userAddressId,
        "user_id": userId == null ? null : userId,
        "fname": fname == null ? null : fname,
        "mname": mname == null ? null : mname,
        "lname": lname == null ? null : lname,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "pincode": pincode == null ? null : pincode,
        "latitudes": latitudes == null ? null : latitudes,
        "longitude": longitude == null ? null : longitude,
        "is_selected": isSelected == null ? null : isSelected,
      };
}
