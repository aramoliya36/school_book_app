import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_homepage_repo.dart';
import 'package:skoolmonk/model/responseModel/get_homepage_response_model.dart';

class GetHomePageViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getHomePageViewModel() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      GetHomePageResponse response = await GetHomePageRepo().getHomePageRepo();
      print('GetHomePageViewModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetHomePageViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  bool isHomePopUp = true;
  setHomePopup() {
    isHomePopUp = false;
    update();
  }

  int _changeIndex = 0;

  int get changeIndex => _changeIndex;

  set changeIndex(int value) {
    _changeIndex = value;
    update();
  }
}
