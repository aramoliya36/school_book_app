class OTPVerifyReq {
  String phone;
  String userId;
  var otp;

  OTPVerifyReq({this.phone, this.userId, this.otp});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "mobile": phone,
      "user_id": userId,
      "otp": otp
    };
  }
}
