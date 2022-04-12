class UpdateMobileNoReqModel {
  String phone;
  String userId;

  UpdateMobileNoReqModel({this.phone, this.userId});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "mobile": phone,
      "user_id": userId,
    };
  }
}
