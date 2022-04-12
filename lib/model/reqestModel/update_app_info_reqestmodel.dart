class UpdateAppInfoRequestModel {
  String currentUserId;
  String fcmIdToken;
  String osInfoMobile;
  String modelNameMobile;
  String appVersion;
  String uniqueId;

  static final UpdateAppInfoRequestModel requestModel =
      UpdateAppInfoRequestModel._internal();

  UpdateAppInfoRequestModel._internal();

  factory UpdateAppInfoRequestModel() {
    return requestModel;
  }
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      'user_id': currentUserId,
      'device_id': fcmIdToken,
      'os_info': osInfoMobile,
      'model_name': modelNameMobile,
      'app_version': appVersion,
      'more_app_info': uniqueId
    };
  }
}
