import 'package:get/get.dart';
import 'package:skoolmonk/controller/cart_count_controller.dart';

import '../model/responseModel/cart_response_model.dart';
import '../viewModel/cart_repo_view_model.dart';

CartAndWishCountController _cartCountController = Get.find();

CartViewModel _cartViewModel = Get.find();
Future countSetCart() async {
  await _cartViewModel.cartViewModel();
  CartResponse response = _cartViewModel.apiResponse.data;
  _cartCountController.setCartCountResponse(value: response.count);
  print('TOTOL COUNT PRODUCT ${response.count}');

  print('USER  LOGIN');
}
