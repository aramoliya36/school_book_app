import 'dart:convert';

class AddToCartReq {
  String userId;
  String productId;
  String qty;
  String qtyUpdate;
  String studentName;
  String studentRoll;
  String pvsmId;
  List variationsnIfo;
  String additionalSetInfo;
  String pbdId;
  String booksetCustomize;
  String booksetProductIds;
  String booksetCustomizeArray;

  AddToCartReq(
      {this.userId,
      this.productId,
      this.qty,
      this.studentName,
      this.studentRoll,
      this.pvsmId,
      this.variationsnIfo,
      this.additionalSetInfo,
      this.pbdId,
      this.booksetCustomize,
      this.booksetProductIds,
      this.booksetCustomizeArray,
      this.qtyUpdate});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "product_id": productId,
      "qty": qty,
      "student_name": studentName,
      "student_roll": studentRoll,
      "pvsm_id": pvsmId,
      "variations_info": jsonEncode(variationsnIfo.map((e) => e).toList()),
      "additional_set_info": additionalSetInfo,
      "pbd_id": pbdId,
      "bookset_customize": booksetCustomize,
      "bookset_product_ids": booksetProductIds,
      "bookset_customize_array": booksetCustomizeArray,
      "qty_update": qtyUpdate
    };
  }
}
