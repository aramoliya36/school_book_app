import 'package:get/get.dart';
import 'package:skoolmonk/controller/cart_count_controller.dart';
import '../model/responseModel/get_wish_list_response_model.dart';
import '../viewModel/cart_repo_view_model.dart';
import '../viewModel/get_wish_list_view_model.dart';

GetWishListViewModel getWishListViewModel = Get.find();
CartAndWishCountController _cartCountController = Get.find();

CartViewModel _cartViewModel = Get.find();
Future countSetWishCart() async {
  await getWishListViewModel.getWishListViewModel();

  GetWishListResponseModel response = getWishListViewModel.apiResponse.data;
  _cartCountController.setWishCountResponse(value: response.count);
  print('GETX COUNT WISHLIST${_cartCountController.wishListCount}');
  print('TOTOL WISHLIST PRODUCT ${response.count}');

  print('USER  LOGIN');
}
