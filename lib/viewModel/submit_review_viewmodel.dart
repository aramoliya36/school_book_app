import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/submit_feedback_repo.dart';
import 'package:skoolmonk/model/reqestModel/submit_review_req.dart';
import 'package:skoolmonk/model/responseModel/submit_feedback_response_model.dart';

class UserSubmitReviewViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> userSubmitReviewViewModel({SubmitReviewReqModel model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SubmitReviewResponse response =
          await SubmitFeedbackRepo().submitFeedbackRepo(model.toJson());
      print('UserSubmitReviewViewModel====>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".....UserSubmitReviewViewModel....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
