import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skoolmonk/controller/add_to_cart_address_controller.dart';
import 'package:skoolmonk/controller/bookset_item_class_controller.dart';
import 'package:skoolmonk/controller/favourite_button.dart';
import 'package:skoolmonk/controller/filter_controller.dart';
import 'package:skoolmonk/controller/filter_data_encoding.dart';
import 'package:skoolmonk/controller/school_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/controller/table_controller.dart';
import 'package:skoolmonk/screens/splash_screen.dart';
import 'package:skoolmonk/viewModel/FilterCategoriesProductPost_viewmodel.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/all_category_view_model.dart';
import 'package:skoolmonk/viewModel/cart_repo_view_model.dart';
import 'package:skoolmonk/viewModel/delete_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/filter_personal_call_view_model.dart';
import 'package:skoolmonk/viewModel/get_all_user_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_city_by_state_view_model.dart';
import 'package:skoolmonk/viewModel/get_homepage_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_order_return_option_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_profile.dart';
import 'package:skoolmonk/viewModel/get_state_by_country_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_wish_list_view_model.dart';
import 'package:skoolmonk/viewModel/mainCategoriesSubcategoriesProductFilter_view_model.dart';
import 'package:skoolmonk/viewModel/order_cancel_user_viewmodel.dart';
import 'package:skoolmonk/viewModel/order_req_cancel_viewmodel.dart';
import 'package:skoolmonk/viewModel/otpVerify_view_model.dart';
import 'package:skoolmonk/viewModel/payment_succes_view_model.dart';
import 'package:skoolmonk/viewModel/post_add_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/post_wishlist_view_model.dart';
import 'package:skoolmonk/viewModel/pre_payment_call_viewmodel.dart';
import 'package:skoolmonk/viewModel/productDetail_view_model.dart';
import 'package:skoolmonk/viewModel/purchase_history_by_order_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_delivered_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_viewmodel.dart';
import 'package:skoolmonk/viewModel/remove_cart_view_model.dart';
import 'package:skoolmonk/viewModel/return_order_req_viewmodel.dart';
import 'package:skoolmonk/viewModel/single_save_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/sub_category_list_last_api_viewmodel.dart';
import 'package:skoolmonk/viewModel/sub_category_view_model.dart';
import 'package:skoolmonk/viewModel/update_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/update_cart_view_model.dart';
import 'package:skoolmonk/viewModel/update_profile_view_model.dart';
import 'package:skoolmonk/viewModel/update_select_address_view_model.dart';
import 'package:skoolmonk/viewModel/update_user_app_info_viewmodel.dart';
import 'package:skoolmonk/viewModel/variation_info2_viewmodel.dart';
import 'common/color_picker.dart';
import 'controller/adress_controller.dart';
import 'controller/auth_viewmodel.dart';
import 'controller/cart_count_controller.dart';
import 'controller/product_detail__screen_controller.dart';
import 'controller/search_controller.dart';
import 'controller/sub_category_controller.dart';
import 'controller/bottom_controller.dart';
import 'controller/category_controller.dart';
import 'controller/colorChange_Controller.dart';
import 'controller/update_address_single_controller.dart';
import 'controller/wish_list_controller.dart';
import 'model/services/app_notification.dart';
import 'screens/splash_screen.dart';
import 'viewModel/all_school_view_model.dart';
import 'viewModel/single_school_viewmodel.dart';
import 'viewModel/submit_review_viewmodel.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorPicker.navyBlue,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  await GetStorage.init();

  ///firebase initiallize
  await Firebase.initializeApp();

  ///local notification...
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  AppNotificationHandler.getInitialMsg();
  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
  AppNotificationHandler.showMsgHandler();

  await AppNotificationHandler.getFcmToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BaseBinding(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

//  GetProfileViewModel

}

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => SubCategoryListLastViewModelController(), fenix: true);
    Get.lazyPut(() => WishListController(), fenix: true);
    Get.lazyPut(() => GetProfileViewModel(), fenix: true);
    Get.lazyPut(() => OTPVerifyViewModel(), fenix: true);
    Get.lazyPut(() => UpdateUserAppInfoViewModel(), fenix: true);
    Get.lazyPut(() => CartAndWishCountController(), fenix: true);
    Get.lazyPut(() => GetWishListViewModel(), fenix: true);
    Get.lazyPut(() => PostWishListViewModel(), fenix: true);
    Get.lazyPut(() => TableDataController(), fenix: true);
    Get.lazyPut(() => GetHomePageViewModel(), fenix: true);
    Get.lazyPut(() => UpdateSelectAddressViewModel(), fenix: true);
    Get.lazyPut(() => UpdateAddressSingleController(), fenix: true);
    Get.lazyPut(() => UpdateAddressViewModel(), fenix: true);
    Get.lazyPut(() => DeleteAddressViewModel(), fenix: true);
    Get.lazyPut(() => GetCityByStateViewModel(), fenix: true);
    Get.lazyPut(() => GetStateByCountryViewModel(), fenix: true);
    Get.lazyPut(() => SingleAllUserAddressViewModel(), fenix: true);
    Get.lazyPut(() => AddressCartController(), fenix: true);
    Get.lazyPut(() => GetAllUserAddressViewModel(), fenix: true);
    Get.lazyPut(() => AddAddressViewModel(), fenix: true);
    Get.lazyPut(() => AddressId(), fenix: true);
    Get.lazyPut(() => ProductDetailViewModel(), fenix: true);
    Get.lazyPut(() => BottomController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => SubCategoryController(), fenix: true);
    Get.lazyPut(() => SchoolController(), fenix: true);
    Get.lazyPut(() => SchoolDetailController(), fenix: true);
    Get.lazyPut(() => BookItemClassController(), fenix: true);
    Get.lazyPut(() => ColorController(), fenix: true);
    Get.lazyPut(() => FavouriteController(), fenix: true);
    Get.lazyPut(() => CategoryViewModel(), fenix: true);
    Get.lazyPut(() => SubCategoryViewModel(), fenix: true);
    Get.lazyPut(() => SchoolViewModel(), fenix: true);
    Get.lazyPut(() => SingleSchoolViewModelController(), fenix: true);
    Get.lazyPut(() => MainCategoriesSubcategoriesProductFilterViewModel(),
        fenix: true);
    Get.lazyPut(() => AddToCartViewModel(), fenix: true);
    Get.lazyPut(() => ProductDetailScreenController(), fenix: true);
    Get.lazyPut(() => CartViewModel(), fenix: true);
    Get.lazyPut(() => RemoveCartViewModel(), fenix: true);
    Get.lazyPut(() => FilterPersonalCallBottomViewModel(), fenix: true);
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => UpdateCartViewModel(), fenix: true);
    Get.lazyPut(() => FilterDataController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => SchoolController(), fenix: true);
    Get.lazyPut(() => PrePaymentViewModel(), fenix: true);
    Get.lazyPut(() => PaymentSuccessViewModel(), fenix: true);
    Get.lazyPut(() => VariationInfo2ViewModel(), fenix: true);
    Get.lazyPut(() => PurchaseHistoryViewModel(), fenix: true);
    Get.lazyPut(() => PurchaseHistoryDeliveredViewModel(), fenix: true);
    Get.lazyPut(() => OrderCancelUserViewModel(), fenix: true);
    Get.lazyPut(() => PurchaseHistoryByOrderViewModel(), fenix: true);
    Get.lazyPut(() => OrderReqCancelUserViewModel(), fenix: true);
    Get.lazyPut(() => GetOrderReturnOptionViewModel(), fenix: true);
    Get.lazyPut(() => UpdateProfileViewModel(), fenix: true);
    Get.lazyPut(() => ReturnOrderReqViewModel(), fenix: true);
    Get.lazyPut(() => UserSubmitReviewViewModel(), fenix: true);
    Get.lazyPut(() => FilterCategoriesProductPostViewModel(), fenix: true);

    // TODO: implement dependencies
  }
}
