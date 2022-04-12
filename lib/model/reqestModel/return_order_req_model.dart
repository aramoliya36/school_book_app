class ReturnOrderReqModel {
  String userId;
  String orderNo;
  String subOrderNo;
  String productId;
  String qty;
  String requestStatus;
  String reason;
  String comment;
  String files;

  ReturnOrderReqModel(
      {this.requestStatus,
      this.userId,
      this.orderNo,
      this.subOrderNo,
      this.productId,
      this.qty,
      this.comment,
      this.files,
      this.reason});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "order_no": orderNo,
      "sub_order_no": subOrderNo,
      "product_id": productId,
      "qty": qty,
      "request_status": requestStatus,
      "reason": reason,
      "comment": comment,
      "files": files
    };
  }
}
