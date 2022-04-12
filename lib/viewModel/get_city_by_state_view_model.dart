import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_city_by_state_repo.dart';
import 'package:skoolmonk/model/responseModel/get_city_by_state.dart';

class GetCityByStateViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getCityByStateViewModel({String stdId}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetCityByCountryResponse response =
          await GetCityByStateRepo().getCityByStateRepo(stateId: stdId);
      print('GetCityByStateViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetCityByStateViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
