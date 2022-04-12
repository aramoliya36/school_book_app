import '../../common/shared_preference.dart';

class PrePaymentReqModel {
  String userId;
  String paymentMethod;
  String paymentSource;

  PrePaymentReqModel({this.paymentMethod, this.paymentSource, this.userId});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "payment_method": paymentMethod,
      "payment_source": paymentSource,
      "app_version": PreferenceManager.getAppVersion() ?? "000000.1",
    };
  }
}
