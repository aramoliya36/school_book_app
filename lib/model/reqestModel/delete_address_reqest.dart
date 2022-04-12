import 'package:flutter/material.dart';

class DeleteAddressReqModel {
  String userid;
  String useraddressid;

  DeleteAddressReqModel({this.userid, this.useraddressid});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userid,
      "user_address_id": useraddressid,
    };
  }
}
