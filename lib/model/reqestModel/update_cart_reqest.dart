class UpdateCartReq {
  String userId;
  String productId;
  String cartId;
  String qty;
  String studentName;
  String studentRoll;
  String additionalSetInfo;

  UpdateCartReq({
    this.userId,
    this.productId,
    this.qty,
    this.studentName,
    this.studentRoll,
    this.additionalSetInfo,
  });
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "product_id": productId,
      "cart_id": cartId,
      "qty": qty,
      "student_name": studentName,
      "student_roll": studentRoll,
      "additional_set_info": additionalSetInfo
    };
  }
}
