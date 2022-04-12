import 'package:skoolmonk/model/responseModel/submit_feedback_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class SubmitFeedbackRepo extends BaseService {
  Future<SubmitReviewResponse> submitFeedbackRepo(
      Map<String, dynamic> body) async {
    var response = await APIService().getResponse(
        url: userSubmitReviewURL, body: body, apitype: APIType.aPost);
    SubmitReviewResponse submitReviewResponse =
        SubmitReviewResponse.fromJson(response);
    print('----------SubmitFeedbackRepo---------$response');
    return submitReviewResponse;
  }
}
