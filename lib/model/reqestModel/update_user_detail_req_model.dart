class UpdateUserDetailReqModel {
  String userId;
  String fname;
  String lname;
  String dob;
  String gender;

  UpdateUserDetailReqModel(
      {this.userId, this.fname, this.lname, this.gender, this.dob});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "fname": fname,
      "lname": lname,
      "dob": dob,
      "gender": gender,
    };
  }
}
