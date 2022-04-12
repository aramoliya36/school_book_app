import 'dart:convert';

class VariationInfo2ReqModel {
  String userId;

  String productId;
  List variationsStock;
  VariationInfo2ReqModel({this.userId, this.productId, this.variationsStock});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "product_id": productId,
      "variations_stock": jsonEncode(variationsStock.map((e) => e).toList())
    };
  }
}
