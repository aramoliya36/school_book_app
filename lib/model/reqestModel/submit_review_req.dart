class SubmitReviewReqModel {
  String userId;
  String feedBack;
  String files;

  SubmitReviewReqModel({this.userId, this.feedBack, this.files});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "feedback": feedBack,
      "feedback_img": files
    };
  }
}
