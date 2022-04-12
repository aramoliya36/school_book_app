import 'package:skoolmonk/model/reqestModel/image_upload_request_model.dart';
import 'package:skoolmonk/model/responseModel/image_upload_response_model.dart';
import 'package:skoolmonk/model/services/api_service.dart';
import 'package:skoolmonk/model/services/base_service.dart';

class ImageUploadRepo extends BaseService {
  Future<ImageUploadResponse> imageUploadRepo(ImageUploadReq model) async {
    Map<String, dynamic> body = await model.toJson();
    print('--------image body--$body');
    var response = await APIService().getResponse(
        url: imageUploadURL,
        body: body,
        apitype: APIType.aPost,
        fileUpload: true);
    print('---------ImageUploadResponse-----1----$response');
    ImageUploadResponse imageUploadResponse =
        ImageUploadResponse.fromJson(response);
    return imageUploadResponse;
  }
}
