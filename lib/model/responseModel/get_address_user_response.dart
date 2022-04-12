// To parse this JSON data, do
//
//     final userAdressResponse = userAdressResponseFromJson(jsonString);

import 'dart:convert';

UserAddressResponse userAdressResponseFromJson(String str) =>
    UserAddressResponse.fromJson(json.decode(str));

String userAdressResponseToJson(UserAddressResponse data) =>
    json.encode(data.toJson());

class UserAddressResponse {
  UserAddressResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) =>
      UserAddressResponse(
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
    this.userAddressId,
    this.userId,
    this.fname,
    this.mname,
    this.lname,
    this.email,
    this.mobile,
    this.countriesId,
    this.countries,
    this.stateId,
    this.state,
    this.cityId,
    this.city,
    this.address1,
    this.address2,
    this.pincode,
    this.latitudes,
    this.longitude,
    this.isSelected,
  });

  String userAddressId;
  String userId;
  String fname;
  String mname;
  String lname;
  String email;
  String mobile;
  String countriesId;
  String countries;
  String stateId;
  String state;
  String cityId;
  String city;
  String address1;
  String address2;
  String pincode;
  String latitudes;
  String longitude;
  String isSelected;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userAddressId:
            json["user_address_id"] == null ? null : json["user_address_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fname: json["fname"] == null ? null : json["fname"],
        mname: json["mname"] == null ? null : json["mname"],
        lname: json["lname"] == null ? null : json["lname"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        countriesId: json["countries_id"] == null ? null : json["countries_id"],
        countries: json["countries"] == null ? null : json["countries"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        state: json["state"] == null ? null : json["state"],
        cityId: json["city_id"] == null ? null : json["city_id"],
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
        "countries_id": countriesId == null ? null : countriesId,
        "countries": countries == null ? null : countries,
        "state_id": stateId == null ? null : stateId,
        "state": state == null ? null : state,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "pincode": pincode == null ? null : pincode,
        "latitudes": latitudes == null ? null : latitudes,
        "longitude": longitude == null ? null : longitude,
        "is_selected": isSelected == null ? null : isSelected,
      };
}
