import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/cart_count_method.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_bottom_button.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/add_to_cart_address_controller.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/colorChange_Controller.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/payment_req_model.dart';
import 'package:skoolmonk/model/reqestModel/pre_payment_call_requestModel.dart';
import 'package:skoolmonk/model/responseModel/cart_response_model.dart';
import 'package:skoolmonk/model/responseModel/get_all_user_address.dart';
import 'package:skoolmonk/model/responseModel/payment.dart';
import 'package:skoolmonk/model/responseModel/pre_payment_response_model.dart';
import 'package:skoolmonk/screens/addAddress/add_address_screen.dart';
import 'package:skoolmonk/screens/addCart/widget/cart_list.dart';
import 'package:skoolmonk/screens/addCart/widget/top_header_text.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/screens/myAddresses/my_addresses_screen.dart';
import 'package:skoolmonk/screens/orederHistory/order_history.dart';
import 'package:skoolmonk/viewModel/cart_repo_view_model.dart';
import 'package:skoolmonk/viewModel/get_all_user_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/payment_succes_view_model.dart';
import 'package:skoolmonk/viewModel/pre_payment_call_viewmodel.dart';
import 'package:skoolmonk/viewModel/productDetail_view_model.dart';
import '../../common/shared_preference.dart';
import '../../viewModel/single_save_address_viewmodel.dart';

