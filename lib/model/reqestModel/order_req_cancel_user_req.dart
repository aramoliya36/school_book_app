import 'package:skoolmonk/common/shared_preference.dart';

class OrderReqCancelUserReqModel {
  String orderNo;
  String subOrderNo;

  OrderReqCancelUserReqModel({this.orderNo, this.subOrderNo});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": PreferenceManager.getTokenId(),
      "order_no": orderNo,
      "sub_order_no": subOrderNo,
    };
  }
}
