class RemoveReqModel {
  String userId;
  String cartId;

  RemoveReqModel({this.userId, this.cartId});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "cart_id": cartId,
    };
  }
}
