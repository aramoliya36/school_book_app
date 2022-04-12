class GetUserDetailReqModel {
  String userId;

  GetUserDetailReqModel({this.userId});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
    };
  }
}