class AddCartScreen extends StatefulWidget {
  @override
  _AddCartScreenState createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  AddressCartController _addressCartController = Get.find();
  SingleAllUserAddressViewModel _singleAllUserAddressViewModel = Get.find();
  PaymentSuccessViewModel _paymentSuccessViewModel = Get.find();
  BottomController homeController = Get.find();
  PrePaymentReqModel _prePaymentReqModel = PrePaymentReqModel();
  GetAllUserAddressViewModel _getAllUserAddressViewModel = Get.find();
  ColorController _controller = Get.find();
  CartViewModel _cartViewModel = Get.find();
  SubCategoryController subCategoryController = Get.find();
  ProductDetailViewModel _productDetailViewModel = Get.find();
  PrePaymentViewModel _prePaymentViewModel = Get.find();
  ProductDetailScreenController _productDetailScreenController = Get.find();
  PrePaymentCallResponseModel responseO;
  PaymentSuccessReq _paymentSuccessReq = PaymentSuccessReq();
  static MethodChannel _channel = MethodChannel('easebuzz');
  TextEditingController _apply = TextEditingController();
  String mERCHANTKEY;
  String salT;
  String env;
  @override
  void initState() {
    _getAllUserAddressViewModel.getAllUserAddressViewModel();
    _cartViewModel.cartViewModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        colorController.colorChange.value = 10;

        homeController.selectedScreen("HomeScreen");
        homeController.bottomIndex.value = 0;
        //  Get.back();
        // Get.offAll(() => AddCartScreen());

        // homeController.setSelectedScreen()
        return Future.value(false);
      },
      child: Scaffold(
        // backgroundColor: Color(0xffF5F6F7),
        appBar: _buildAppBar(),
        body: GetBuilder<CartViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return circularProgress();
            }
            if (controller.apiResponse.status == Status.ERROR) {
              return Material(
                  color: Colors.white, child: Center(child: serverErrorText()));
            }
            // List<int> selectedPbd = [];
            if (controller.apiResponse.status == Status.COMPLETE) {
              CartResponse response = controller.apiResponse.data;
              return ModalProgressHUD(
                  inAsyncCall: controller.checkoutPro,
                  progressIndicator: circularProgress(),
                  child:
                      _buildBody(response: response, controller: controller));
            } else {
              return circularProgress();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {
          _controller.colorChange.value = 10;
          homeController.selectedScreen("HomeScreen");
          homeController.bottomIndex.value = 0;
          // Get.back();
          //Get.offAll(() => NavigationBarScreen());
          //  Get.back();
        },
        appTitle: "View Cart",
        leadingIcon: Icons.arrow_back_rounded);
  }

  Widget _buildBody({CartResponse response, CartViewModel controller}) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        cartListTopHeaderText(response: response),
        response.response.isEmpty
            ? SizedBox()
            : Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Delivery Price ₹${response.response[0].cartInfo[0].finalDeliveryPrice ?? ''}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
        // Align(
        //     alignment: Alignment.bottomRight,
        //     child: Text(
        //       'Delivery Price',
        //     )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        GetBuilder<GetAllUserAddressViewModel>(
          builder: (userAddressController) {
            if (userAddressController.apiResponse.status == Status.COMPLETE) {
              GetAllUserAddressResponse sResponse =
                  userAddressController.apiResponse.data;

              sResponse.response.forEach((element) {
                if (element.isSelected == '1') {
                  _addressCartController.clearSingleAddressCartScreen();
                  print('----------------------${element.fname}');
                  _addressCartController.singleAddressCartScreen(element);
                  // _addressCartController.setSingleAddress(
                  //     singleAddress: element);
                }
              });
              return sResponse.status == 400
                  ? MaterialButton(
                      color: ColorPicker.themColor,
                      onPressed: () {
                        Get.to(AddAddress());
                      },
                      child: Text('Add Address'),
                    )
                  : GetBuilder<AddressCartController>(
                      builder: (subController) {
                        return subController.schoolCatProductList.isEmpty
                            ? MaterialButton(
                                color: ColorPicker.navyBlue,
                                onPressed: () {
                                  _singleAllUserAddressViewModel
                                      .singleAllUserAddressViewModel();

                                  Get.to(MyAddressScreen());
                                },
                                child: Text(
                                  'Select Address',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  // color: Colors.deepOrange,
                                  width: Get.width,
                                  // height: Get.height / 9,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: Get.width / 1.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Deliver to :',
                                                style: TextStyle(
                                                    fontSize: Get.width / 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: Get.height / 130,
                                              ),
                                              Text(
                                                '${subController.schoolCatProductList[0].address1 ?? ''} ${subController.schoolCatProductList[0].city ?? ''} ${subController.schoolCatProductList[0].state ?? ''} ${subController.schoolCatProductList[0].pincode ?? ''} \n${subController.schoolCatProductList[0].mobile ?? ''}',
                                                style: TextStyle(),
                                                // overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        color: ColorPicker.navyBlue,
                                        onPressed: () {
                                          _singleAllUserAddressViewModel
                                              .singleAllUserAddressViewModel();
                                          Get.to(MyAddressScreen());
                                        },
                                        child: Text(
                                          'Change',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        response.response.isEmpty
            ? SizedBox()
            : Container(
                alignment: Alignment.centerLeft,
                height: Get.height * 0.04,
                width: Get.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.height * 0.02),
                  child: Text(
                    "My Cart Items",
                    style: TextStyle(
                        fontSize: Get.height * 0.023,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
        response.response.isEmpty
            ? SizedBox()
            : Divider(
                thickness: 2,
              ),
        cartList(response),
        response.response.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: Get.width / 1.36,
                            child: TextFormField(
                              controller: _apply,
                              decoration: InputDecoration(
                                hintText: 'Enter Coupon Code',
                                focusColor: ColorPicker.navyBlue,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                focusedBorder: OutlineInputBorder(),
                                disabledBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MaterialButton(
                              minWidth: Get.width / 10,
                              color: ColorPicker.navyBlue,
                              onPressed: () {
                                if (_apply.text.isNotEmpty) {
                                  _cartViewModel.cartViewModel(
                                      applyCode: _apply.text, isLoading: false);
                                } else {
                                  CommonSnackBar.showSnackBar(
                                      successStatus: false,
                                      msg: "Enter the code");
                                }
                              },
                              child: Text(
                                'Apply',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      response.response.isEmpty
                          ? SizedBox()
                          : response.response[0].cartInfo[0].couponCodeStatus ==
                                  '200'
                              ? Text(
                                  '${response.response[0].cartInfo[0].couponCodeMsg}',
                                  style: TextStyle(color: Colors.green),
                                )
                              : SizedBox(),
                      response.response.isEmpty
                          ? SizedBox()
                          : response.response[0].cartInfo[0].couponCodeStatus ==
                                  '400'
                              ? Text(
                                  '${response.response[0].cartInfo[0].couponCodeMsg}',
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox(),
                    ],
                  ),
                ),
              ),
        response.response.isEmpty
            ? SizedBox()
            : bottomButton(onpress: () async {
                final tokenId = PreferenceManager.getTokenId();
                print("tokenId.....>$tokenId");
                if (tokenId == null) {
                  Get.to(SignInScreen());
                } else {
                  controller.checkoutPro = true;
                  _prePaymentReqModel.userId = PreferenceManager.getTokenId();
                  _prePaymentReqModel.paymentMethod = "online";
                  _prePaymentReqModel.paymentSource = "is buzz";
                  await _prePaymentViewModel.prePaymentViewModel(
                      model: _prePaymentReqModel);
                  responseO = _prePaymentViewModel.apiResponse.data;
                  /*$MERCHANT_KEY = "WDVNTJZ7UP";
        $SALT = "PMN634N0LG";
        $ENV = "test";*/
                  // $MERCHANT_KEY = "VE7G01JGYJ";
                  // $SALT = "CQCV09DVTX";
                  // $ENV = "prod";
                  String paymentGetway = 'test';
                  if (paymentGetway == 'test') {
                    mERCHANTKEY = "WDVNTJZ7UP";
                    salT = "PMN634N0LG";
                    env = "test";
                  } else {
                    mERCHANTKEY = "VE7G01JGYJ";
                    salT = "CQCV09DVTX";
                    env = "prod";
                  }

                  /// method channel call for payment......
                  if (responseO.status == 200) {
                    var orderData = responseO.response[0];
                    String txnid =
                        "${orderData.orderNo}"; //This txnid should be unique every time.
                    String amount =
                        "${double.parse("${orderData.orderTotalCost}").roundToDouble()}";

                    String productinfo = "Books";
                    String firstname = "${orderData.userName}";
                    String email = "${orderData.userEmail}";
                    String phone = "${orderData.userMobile}";
                    String s_url = "";
                    // String s_url = "https://www.bookmrk.in/";
                    String f_url = "";
                    // String f_url = "https://www.bookmrk.in/";
                    String key = mERCHANTKEY;
                    String udf1 = "";
                    String udf2 = "";
                    String udf3 = "";
                    String udf4 = "";
                    String udf5 = "";
                    String address1 = "${orderData.userAddress1}";
                    String address2 = "${orderData.userAddress2}";
                    String city = "${orderData.userCity}";
                    String state = "${orderData.userState}";
                    String country = "${orderData.userCountries}";
                    String zipcode = "${orderData.userPincode}";
                    String salt = salT;
                    String hash =
                        "${sha512.convert(utf8.encode("$key|$txnid|$amount|$productinfo|$firstname|$email|$udf1|$udf2|$udf3|$udf4|$udf5||||||$salt|$key"))}";
                    String pay_mode = env;
                    // String pay_mode = "production";
                    String unique_id = "${orderData.orderNo}";
                    // String unique_id = "11345";

                    Object parameters = {
                      "txnid": txnid,
                      "amount": amount,
                      "productinfo": productinfo,
                      "firstname": firstname,
                      "email": email,
                      "phone": phone,
                      "surl": s_url,
                      "furl": f_url,
                      "key": key,
                      "udf1": udf1,
                      "udf2": udf2,
                      "udf3": udf3,
                      "udf4": udf4,
                      "udf5": udf5,
                      "address1": address1,
                      "address2": address2,
                      "city": city,
                      "state": state,
                      "country": country,
                      "zipcode": zipcode,
                      "hash": hash,
                      "isMobile": "1",
                      "pay_mode": pay_mode,
                      "unique_id": unique_id
                    };
                    var paymentResponse;

                    try {
                      paymentResponse = await _channel
                          .invokeMethod("payWithEasebuzz", parameters)
                          .catchError((e) {
                        log('ERROR+>$e');
                      });
                    } catch (e) {
                      log('ERROR+>$e');
                    }

                    if (paymentResponse['result'] == "payment_failed") {
                      controller.checkoutPro = false;

                      CommonSnackBar.showSnackBar(
                          successStatus: false, msg: "Transaction Failed !");

                      // _productOrderProvider
                      //     .isProductRemovingFromCartInProgress =
                      //false;
                    } else if (paymentResponse['result'] == "user_cancelled") {
                      controller.checkoutPro = false;

                      CommonSnackBar.showSnackBar(
                          successStatus: false, msg: "Transaction Failed !");

                      // _productOrderProvider
                      //     .isProductRemovingFromCartInProgress =
                      // false;
                    }
                    print('------response-1---$paymentResponse');
                    _paymentSuccessReq.orderNo = orderData.orderNo;
                    _paymentSuccessReq.orderTotalCost =
                        orderData.orderTotalCost;
                    _paymentSuccessReq.orderStatus =
                        paymentResponse['payment_response']['status'];
                    _paymentSuccessReq.paymentResponse = '$paymentResponse';

                    await _paymentSuccessViewModel.paymentSuccessViewModel(
                        model: _paymentSuccessReq);
                    PaymentSuccessResponseModel paymentSuccessRes =
                        _paymentSuccessViewModel.apiResponse.data;
                    if (paymentSuccessRes.status == 200) {
                      CommonSnackBar.showSnackBar(
                          msg: 'Payment success', successStatus: true);
                      print('Success full response of api');
                      _cartViewModel.cartViewModel();
                      _productDetailScreenController.selectProductList.clear();

                      Future.delayed(Duration(seconds: 2), () {
                        countSetCart();
                        controller.checkoutPro = false;

                        Get.to(OrderHistory());
                      });
                    }
                  } else {
                    controller.checkoutPro = false;

                    CommonSnackBar.showSnackBar(
                        successStatus: false, msg: responseO.message);
                  }

                  // Get.to(AddCartScreen());
                }
              })
      ],
    );
  }
}
// http://scprojects.in.net/projects/skoolmonk/api_/purchase/cart_view/1595922666X5f1fd8bb5f662/MOB/10/0/C2022
