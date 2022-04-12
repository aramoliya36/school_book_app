import 'package:get/get.dart';
import 'package:skoolmonk/model/responseModel/single_address_save_response.dart';

class UpdateAddressSingleController extends GetxController {
  RxList<SingleMyResponse> _updateScreenSingle = <SingleMyResponse>[].obs;

  RxList<SingleMyResponse> get updateScreenSingle => _updateScreenSingle;

  void setUpdateAddressScreen({SingleMyResponse value}) {
    _updateScreenSingle.add(value);
    update();
  }

  clearSetUpdateAddressScreen() {
    _updateScreenSingle.clear();
    update();
  }
}
