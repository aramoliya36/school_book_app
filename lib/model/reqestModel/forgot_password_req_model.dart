class ForgotPasswordReqModel {
  var phone;

  ForgotPasswordReqModel({this.phone});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "mobile": phone,
    };
  }
}
