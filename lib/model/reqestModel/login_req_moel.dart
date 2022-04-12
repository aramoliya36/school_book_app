class LoginReqModel {
  String emailOrPhone;
  String password;

  LoginReqModel({this.emailOrPhone, this.password});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "email": emailOrPhone,
      "password": password,
    };
  }
}
