import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/all_school_repo.dart';
import 'package:skoolmonk/model/responseModel/all_school_responce_model.dart';

class SchoolViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> allSchool() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AllSchoolResponse response = await AllSchoolRepo().allSchoolRepo();
      print('trsp==SchoolViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
