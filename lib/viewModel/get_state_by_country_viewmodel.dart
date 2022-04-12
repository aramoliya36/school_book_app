import 'package:get/get.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/repo/get_school_city_by_state_id_repo.dart';
import 'package:skoolmonk/model/responseModel/get_country_by_state._responsemodel.dart';

class GetStateByCountryViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getStateByCountryViewModel() async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetCountryByStateResponse response =
          await GetStateByCountryRepo().getStateByCountryRepo();
      print('GetStateByCountryViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetStateByCountryViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
