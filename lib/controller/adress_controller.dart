import 'package:get/get.dart';

class AddressId extends GetxController {
  int userId = 0;
  int userAddressId = 0;
  setUserAddressId({int valueUserAddressId}) {
    userAddressId = valueUserAddressId;
    update();
  }

  setUserId({int valueUserId}) {
    userId = valueUserId;
    update();
  }
}
