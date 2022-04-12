import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';

import 'package:skoolmonk/model/repo/image_upload_repo.dart';
import 'package:skoolmonk/model/repo/update_profile_repo.dart';
import 'package:skoolmonk/model/reqestModel/image_upload_request_model.dart';
import 'package:skoolmonk/model/reqestModel/update_profile_req_model.dart';
import 'package:skoolmonk/model/responseModel/image_upload_response_model.dart';
import 'package:skoolmonk/model/responseModel/update_profile_response_model.dart';

class UpdateProfileViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  ApiResponse _imageUploadApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get imageUploadApiResponse => _imageUploadApiResponse;
  Future<void> updateProfile({UpdateProfileReq model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateProfileResponse response =
          await UpdateProfileRepo().updateProfileRepo(model.toJson());
      print('trsp=>$response ');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  Future<void> imageUpload({ImageUploadReq model}) async {
    _imageUploadApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      ImageUploadResponse response =
          await ImageUploadRepo().imageUploadRepo(model);
      print('_imageUploadApiResponse=>$response');
      _imageUploadApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("_imageUploadApiResponse.........>$e");
      _imageUploadApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
