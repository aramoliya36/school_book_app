import 'package:get/get.dart';
import 'package:skoolmonk/model/responseModel/get_all_user_address.dart';

class AddressCartController extends GetxController {
  // List<ResponseSingleAddress> addRessCartScreen = <ResponseSingleAddress>[];
  //
  // setSingleAddress({ResponseSingleAddress singleAddress}) {
  //   addRessCartScreen.add(singleAddress);
  //   update();
  // }

  RxList<ResponseSingleAddress> _schoolCatProductList =
      <ResponseSingleAddress>[].obs;

  RxList<ResponseSingleAddress> get schoolCatProductList =>
      _schoolCatProductList;

  void singleAddressCartScreen(ResponseSingleAddress value) {
    _schoolCatProductList.add(value);
    update();
  }

  clearSingleAddressCartScreen() {
    _schoolCatProductList.clear();
    update();
  }
}
