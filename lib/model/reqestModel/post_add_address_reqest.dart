import 'package:skoolmonk/common/shared_preference.dart';

class AddAddressReqModel {
  String userId;
  String fname;
  String lname;
  String email;
  String mobile;
  String state;
  String city;
  String address1;
  String address2;
  String pincode;

  AddAddressReqModel(
      {this.userId,
      this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.state,
      this.pincode,
      this.city,
      this.address1,
      this.address2});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": PreferenceManager.getTokenId(),
      "fname": fname,
      "lname": lname,
      "email": email,
      "mobile": mobile,
      "state": state,
      "city": city,
      "address1": address1,
      "address2": address2,
      "pincode": pincode,
    };
  }
}
