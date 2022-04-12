import 'package:skoolmonk/common/shared_preference.dart';

class PaymentSuccessReq {
  String orderTotalCost;
  String orderNo;
  String orderStatus;
  String paymentResponse;

  PaymentSuccessReq(
      {this.orderTotalCost,
      this.orderNo,
      this.orderStatus,
      this.paymentResponse});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": PreferenceManager.getTokenId(),
      "order_total_cost": orderTotalCost,
      "order_no": orderNo,
      "order_status": orderStatus,
      "payment_response": paymentResponse
    };
  }
}
