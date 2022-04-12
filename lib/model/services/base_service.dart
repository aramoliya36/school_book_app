abstract class BaseService<T> {
  // final String base_url = 'https://itunes.apple.com/search?term=';
  final String registerURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/user/create';
  final String loginURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/login/login_check';

  final String getOTPURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/otp/validate/1";
  final String addToCartURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/add_to_cart";
  final String updateCartURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/update_cart";
  final String removeCartURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/remove_cart";
  final String postWishListURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/product/product_in_user_wishlist";
  final String otpVerifyURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/otp/validate/0";
  final String getUserDetailURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/user_detail/1595922666X5f1fd8bb5f662/MOB/";
  final String updateUserDetailURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/update_user_detail";
  final String variationInfo2URL =
      "http://scprojects.in.net/projects/skoolmonk/api_/product/variations_stock_info";
  final String mainCategoriesSubcategoriesProductFilterURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/categories/categories_by_subcategories_product_post";
  final String updateMobileNoURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/update_user_mobile_number";
  final String forgotPasswordURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/login/forgot_password";
  final String resetpasswordURl =
      "http://scprojects.in.net/projects/skoolmonk/api_/login/reset_password";
  final String updateProfileURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/update_user_profile";
  final String allCategoryURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/categories/main_categories/";
  final String allSubCategoryURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/categories/get_main_categories_view_with_subcategory_subsubcategory/";
  final String getProductDetailURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/product/detail/";
  final String cartURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/cart_view/";
  final String allSchoolMURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/all_school/";
  final String singleSchoolURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/single_school/";
  final String filterCategoryURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/categories/categories_by_subcategories_product_post";
  final String imageUploadURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/image_upload";
  final String addAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/add_address";
  final String orderReturnReqURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/order_product_return_request";
  final String orderREPLACEReqURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/order_product_replace_request";
  final String updateAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/update_address_user";
  final String userSubmitReviewURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/user_submit_feedback";
  final String updateSelectAddressAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/update_selected_address_user";
  final String updateUserAppInfoURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/login/update_app_info";
  final String orderCancelURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/order_cancel_user";
  final String orderReqCancelURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/order_req_cancel_user";
  final String getUserAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/user_address/";
  final String getWishListURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/product/product_from_user_wishlist/";
  final String getOrderReturnReplaceURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/get_order_return_replace_options/1595922666X5f1fd8bb5f662/MOB/";
  final String getAllUserAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/user_all_address/";
  final String getStateByCountryURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/get_states_by_country_id/";
  final String getCityByStateURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/get_city_by_state_id/";
  final String DeleteAddressURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/user/delete_address_user";
  final String getHomePage =
      "http://scprojects.in.net/projects/skoolmonk/api_/home/homepage/";
  final String purchaseHistoryByOrderURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/purchase_history_by_order_no/1595922666X5f1fd8bb5f662/MOB/";
  final String purchaseHistoryURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/purchase/purchase_history/1595922666X5f1fd8bb5f662/MOB/";
  final String searchProductURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/product/find/1595922666X5f1fd8bb5f662/MOB/";
  final String getSchoolCityByStateId =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/get_school_city_by_state_id/1595922666X5f1fd8bb5f662/MOB/";
  final String getSchoolStatesByCountryId =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/get_school_states_by_country_id/1595922666X5f1fd8bb5f662/MOB/";
  final String getSchoolCountries =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/get_school_countries/1595922666X5f1fd8bb5f662/MOB";
  final String allSchoolURL =
      "http://scprojects.in.net/projects/skoolmonk/api_/app/all_school/1595922666X5f1fd8bb5f662/MOB/1";
  final String findSuggestionURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/product/find_suggestion';
  final String prePostPaymentURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/payment_call/payment_pre_post';
  final String paymentSuccessURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/payment_call/payment_final_status';
  final String filterCategoriesProductPostSuccessURL =
      'http://scprojects.in.net/projects/skoolmonk/api_/payment_call/payment_final_status';
}

///http://scprojects.in.net/projects/skoolmonk/api_/app/find_school_by_location/1595922666X5f1fd8bb5f662/MOB/1/101/4008
