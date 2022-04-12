class ResetPasswordReqModel {
  var phone;
  var otp;
  String password;
  String confirmPassword;

  ResetPasswordReqModel(
      {this.phone, this.confirmPassword, this.otp, this.password});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "mobile": phone,
      "otp": otp,
      "password": password,
      "confirm_password": confirmPassword
    };
  }
}
