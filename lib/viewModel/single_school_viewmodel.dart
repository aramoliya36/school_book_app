import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/single_school_repo.dart';
import 'package:skoolmonk/model/responseModel/single_school_response.dart';

class SingleSchoolViewModelController extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> singlSchool({String schoolSlug}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SingleSchoolResponse response =
          await SingleSchoolRepo().singleSchoolRepo(schoolSlug: schoolSlug);
      print('trsp=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
