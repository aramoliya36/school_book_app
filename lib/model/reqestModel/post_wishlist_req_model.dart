import 'package:skoolmonk/common/shared_preference.dart';

class PostWishListReqModel {
  String productId;
  String status;

  PostWishListReqModel({this.productId, this.status});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": PreferenceManager.getTokenId(),
      "product_id": productId,
      "status": status
    };
  }
}
