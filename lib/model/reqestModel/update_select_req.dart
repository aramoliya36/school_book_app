class UpdateSelectAddressReqModel {
  String userid;
  String useraddressid;
  String isSelected;

  UpdateSelectAddressReqModel(
      {this.userid, this.useraddressid, this.isSelected});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userid,
      "user_address_id": useraddressid,
      "is_selected": isSelected,
    };
  }
}
