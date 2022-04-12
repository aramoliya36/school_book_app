class SignUpReqModel {
  String fname;
  String lname;
  String email;
  String phone;
  String dob;
  String password;
  String confirmPassword;

  SignUpReqModel({
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.dob,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "fname": fname,
      "lname": lname,
      "email": email,
      "mobile": phone,
      "dob": dob,
      "password": password,
      "confirm_password": confirmPassword,
    };
  }
}
