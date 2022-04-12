import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:skoolmonk/common/add_cartg_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/add_to_cart_button_controller.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/cart_count_method.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/common/whish_list_count_methode.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/favourite_button.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/controller/table_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/post_wishlist_req_model.dart';
import 'package:skoolmonk/model/reqestModel/remove_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/variation_info2_req.dart';
import 'package:skoolmonk/model/responseModel/add_to_cart_response_model.dart';
import 'package:skoolmonk/model/responseModel/variation_Info2_response_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/screens/productDetailScreen/widget/about_item_details.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/post_wishlist_view_model.dart';
import 'package:skoolmonk/viewModel/productDetail_view_model.dart';
import 'package:skoolmonk/model/responseModel/product_detail_response_model.dart';
import 'package:skoolmonk/viewModel/remove_cart_view_model.dart';
import 'package:skoolmonk/viewModel/variation_info2_viewmodel.dart';

import '../../common/coomon_snackbar.dart';

class ProductDetailScreen extends StatefulWidget {
  final Function onPress;
  final Function willPopScope;

  ProductDetailScreen({
    this.onPress,
    this.willPopScope,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  RemoveCartViewModel _removeCartViewModel = Get.find();

  PostWishListViewModel _postWishListViewModel = Get.find();
  SchoolDetailController _schoolDetailController = Get.find();
  ProductDetailViewModel _productDetailViewModel = Get.find();
  VariationInfo2ViewModel _variationInfo2ViewModel = Get.find();
  BottomController bottomController = Get.find();
  TableDataController _tableDataController = Get.find();
  String pbdId, isCheckTabel;

  ProductDetailScreenController _productDetailScreenController = Get.find();

  // bool _isCheckSelect = false;
  AddTo _addtoCartController = Get.put(AddTo());

  BottomController homeController = Get.find();

  FavouriteController favouriteController = Get.find();

  //dynamic _changeIndex = 0;
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  CarouselController _mainController = CarouselController();
  AddToCartViewModel _addToCartViewModel = Get.find();
  double isSubTotal = 0.0;
  int cartMainQ = 0;
  RxList<double> subTotalList = <double>[].obs;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  clearTextEditController() {
    _mobileNumberController.clear();
    _nameController.clear();
  }

  String dropdownValue;
  String dropdownValue1;
  Map dropdown;
  Map dropdown1;
  int index;
  List variationInfo2 = [];
  VariationInfo2ReqModel _userInfo2 = VariationInfo2ReqModel();
  @override
  void initState() {
    // TODO: implement initState
    cartMainQ = 0;
    _productDetailScreenController.isOrderCountRelated = 0;
    _tableDataController.tableMapList.clear();
    _tableDataController.isMandatoryTableList.clear();

    print('-----table list----${_tableDataController.tableMapList}');
    _productDetailScreenController.currentId = '';
    _productDetailViewModel.productDetailViewModel(
        slugName: _schoolDetailController.titleSlugProductDetailsScreen);
  }

  @override
  void dispose() {
    _productDetailScreenController.setIsSelectBookSet(type: false);

    _tableDataController.tableMapList.clear();
    _tableDataController.isMandatoryTableList.clear();

    _productDetailScreenController.clearSelectProductList();
    super.dispose();
  }

  double sum = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.widget.willPopScope,
      child: GetBuilder<ProductDetailViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.LOADING) {
            return circularProgress();
          }
          if (controller.apiResponse.status == Status.ERROR) {
            return Material(
                color: Colors.white, child: Center(child: serverErrorText()));
          }
          if (controller.apiResponse.status == Status.COMPLETE) {
            ProductDetailResponse response = controller.apiResponse.data;
            // print(
            //     '-------varia---${response.response[0].variationsDetails[0].varValue[0].variationsOptionsName}');
            String bookSetCustomType =
                response.response[0].booksetCustomizeableType;
            String inStockStatus = response.response[0].productStockStatus;

            _productDetailScreenController.clearPbdList();
            _productDetailScreenController.resetCheckBoxValue();
            _productDetailScreenController.resetIsChangeIndex();
            _productDetailScreenController.resetRelatedChangeIndex();
            isSubTotal = 0.0;
            _tableDataController.tableMapList.clear();
            _tableDataController.isMandatoryTableList.clear();

            if (bookSetCustomType == '3') {
              _productDetailScreenController.setIsSelectBookSet(type: true);
              final listBookset = response.response[0].booksetDetails;

              log("message ELSE $listBookset ");
              listBookset.forEach((element) {
                element.productInfo.forEach((e) {
                  if (e.productStockStatus == 'IN') {
                    _tableDataController.addAllBookset(
                        bookSetName: element.pbdId,
                        pId: e.productId,
                        price: e.productSalePriceOg);
                  }
                });
              });
            }

            ///is mandatory list add
            final listBookset = response.response[0].booksetDetails;

            listBookset.forEach((element) {
              element.productInfo.forEach((e) {
                if (element.isMandatory == '1') {
                  _tableDataController.addAllIsMandatoryBookset(
                      bookSetName: element.pbdId,
                      pId: e.productId,
                      price: e.productSalePriceOg);
                }
              });
            });

            return Scaffold(
              appBar: CommonAppBar.commonAppBar(
                  onPress: widget.onPress,
                  appTitle: response.response[0].categoryName ?? "",
                  leadingIcon: Icons.arrow_back_rounded),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: GetBuilder<TableDataController>(
                    builder: (tController) {
                      return GetBuilder<ProductDetailScreenController>(
                        builder: (productDetailScreenController) {
                          String productF =
                              response.response[0].productInUserCart;

                          productDetailScreenController
                              .setFirstProductCartValue(
                                  value: productF == ''
                                      ? 0
                                      : int.parse(response
                                          .response[0].productInUserCart));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      topViewSlider(response),
                                      response.response[0].productImgs.length ==
                                              1
                                          ? SizedBox()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                  response.response[0]
                                                      .productImgs.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              productDetailScreenController
                                                                          .isChangeIndex ==
                                                                      index
                                                                  ? Colors.black
                                                                  : Colors.grey,
                                                        ),
                                                      )),
                                            ),
                                    ],
                                  ),
                                  response.response[0].productDiscount
                                              .isEmpty ||
                                          response.response[0]
                                                  .productDiscount ==
                                              ''
                                      ? Container()
                                      : offStackWidget(response),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.height * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    likeWidget(response),
                                    productSalePrice(response),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'MRP',
                                                  style: CommonTextStyle.MRP,
                                                ),
                                                Text(
                                                  ' ₹ ${response.response[0].productPrice ?? ""}',
                                                  style: CommonTextStyle
                                                      .cancelPriceTextStyle,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Incl. of all taxes",
                                              style: CommonTextStyle.taxInclude,
                                            )
                                          ],
                                        ),
                                        Spacer(),

                                        ///on set
                                        // response.response[0].productType == 'Single'
                                        //     ? DropDownSet()
                                        //     : SizedBox(),
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        // AddToCartWidget

                                        // inStockStatus == "OUT"
                                        inStockStatus == "in"
                                            ? Text('View')
                                            : bookSetCustomType == '0'
                                                ? AddCartButton(
                                                    currentPageApiCall: () {
                                                      _productDetailViewModel
                                                          .productDetailViewModel(
                                                              slugName:
                                                                  _schoolDetailController
                                                                      .titleSlugProductDetailsScreen,
                                                              isLoading: false);
                                                    },
                                                    responsId: response
                                                        .response[0].productId,
                                                    curentId: response
                                                        .response[0].productId,
                                                    quantity: response
                                                        .response[0]
                                                        .productInUserCartQuantity,
                                                    dropdown: dropdown,
                                                    dropdown1: dropdown1,
                                                    dropdownValue1:
                                                        dropdownValue1,
                                                    dropdownValue:
                                                        dropdownValue,
                                                    variationCount: response
                                                        .response[0]
                                                        .howManyVariation,
                                                    variation: response
                                                        .response[0].variation,
                                                    onTapDecrement: () async {
                                                      if (PreferenceManager
                                                              .getTokenId() ==
                                                          null) {
                                                        return Get.to(
                                                            SignInScreen());
                                                      } else {
                                                        String pId = response
                                                            .response[0]
                                                            .productId;

                                                        int qnt = response
                                                                    .response[0]
                                                                    .productInUserCartQuantity ==
                                                                ''
                                                            ? 1
                                                            : int.parse(response
                                                                .response[0]
                                                                .productInUserCartQuantity);

                                                        print(
                                                            '---$qnt---quantity-----${response.response[0].productInUserCartQuantity}');
                                                        index = productDetailScreenController
                                                            .selectProductList
                                                            .indexWhere((element) =>
                                                                element.keys
                                                                    .toList()
                                                                    .contains(
                                                                        pId));
                                                        if (index == -1) {
                                                          productDetailScreenController
                                                              .setAddSelectProductList(
                                                                  id: response
                                                                      .response[
                                                                          0]
                                                                      .productId,
                                                                  quantity:
                                                                      qnt);
                                                          index = productDetailScreenController
                                                              .selectProductList
                                                              .indexWhere((element) =>
                                                                  element.keys
                                                                      .toList()
                                                                      .contains(
                                                                          pId));
                                                        }
                                                        print(
                                                            'INDEX...:$index');
                                                        if (index > -1) {
                                                          print(
                                                              'INDEX VALUE :${productDetailScreenController.selectProductList[index][pId]}');
                                                          if (productDetailScreenController
                                                                      .selectProductList[
                                                                  index][pId] >
                                                              1) {
                                                            if (response
                                                                    .response[0]
                                                                    .variation ==
                                                                'YES') {
                                                              if (dropdownValue !=
                                                                  null) {
                                                                if (dropdownValue !=
                                                                        null &&
                                                                    response.response[0]
                                                                            .howManyVariation ==
                                                                        "1") {
                                                                  productDetailScreenController
                                                                      .setDecrementSelectListProductQDec(
                                                                    pId,
                                                                    qnt,
                                                                  );
                                                                }
                                                                if (dropdownValue1 !=
                                                                        null &&
                                                                    response.response[0]
                                                                            .howManyVariation ==
                                                                        "2") {
                                                                  productDetailScreenController
                                                                      .setDecrementSelectListProductQDec(
                                                                    pId,
                                                                    qnt,
                                                                  );
                                                                  _userInfo2
                                                                          .userId =
                                                                      PreferenceManager
                                                                          .getTokenId();
                                                                  _userInfo2
                                                                          .productId =
                                                                      response
                                                                          .response[
                                                                              0]
                                                                          .productId;
                                                                  if (response
                                                                          .response[
                                                                              0]
                                                                          .howManyVariation ==
                                                                      "2") {
                                                                    variationInfo2 =
                                                                        [];
                                                                    variationInfo2
                                                                        .add(
                                                                            dropdown);
                                                                    variationInfo2
                                                                        .add(
                                                                            dropdown1);
                                                                  } else {
                                                                    variationInfo2 =
                                                                        [];

                                                                    variationInfo2
                                                                        .add(
                                                                            dropdown);
                                                                  }
                                                                  print(
                                                                      '---variationInfo2-----$variationInfo2');

                                                                  _userInfo2
                                                                          .variationsStock =
                                                                      variationInfo2;
                                                                  await _variationInfo2ViewModel
                                                                      .variationInfo2ViewModel(
                                                                          _userInfo2);
                                                                  VariationInfo2Response
                                                                      info2Response =
                                                                      _variationInfo2ViewModel
                                                                          .apiResponse
                                                                          .data;

                                                                  AddToCartReq
                                                                      _user =
                                                                      AddToCartReq();
                                                                  if (info2Response
                                                                          .status ==
                                                                      200) {
                                                                    _user.userId =
                                                                        PreferenceManager.getTokenId() ??
                                                                            '0';
                                                                    _user.productId =
                                                                        '${response.response[0].productId}';
                                                                    _user.qty =
                                                                        '${productDetailScreenController.selectProductList[index][pId]}';
                                                                    _user.studentName =
                                                                        '';
                                                                    _user.qtyUpdate =
                                                                        '1';

                                                                    _user.studentRoll =
                                                                        '';
                                                                    _user.pvsmId = info2Response
                                                                        .response[
                                                                            0]
                                                                        .pvsmId;
                                                                    _user.variationsnIfo =
                                                                        variationInfo2;
                                                                    _user.additionalSetInfo =
                                                                        '';

                                                                    _user.pbdId =
                                                                        '';
                                                                    _user.booksetCustomize =
                                                                        '';
                                                                    _user.booksetProductIds =
                                                                        '';

                                                                    _user.booksetCustomizeArray =
                                                                        '';

                                                                    await _addToCartViewModel
                                                                        .addToCartViewModel(
                                                                            model:
                                                                                _user)
                                                                        .then(
                                                                            (value) {
                                                                      _productDetailViewModel.productDetailViewModel(
                                                                          isLoading:
                                                                              false,
                                                                          slugName:
                                                                              _schoolDetailController.titleSlugProductDetailsScreen);
                                                                    });
                                                                    countSetCart();
                                                                  } else {
                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            false,
                                                                        msg:
                                                                            "Product not add in Cart");
                                                                  }
                                                                } else if (dropdownValue1 ==
                                                                        null &&
                                                                    response.response[0]
                                                                            .howManyVariation ==
                                                                        "2") {
                                                                  CommonSnackBar.showSnackBar(
                                                                      successStatus:
                                                                          false,
                                                                      msg:
                                                                          "Please select variation");
                                                                } else {
                                                                  _userInfo2
                                                                          .userId =
                                                                      PreferenceManager
                                                                          .getTokenId();
                                                                  _userInfo2
                                                                          .productId =
                                                                      response
                                                                          .response[
                                                                              0]
                                                                          .productId;
                                                                  if (response
                                                                          .response[
                                                                              0]
                                                                          .howManyVariation ==
                                                                      "1") {
                                                                    variationInfo2 =
                                                                        [];
                                                                    variationInfo2
                                                                        .add(
                                                                            dropdown);
                                                                  }
                                                                  _userInfo2
                                                                          .variationsStock =
                                                                      variationInfo2;
                                                                  await _variationInfo2ViewModel
                                                                      .variationInfo2ViewModel(
                                                                          _userInfo2);
                                                                  VariationInfo2Response
                                                                      info2Response =
                                                                      _variationInfo2ViewModel
                                                                          .apiResponse
                                                                          .data;

                                                                  AddToCartReq
                                                                      _user =
                                                                      AddToCartReq();
                                                                  if (info2Response
                                                                          .status ==
                                                                      200) {
                                                                    _user.userId =
                                                                        PreferenceManager.getTokenId() ??
                                                                            '0';
                                                                    _user.productId =
                                                                        '${response.response[0].productId}';
                                                                    _user.qty =
                                                                        '${productDetailScreenController.selectProductList[index][pId]}';
                                                                    _user.studentName =
                                                                        '';
                                                                    _user.qtyUpdate =
                                                                        '1';

                                                                    _user.studentRoll =
                                                                        '';
                                                                    _user.pvsmId = info2Response
                                                                        .response[
                                                                            0]
                                                                        .pvsmId;
                                                                    _user.variationsnIfo =
                                                                        variationInfo2;
                                                                    _user.additionalSetInfo =
                                                                        '';

                                                                    _user.pbdId =
                                                                        '';
                                                                    _user.booksetCustomize =
                                                                        '';
                                                                    _user.booksetProductIds =
                                                                        '';

                                                                    _user.booksetCustomizeArray =
                                                                        '';

                                                                    _addToCartViewModel
                                                                        .addToCartViewModel(
                                                                            model:
                                                                                _user)
                                                                        .then(
                                                                            (value) {
                                                                      _productDetailViewModel.productDetailViewModel(
                                                                          isLoading:
                                                                              false,
                                                                          slugName:
                                                                              _schoolDetailController.titleSlugProductDetailsScreen);
                                                                    });
                                                                  } else {
                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            false,
                                                                        msg:
                                                                            "Product not add in Cart");
                                                                  }
                                                                }
                                                              } else {
                                                                CommonSnackBar.showSnackBar(
                                                                    successStatus:
                                                                        false,
                                                                    msg:
                                                                        "Please select variation");
                                                              }
                                                            } else {
                                                              AddToCartReq
                                                                  _user =
                                                                  AddToCartReq();
                                                              productDetailScreenController
                                                                  .setDecrementSelectListProductQDec(
                                                                pId,
                                                                qnt,
                                                              );
                                                              _user.userId =
                                                                  PreferenceManager
                                                                          .getTokenId() ??
                                                                      '0';
                                                              _user.productId =
                                                                  '${response.response[0].productId}';
                                                              _user.qty =
                                                                  '${productDetailScreenController.selectProductList[index][pId]}';
                                                              _user.studentName =
                                                                  '';
                                                              _user.qtyUpdate =
                                                                  '1';

                                                              _user.studentRoll =
                                                                  '';
                                                              _user.pvsmId = '';
                                                              _user.variationsnIfo =
                                                                  [];
                                                              _user.additionalSetInfo =
                                                                  '';

                                                              _user.pbdId = '';
                                                              _user.booksetCustomize =
                                                                  '';
                                                              _user.booksetProductIds =
                                                                  '';

                                                              _user.booksetCustomizeArray =
                                                                  '';

                                                              _addToCartViewModel
                                                                  .addToCartViewModel(
                                                                      model:
                                                                          _user)
                                                                  .then(
                                                                      (value) {
                                                                _productDetailViewModel.productDetailViewModel(
                                                                    isLoading:
                                                                        false,
                                                                    slugName:
                                                                        _schoolDetailController
                                                                            .titleSlugProductDetailsScreen);
                                                              });
                                                            }
                                                          } else {
                                                            RemoveReqModel
                                                                _user =
                                                                RemoveReqModel();
                                                            _user.userId =
                                                                '${PreferenceManager.getTokenId()}';
                                                            _user.cartId =
                                                                '${response.response[0].productInUserCartId}';
                                                            _removeCartViewModel
                                                                .removeCartViewModel(
                                                                    model:
                                                                        _user)
                                                                .then(
                                                                    (value) async {
                                                              _productDetailViewModel
                                                                  .productDetailViewModel(
                                                                      isLoading:
                                                                          false,
                                                                      slugName:
                                                                          _schoolDetailController
                                                                              .titleSlugProductDetailsScreen);

                                                              productDetailScreenController
                                                                  .removeSelectProductList(
                                                                      key: response
                                                                          .response[
                                                                              0]
                                                                          .productId);
                                                              CommonSnackBar
                                                                  .showSnackBar(
                                                                      successStatus:
                                                                          true,
                                                                      msg:
                                                                          'Removed from cart.');

                                                              countSetCart();
                                                            });
                                                            print(
                                                                'remove from all');
                                                          }
                                                        }
                                                      }
                                                    },
                                                    onTapIncrement: () async {
                                                      if (PreferenceManager
                                                              .getTokenId() ==
                                                          null) {
                                                        return Get.to(
                                                            SignInScreen());
                                                      } else {
                                                        if (response.response[0]
                                                                .variation ==
                                                            'YES') {
                                                          if (dropdownValue !=
                                                              null) {
                                                            if (dropdownValue1 !=
                                                                    null &&
                                                                response
                                                                        .response[
                                                                            0]
                                                                        .howManyVariation ==
                                                                    "2") {
                                                              _userInfo2
                                                                      .userId =
                                                                  PreferenceManager
                                                                      .getTokenId();
                                                              _userInfo2
                                                                      .productId =
                                                                  response
                                                                      .response[
                                                                          0]
                                                                      .productId;
                                                              if (response
                                                                      .response[
                                                                          0]
                                                                      .howManyVariation ==
                                                                  "2") {
                                                                variationInfo2 =
                                                                    [];
                                                                variationInfo2
                                                                    .add(
                                                                        dropdown);
                                                                variationInfo2.add(
                                                                    dropdown1);
                                                              } else {
                                                                variationInfo2 =
                                                                    [];

                                                                variationInfo2
                                                                    .add(
                                                                        dropdown);
                                                              }
                                                              _userInfo2
                                                                      .variationsStock =
                                                                  variationInfo2;
                                                              await _variationInfo2ViewModel
                                                                  .variationInfo2ViewModel(
                                                                      _userInfo2);
                                                              VariationInfo2Response
                                                                  info2Response =
                                                                  _variationInfo2ViewModel
                                                                      .apiResponse
                                                                      .data;
                                                              if (info2Response
                                                                      .status ==
                                                                  200) {
                                                                String pId = response
                                                                    .response[0]
                                                                    .productId;
                                                                int qnt = response
                                                                            .response[0]
                                                                            .productInUserCartQuantity ==
                                                                        ''
                                                                    ? 1
                                                                    : int.parse(
                                                                        response
                                                                            .response[0]
                                                                            .productInUserCartQuantity,
                                                                      );
                                                                print(
                                                                    '-----product detail---${response.response[0].productInUserCartQuantity}');
                                                                productDetailScreenController
                                                                    .setIncrementSelectListProductQInc(
                                                                  pId,
                                                                  qnt,
                                                                );

                                                                int index = productDetailScreenController
                                                                    .selectProductList
                                                                    .indexWhere((element) => element
                                                                        .keys
                                                                        .toList()
                                                                        .contains(
                                                                            pId));

                                                                AddToCartReq
                                                                    _user =
                                                                    AddToCartReq();

                                                                _user.userId =
                                                                    PreferenceManager
                                                                            .getTokenId() ??
                                                                        '0';
                                                                _user.productId =
                                                                    '${response.response[0].productId}';
                                                                _user.qty =
                                                                    '${productDetailScreenController.selectProductList[index][pId]}';
                                                                _user.studentName =
                                                                    '';

                                                                _user.studentRoll =
                                                                    '';
                                                                _user.pvsmId =
                                                                    info2Response
                                                                        .response[
                                                                            0]
                                                                        .pvsmId;
                                                                _user.qtyUpdate =
                                                                    '1';

                                                                _user.variationsnIfo =
                                                                    variationInfo2;
                                                                _user.additionalSetInfo =
                                                                    '';

                                                                _user.pbdId =
                                                                    '';
                                                                _user.booksetCustomize =
                                                                    '';
                                                                _user.booksetProductIds =
                                                                    '';

                                                                _user.booksetCustomizeArray =
                                                                    '';

                                                                _addToCartViewModel
                                                                    .addToCartViewModel(
                                                                        model:
                                                                            _user)
                                                                    .then(
                                                                        (value) {
                                                                  AddToCartResponse
                                                                      _addToCartResponse =
                                                                      _addToCartViewModel
                                                                          .apiResponse
                                                                          .data;
                                                                  _productDetailViewModel.productDetailViewModel(
                                                                      isLoading:
                                                                          false,
                                                                      slugName:
                                                                          _schoolDetailController
                                                                              .titleSlugProductDetailsScreen);
                                                                  if (_addToCartResponse
                                                                          .status ==
                                                                      200) {
                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            true,
                                                                        msg: _addToCartResponse
                                                                            .message);
                                                                  } else {
                                                                    productDetailScreenController
                                                                        .setDecrementSelectListProductQDec(
                                                                            pId,
                                                                            qnt);

                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            false,
                                                                        msg: _addToCartResponse
                                                                            .message);
                                                                  }
                                                                });
                                                              } else {
                                                                CommonSnackBar.showSnackBar(
                                                                    successStatus:
                                                                        false,
                                                                    msg:
                                                                        'Product not add in Cart');
                                                              }
                                                            } else if (dropdownValue1 ==
                                                                    null &&
                                                                response
                                                                        .response[
                                                                            0]
                                                                        .howManyVariation ==
                                                                    '2') {
                                                              CommonSnackBar
                                                                  .showSnackBar(
                                                                      successStatus:
                                                                          false,
                                                                      msg:
                                                                          "Please select variation");
                                                            } else {
                                                              _userInfo2
                                                                      .userId =
                                                                  PreferenceManager
                                                                      .getTokenId();
                                                              _userInfo2
                                                                      .productId =
                                                                  response
                                                                      .response[
                                                                          0]
                                                                      .productId;
                                                              if (response
                                                                      .response[
                                                                          0]
                                                                      .howManyVariation ==
                                                                  "2") {
                                                                variationInfo2 =
                                                                    [];
                                                                variationInfo2
                                                                    .add(
                                                                        dropdown);
                                                                variationInfo2.add(
                                                                    dropdown1);
                                                              } else {
                                                                variationInfo2 =
                                                                    [];

                                                                variationInfo2
                                                                    .add(
                                                                        dropdown);
                                                              }
                                                              _userInfo2
                                                                      .variationsStock =
                                                                  variationInfo2;
                                                              await _variationInfo2ViewModel
                                                                  .variationInfo2ViewModel(
                                                                      _userInfo2);
                                                              VariationInfo2Response
                                                                  info2Response =
                                                                  _variationInfo2ViewModel
                                                                      .apiResponse
                                                                      .data;

                                                              if (info2Response
                                                                      .status ==
                                                                  200) {
                                                                String pId = response
                                                                    .response[0]
                                                                    .productId;
                                                                int qnt = response
                                                                            .response[0]
                                                                            .productInUserCartQuantity ==
                                                                        ''
                                                                    ? 1
                                                                    : int.parse(
                                                                        response
                                                                            .response[0]
                                                                            .productInUserCartQuantity,
                                                                      );
                                                                print(
                                                                    '-----product detail---${response.response[0].productInUserCartQuantity}');
                                                                productDetailScreenController
                                                                    .setIncrementSelectListProductQInc(
                                                                  pId,
                                                                  qnt,
                                                                );

                                                                int index = productDetailScreenController
                                                                    .selectProductList
                                                                    .indexWhere((element) => element
                                                                        .keys
                                                                        .toList()
                                                                        .contains(
                                                                            pId));

                                                                AddToCartReq
                                                                    _user =
                                                                    AddToCartReq();

                                                                _user.userId =
                                                                    PreferenceManager
                                                                            .getTokenId() ??
                                                                        '0';
                                                                _user.productId =
                                                                    '${response.response[0].productId}';
                                                                _user.qty =
                                                                    '${productDetailScreenController.selectProductList[index][pId]}';
                                                                _user.studentName =
                                                                    '';

                                                                _user.studentRoll =
                                                                    '';
                                                                _user.pvsmId =
                                                                    info2Response
                                                                        .response[
                                                                            0]
                                                                        .pvsmId;
                                                                _user.qtyUpdate =
                                                                    '1';

                                                                _user.variationsnIfo =
                                                                    variationInfo2;
                                                                _user.additionalSetInfo =
                                                                    '';

                                                                _user.pbdId =
                                                                    '';
                                                                _user.booksetCustomize =
                                                                    '';
                                                                _user.booksetProductIds =
                                                                    '';

                                                                _user.booksetCustomizeArray =
                                                                    '';

                                                                _addToCartViewModel
                                                                    .addToCartViewModel(
                                                                        model:
                                                                            _user)
                                                                    .then(
                                                                        (value) {
                                                                  _productDetailViewModel.productDetailViewModel(
                                                                      isLoading:
                                                                          false,
                                                                      slugName:
                                                                          _schoolDetailController
                                                                              .titleSlugProductDetailsScreen);
                                                                  AddToCartResponse
                                                                      _addToCartResponse =
                                                                      _addToCartViewModel
                                                                          .apiResponse
                                                                          .data;
                                                                  if (_addToCartResponse
                                                                          .status ==
                                                                      200) {
                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            true,
                                                                        msg: _addToCartResponse
                                                                            .message);
                                                                  } else {
                                                                    productDetailScreenController
                                                                        .setDecrementSelectListProductQDec(
                                                                            pId,
                                                                            qnt);

                                                                    CommonSnackBar.showSnackBar(
                                                                        successStatus:
                                                                            false,
                                                                        msg: _addToCartResponse
                                                                            .message);
                                                                  }
                                                                });
                                                              } else {
                                                                CommonSnackBar.showSnackBar(
                                                                    successStatus:
                                                                        false,
                                                                    msg:
                                                                        'Product not add in Cart');
                                                              }
                                                            }
                                                          } else {
                                                            CommonSnackBar
                                                                .showSnackBar(
                                                                    successStatus:
                                                                        false,
                                                                    msg:
                                                                        "Please select variation");
                                                          }
                                                        } else {
                                                          String pId = response
                                                              .response[0]
                                                              .productId;
                                                          int qnt = response
                                                                      .response[
                                                                          0]
                                                                      .productInUserCartQuantity ==
                                                                  ''
                                                              ? 1
                                                              : int.parse(
                                                                  response
                                                                      .response[
                                                                          0]
                                                                      .productInUserCartQuantity,
                                                                );
                                                          productDetailScreenController
                                                              .setIncrementSelectListProductQInc(
                                                            pId,
                                                            qnt,
                                                          );
                                                          print(
                                                              '-----product detail---${response.response[0].productInUserCartQuantity}');

                                                          int index = productDetailScreenController
                                                              .selectProductList
                                                              .indexWhere((element) =>
                                                                  element.keys
                                                                      .toList()
                                                                      .contains(
                                                                          pId));

                                                          AddToCartReq _user =
                                                              AddToCartReq();

                                                          _user.userId =
                                                              PreferenceManager
                                                                      .getTokenId() ??
                                                                  '0';
                                                          _user.productId =
                                                              '${response.response[0].productId}';
                                                          _user.qty =
                                                              '${productDetailScreenController.selectProductList[index][pId]}';
                                                          _user.studentName =
                                                              '';

                                                          _user.studentRoll =
                                                              '';
                                                          _user.pvsmId = '';
                                                          _user.qtyUpdate = '1';

                                                          _user.variationsnIfo =
                                                              [];
                                                          _user.additionalSetInfo =
                                                              '';

                                                          _user.pbdId = '';
                                                          _user.booksetCustomize =
                                                              '';
                                                          _user.booksetProductIds =
                                                              '';

                                                          _user.booksetCustomizeArray =
                                                              '';

                                                          _addToCartViewModel
                                                              .addToCartViewModel(
                                                                  model: _user)
                                                              .then((value) {
                                                            _productDetailViewModel
                                                                .productDetailViewModel(
                                                                    isLoading:
                                                                        false,
                                                                    slugName:
                                                                        _schoolDetailController
                                                                            .titleSlugProductDetailsScreen);
                                                            AddToCartResponse
                                                                _addToCartResponse =
                                                                _addToCartViewModel
                                                                    .apiResponse
                                                                    .data;
                                                            if (_addToCartResponse
                                                                    .status ==
                                                                200) {
                                                              CommonSnackBar.showSnackBar(
                                                                  successStatus:
                                                                      true,
                                                                  msg: _addToCartResponse
                                                                      .message);
                                                            } else {
                                                              productDetailScreenController
                                                                  .setDecrementSelectListProductQDec(
                                                                      pId, qnt);

                                                              CommonSnackBar.showSnackBar(
                                                                  successStatus:
                                                                      false,
                                                                  msg: _addToCartResponse
                                                                      .message);
                                                            }
                                                          });
                                                        }
                                                      }
                                                    },
                                                  )
                                                : Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Ink(
                                                      height: Get.height * 0.04,
                                                      width: Get.width * 0.19,
                                                      decoration: BoxDecoration(
                                                          color: ColorPicker
                                                              .navyBlue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        onTap: () {
                                                          addDi(
                                                              response:
                                                                  response,
                                                              bookSetCustomType:
                                                                  bookSetCustomType,
                                                              productDetailScreenController:
                                                                  productDetailScreenController);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              size: Get.height *
                                                                  0.03,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              "ADD",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.02,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    response.response[0].variation == 'YES'
                                        ? Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${response.response[0].variationsDetails[0].variationsDisplay}'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: Get.height * 0.035,
                                                    width: Get.width * 0.25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 5)
                                                        ]),
                                                    child:
                                                        DropdownButton<String>(
                                                      isExpanded: true,
                                                      // value: dropdownValue,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: Text(
                                                            '${dropdownValue != null ? dropdownValue : 'Select'}'),
                                                      ),
                                                      icon: Icon(
                                                        Icons.expand_more,
                                                        color: ColorPicker
                                                            .navyBlue,
                                                      ),
                                                      iconSize:
                                                          Get.height * 0.03,
                                                      elevation: 16,
                                                      underline: Container(
                                                        height: 2,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      onChanged:
                                                          (String newValue) {
                                                        setState(() {
                                                          // dropdownValue = newValue;
                                                          // selectedValueIndex = newValue;
                                                        });
                                                      },
                                                      items: response
                                                          .response[0]
                                                          .variationsDetails[0]
                                                          .varValue
                                                          .map(
                                                              (var companiesData) {
                                                        return new DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              "$companiesData",
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                left:
                                                                    Get.height *
                                                                        0.006),
                                                            child: new Text(
                                                              companiesData
                                                                  .variationsOptionsName,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.017),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            print(
                                                                'drop value${companiesData.variationsOptionsName}');
                                                            dropdownValue =
                                                                companiesData
                                                                    .variationsOptionsName;
                                                            dropdown = {
                                                              "variations_data_id":
                                                                  "${companiesData.variationsDataId}",
                                                              "variations_options_name":
                                                                  "${companiesData.variationsOptionsName}",
                                                              "variation_name":
                                                                  "${companiesData.variationName}",
                                                              "var_img":
                                                                  "${companiesData.varImg}",
                                                            };
                                                            print(
                                                                '-------dropdown---value--$dropdown');

                                                            setState(() {});
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              response
                                                          .response[0]
                                                          .variationsDetails
                                                          .length ==
                                                      1
                                                  ? SizedBox()
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${response.response[0].variationsDetails[1].variationsDisplay}'),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          height: Get.height *
                                                              0.035,
                                                          width:
                                                              Get.width * 0.25,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                      color: Colors
                                                                          .grey),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius:
                                                                        5)
                                                              ]),
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            //value: dropdownValue1,

                                                            hint: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                              child: Text(
                                                                  '${dropdownValue1 != null ? dropdownValue1 : "Select"}'),
                                                            ),
                                                            icon: Icon(
                                                              Icons.expand_more,
                                                              color: ColorPicker
                                                                  .navyBlue,
                                                            ),
                                                            iconSize:
                                                                Get.height *
                                                                    0.03,
                                                            elevation: 16,
                                                            underline:
                                                                Container(
                                                              height: 2,
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                            onChanged: (String
                                                                newValue) {
                                                              // controller.setDropdownValue(
                                                              //     newValue);

                                                              // setState(() {
                                                              //   // selectedValueIndex = newValue;
                                                              // });
                                                            },
                                                            items: response
                                                                .response[0]
                                                                .variationsDetails[
                                                                    1]
                                                                .varValue
                                                                .map(
                                                                    (var companiesData) {
                                                              return new DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    "$companiesData",
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: Get
                                                                              .height *
                                                                          0.006),
                                                                  child:
                                                                      new Text(
                                                                    companiesData
                                                                        .variationsOptionsName,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Get.height *
                                                                                0.017),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  print(
                                                                      'drop value${companiesData.variationsOptionsName}');
                                                                  dropdownValue1 =
                                                                      companiesData
                                                                          .variationsOptionsName;
                                                                  dropdown1 = {
                                                                    "variations_data_id":
                                                                        "${companiesData.variationsDataId}",
                                                                    "variations_options_name":
                                                                        "${companiesData.variationsOptionsName}",
                                                                    "variation_name":
                                                                        "${companiesData.variationName}",
                                                                    "var_img":
                                                                        "${companiesData.varImg}",
                                                                  };
                                                                  print(
                                                                      '-------dropdown1---value--$dropdown');
                                                                  setState(
                                                                      () {});
                                                                },
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    aboutItemDetail(response),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    bookSetCustomType == '0'
                                        ? SizedBox()
                                        : bookSetCustomType == '2'
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        )),
                                                    height: 40,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Center(
                                                            child: Text(
                                                              'Select',
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                          height: 40,
                                                          width: Get.width / 7,
                                                        ),
                                                        VerticalDivider(
                                                          color: Colors.black,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: Get.width / 3,
                                                          child: Center(
                                                            child: Text(
                                                              'Particular',
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color: Colors.black,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: Get.width / 13,
                                                          child: Center(
                                                            child: Text(
                                                              'Qty',
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color: Colors.black,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          // width: Get.width / 5.6,
                                                          width: Get.width / 7,
                                                          child: Center(
                                                            child: Text(
                                                              ' Price  ',
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: response
                                                        .response[0]
                                                        .booksetDetails
                                                        .length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      String bookSETName =
                                                          response
                                                              .response[0]
                                                              .booksetDetails[
                                                                  index]
                                                              .pbdId;
                                                      String pbdIdProduct =
                                                          response
                                                              .response[0]
                                                              .booksetDetails[
                                                                  index]
                                                              .pbdId;
                                                      List<ProductInfo>
                                                          productInfo = response
                                                              .response[0]
                                                              .booksetDetails[
                                                                  index]
                                                              .productInfo;
                                                      Map<
                                                              String,
                                                              List<
                                                                  Map<String,
                                                                      String>>>
                                                          map = tController
                                                              .isMandatoryTableList;
                                                      String booksetName =
                                                          response
                                                              .response[0]
                                                              .booksetDetails[
                                                                  index]
                                                              .pbdId;
                                                      // BooksetDetail
                                                      //     bookSetDetail =
                                                      //     response.response[0]
                                                      //             .booksetDetails[
                                                      //         index];
                                                      var allStock = response
                                                          .response[0]
                                                          .booksetDetails[index]
                                                          .isMainBooksetShow;
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                    )),
                                                            height: 40,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width:
                                                                      Get.width /
                                                                          7,

                                                                  ///is mandatory check
                                                                  child: allStock ==
                                                                          '1'
                                                                      ? Checkbox(
                                                                          value: response.response[0].booksetDetails[index].isMandatory == '1'
                                                                              ? true
                                                                              : map.keys.contains(booksetName)
                                                                                  ? map[booksetName].isEmpty
                                                                                      ? false
                                                                                      : true
                                                                                  : false,
                                                                          activeColor:
                                                                              Colors.grey,
                                                                          onChanged:
                                                                              (value) {
                                                                            if (response.response[0].booksetDetails[index].isMandatory ==
                                                                                '1') {
                                                                            } else {
                                                                              if (map.keys.contains(booksetName)) {
                                                                                if (map[booksetName].isEmpty) {
                                                                                  productInfo.forEach((element) {
                                                                                    tController.addIsMandatoryParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                    tController.addIsMandatoryPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                  });
                                                                                } else {
                                                                                  tController.clearIsMandatorySubcategory(bookSetName: booksetName);
                                                                                  tController.removeIsMandatoryPrice(bookSetName: booksetName);
                                                                                }
                                                                              } else {
                                                                                productInfo.forEach((element) {
                                                                                  tController.addIsMandatoryParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                  tController.addIsMandatoryPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                });
                                                                              }
                                                                            }
                                                                          },
                                                                        )
                                                                      : SizedBox(),
                                                                ),
                                                                VerticalDivider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 1,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                      style: CommonTextStyle
                                                                          .aboutThisItemTextStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: response
                                                                .response[0]
                                                                .booksetDetails[
                                                                    index]
                                                                .productInfo
                                                                .length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    subindex) {
                                                              String
                                                                  booksetName =
                                                                  response
                                                                      .response[
                                                                          0]
                                                                      .booksetDetails[
                                                                          index]
                                                                      .pbdId;
                                                              String booksetId =
                                                                  response
                                                                      .response[
                                                                          0]
                                                                      .booksetDetails[
                                                                          index]
                                                                      .booksetId;
                                                              String opdId = response
                                                                  .response[0]
                                                                  .booksetDetails[
                                                                      index]
                                                                  .productInfo[
                                                                      subindex]
                                                                  .productId;

                                                              String price = response
                                                                  .response[0]
                                                                  .booksetDetails[
                                                                      index]
                                                                  .productInfo[
                                                                      subindex]
                                                                  .productSalePriceOg;
                                                              String inStock = response
                                                                  .response[0]
                                                                  .booksetDetails[
                                                                      index]
                                                                  .productInfo[
                                                                      subindex]
                                                                  .productStockStatus;

                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                                height: 40,
                                                                child: GetBuilder<
                                                                    TableDataController>(
                                                                  builder:
                                                                      (TableController) {
                                                                    ///SUB CATEGORY CHILD CHECK BOX....
                                                                    if (tController
                                                                        .isMandatoryTableList
                                                                        .containsKey(
                                                                            booksetName)) {
                                                                      int index = tController
                                                                          .isMandatoryTableList[
                                                                              booksetName]
                                                                          .indexWhere((element) =>
                                                                              element.containsKey(opdId));
                                                                    }
                                                                    return Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              Get.width / 7,
                                                                          child:
                                                                              SizedBox(),
                                                                        ),
                                                                        VerticalDivider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              1,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              Get.width / 3,
                                                                          child:
                                                                              Text(
                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                        VerticalDivider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              1,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              Get.width / 13,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        VerticalDivider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              1,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              Get.width / 6,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePriceOg ?? ''}',
                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          productDetailScreenController
                                                                  .isTypeBookSet
                                                              ? Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                  height: 40,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Sub Total',
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: Get.width /
                                                                            1.56,
                                                                      ),
                                                                      // VerticalDivider(
                                                                      //   color: Colors.black,
                                                                      //   thickness: 1,
                                                                      // ),
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            Get.width /
                                                                                5,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            tController.tableMapList.isEmpty
                                                                                ? '0'
                                                                                : tController.tableMapList[bookSETName] == null
                                                                                    ? '0'
                                                                                    : tController.tableMapList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toString(),
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                  height: 40,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Sub Total',
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: Get.width /
                                                                            1.56,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            Get.width /
                                                                                5,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            tController.isMandatoryTableList.isEmpty
                                                                                ? '0'
                                                                                : tController.isMandatoryTableList[bookSETName] == null
                                                                                    ? '0'
                                                                                    : tController.isMandatoryTableList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toStringAsFixed(2),
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        )),
                                                    height: 40,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Center(
                                                            child: Text(
                                                              'Final Total',
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                          height: 40,
                                                          width:
                                                              Get.width / 1.56,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: Get.width / 5,
                                                          child: Center(
                                                            child: Text(
                                                              tController
                                                                      .isMandatoryTableList
                                                                      .isEmpty
                                                                  ? '0'
                                                                  : tController
                                                                      .isMandatoryTableList
                                                                      .values
                                                                      .toList()
                                                                      .fold(
                                                                          0,
                                                                          (previousValue, element) =>
                                                                              previousValue +
                                                                              element.fold(0, (previousValue, e) => previousValue + double.parse(e.values.toList()[0])))
                                                                      .toStringAsFixed(2),
                                                              style: CommonTextStyle
                                                                  .aboutThisItemTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : bookSetCustomType == '1'
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width / 60,
                                                          ),

                                                          ///PARENT CHECK BOX.....
                                                          bookSetCustomType ==
                                                                  '0'
                                                              ? SizedBox()
                                                              : bookSetCustomType ==
                                                                      '2'
                                                                  ? SizedBox()
                                                                  : bookSetCustomType ==
                                                                          '3'
                                                                      ? Checkbox(
                                                                          activeColor:
                                                                              Colors.grey,
                                                                          value:
                                                                              true,
                                                                          onChanged:
                                                                              (value) {},
                                                                        )
                                                                      : Checkbox(
                                                                          activeColor:
                                                                              Colors.grey,
                                                                          value:
                                                                              productDetailScreenController.isTypeBookSet ?? false,
                                                                          onChanged:
                                                                              (value) {
                                                                            final listBookset =
                                                                                response.response[0].booksetDetails;
                                                                            productDetailScreenController.setIsSelectBookSet(type: value);
                                                                            if (!value) {
                                                                              log("message");
                                                                              _productDetailScreenController.setTotalPrice(addValue: 0.0);
                                                                              tController.allListClear();
                                                                            } else {
                                                                              log("message ELSE $listBookset ");
                                                                              listBookset.forEach((element) {
                                                                                element.productInfo.forEach((e) {
                                                                                  if (e.productStockStatus == 'IN') {
                                                                                    _tableDataController.addAllBookset(bookSetName: element.pbdId, pId: e.productId, price: e.productSalePriceOg);
                                                                                  }
                                                                                });
                                                                              });
                                                                              log("message ELSE  ${tController.tableMapList}");
                                                                            }
                                                                          },
                                                                        ),
                                                          bookSetCustomType ==
                                                                  '0'
                                                              ? SizedBox()
                                                              : bookSetCustomType ==
                                                                      '2'
                                                                  ? SizedBox()
                                                                  : bookSetCustomType ==
                                                                          '3'
                                                                      ? Text(
                                                                          'Custom',
                                                                          style:
                                                                              CommonTextStyle.cancelPrice,
                                                                        )
                                                                      : Text(
                                                                          'Custom'),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                        height: 40,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Center(
                                                                child: Text(
                                                                  'Select',
                                                                  style: CommonTextStyle
                                                                      .aboutThisItemTextStyle,
                                                                ),
                                                              ),
                                                              height: 40,
                                                              width:
                                                                  Get.width / 7,
                                                            ),
                                                            VerticalDivider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 1,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  Get.width / 3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Particular',
                                                                  style: CommonTextStyle
                                                                      .aboutThisItemTextStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            VerticalDivider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 1,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: Get.width /
                                                                  13,
                                                              child: Center(
                                                                child: Text(
                                                                  'Qty',
                                                                  style: CommonTextStyle
                                                                      .aboutThisItemTextStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            VerticalDivider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 1,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              // width: Get.width / 5.6,
                                                              width:
                                                                  Get.width / 7,
                                                              child: Center(
                                                                child: Text(
                                                                  ' Price  ',
                                                                  style: CommonTextStyle
                                                                      .aboutThisItemTextStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      productDetailScreenController
                                                              .isTypeBookSet
                                                          ? ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: response
                                                                  .response[0]
                                                                  .booksetDetails
                                                                  .length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                String
                                                                    bookSETName =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                String
                                                                    pbdIdProduct =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                List<ProductInfo>
                                                                    productInfo =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .productInfo;
                                                                Map<
                                                                        String,
                                                                        List<
                                                                            Map<String,
                                                                                String>>>
                                                                    map =
                                                                    tController
                                                                        .tableMapList;
                                                                String
                                                                    booksetName =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;

                                                                var allStock = response
                                                                    .response[0]
                                                                    .booksetDetails[
                                                                        index]
                                                                    .isMainBooksetShow;
                                                                return Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 7,
                                                                            child: allStock == '1'
                                                                                ? Checkbox(
                                                                                    value: map.keys.contains(booksetName)
                                                                                        ? map[booksetName].isEmpty
                                                                                            ? false
                                                                                            : true
                                                                                        : false,
                                                                                    activeColor: Colors.grey,
                                                                                    onChanged: (value) {
                                                                                      if (productDetailScreenController.isTypeBookSet) {
                                                                                        if (map.keys.contains(booksetName)) {
                                                                                          if (map[booksetName].isEmpty) {
                                                                                            productInfo.forEach((element) {
                                                                                              tController.addParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                              tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                            });
                                                                                          } else {
                                                                                            tController.clearSubcategory(bookSetName: booksetName);
                                                                                            tController.removePrice(bookSetName: booksetName);
                                                                                          }
                                                                                        } else {
                                                                                          productInfo.forEach((element) {
                                                                                            tController.addParentCategory(bookSetName: booksetName, productId: element.productId);
                                                                                            tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  )
                                                                                : SizedBox(),
                                                                          ),
                                                                          VerticalDivider(
                                                                            color:
                                                                                Colors.black,
                                                                            thickness:
                                                                                1,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: response
                                                                          .response[
                                                                              0]
                                                                          .booksetDetails[
                                                                              index]
                                                                          .productInfo
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              subindex) {
                                                                        String booksetName = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .pbdId;
                                                                        String booksetId = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .booksetId;
                                                                        String opdId = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productId;
                                                                        String price = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productSalePriceOg;
                                                                        String inStock = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productStockStatus;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                              )),
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              GetBuilder<TableDataController>(
                                                                            builder:
                                                                                (TableController) {
                                                                              ///SUB CATEGORY CHILD CHECK BOX....
                                                                              if (tController.tableMapList.containsKey(booksetName)) {
                                                                                int index = tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId));
                                                                              }
                                                                              return Row(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 7,
                                                                                    child: inStock == 'IN'
                                                                                        ? Checkbox(
                                                                                            activeColor: Colors.grey,
                                                                                            onChanged: (value) {
                                                                                              if (productDetailScreenController.isTypeBookSet) {
                                                                                                log("IS CHECK VALUE$value");
                                                                                                if (value == false) {
                                                                                                  // subTotal =
                                                                                                  //     0.0;
                                                                                                  // subTotalList
                                                                                                  //     .clear();
                                                                                                }
                                                                                                tController.addTableValue(key: booksetName, subKey: opdId, price: price);
                                                                                              }
                                                                                            },
                                                                                            value: tController.tableMapList.isEmpty
                                                                                                ? false
                                                                                                : tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId)) > -1
                                                                                                    ? true
                                                                                                    : false,
                                                                                          )
                                                                                        : SizedBox(),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    // height: 40,
                                                                                    width: Get.width / 3,
                                                                                    child: Text(
                                                                                      '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 13,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 6,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePriceOg ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    productDetailScreenController
                                                                            .isTypeBookSet
                                                                        ? Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                  color: Colors.grey,
                                                                                )),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Sub Total',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                  height: 40,
                                                                                  width: Get.width / 1.56,
                                                                                ),
                                                                                // VerticalDivider(
                                                                                //   color: Colors.black,
                                                                                //   thickness: 1,
                                                                                // ),
                                                                                Container(
                                                                                  height: 40,
                                                                                  width: Get.width / 5,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      tController.tableMapList.isEmpty
                                                                                          ? '0'
                                                                                          : tController.tableMapList[bookSETName] == null
                                                                                              ? '0'
                                                                                              : tController.tableMapList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toString(),
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                  color: Colors.grey,
                                                                                )),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Sub Total',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                  height: 40,
                                                                                  width: Get.width / 1.56,
                                                                                ),
                                                                                // VerticalDivider(
                                                                                //   color: Colors.black,
                                                                                //   thickness: 1,
                                                                                // ),
                                                                                Container(
                                                                                  height: 40,
                                                                                  width: Get.width / 5,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      response.response[0].booksetDetails[index].totalBooksetSalePrice ?? '',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                  ],
                                                                );
                                                              },
                                                            )
                                                          : ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: response
                                                                  .response[0]
                                                                  .booksetDetails
                                                                  .length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                String
                                                                    bookSETName =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                String
                                                                    pbdIdProduct =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                List<ProductInfo>
                                                                    productInfo =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .productInfo;
                                                                Map<
                                                                        String,
                                                                        List<
                                                                            Map<String,
                                                                                String>>>
                                                                    map =
                                                                    tController
                                                                        .isMandatoryTableList;
                                                                String
                                                                    booksetName =
                                                                    response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                // BooksetDetail
                                                                //     bookSetDetail =
                                                                //     response
                                                                //         .response[
                                                                //             0]
                                                                //         .booksetDetails[index];
                                                                var allStock = response
                                                                    .response[0]
                                                                    .booksetDetails[
                                                                        index]
                                                                    .isMainBooksetShow;
                                                                return Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 7,

                                                                            ///is mandatory check
                                                                            child: allStock == '1'
                                                                                ? Checkbox(
                                                                                    value: response.response[0].booksetDetails[index].isMandatory == '1'
                                                                                        ? true
                                                                                        : map.keys.contains(booksetName)
                                                                                            ? map[booksetName].isEmpty
                                                                                                ? false
                                                                                                : true
                                                                                            : false,
                                                                                    activeColor: Colors.grey,
                                                                                    onChanged: (value) {
                                                                                      if (response.response[0].booksetDetails[index].isMandatory == '1') {
                                                                                      } else {
                                                                                        if (map.keys.contains(booksetName)) {
                                                                                          if (map[booksetName].isEmpty) {
                                                                                            productInfo.forEach((element) {
                                                                                              tController.addIsMandatoryParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                              tController.addIsMandatoryPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                            });
                                                                                          } else {
                                                                                            tController.clearIsMandatorySubcategory(bookSetName: booksetName);
                                                                                            tController.removeIsMandatoryPrice(bookSetName: booksetName);
                                                                                          }
                                                                                        } else {
                                                                                          productInfo.forEach((element) {
                                                                                            tController.addIsMandatoryParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                            tController.addIsMandatoryPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  )
                                                                                : SizedBox(),
                                                                          ),
                                                                          VerticalDivider(
                                                                            color:
                                                                                Colors.black,
                                                                            thickness:
                                                                                1,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: response
                                                                          .response[
                                                                              0]
                                                                          .booksetDetails[
                                                                              index]
                                                                          .productInfo
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              subindex) {
                                                                        String booksetName = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .pbdId;
                                                                        String booksetId = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .booksetId;
                                                                        String opdId = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productId;
                                                                        String price = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productSalePriceOg;
                                                                        String inStock = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo[subindex]
                                                                            .productStockStatus;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                              )),
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              GetBuilder<TableDataController>(
                                                                            builder:
                                                                                (TableController) {
                                                                              ///SUB CATEGORY CHILD CHECK BOX....
                                                                              if (tController.isMandatoryTableList.containsKey(booksetName)) {
                                                                                int index = tController.isMandatoryTableList[booksetName].indexWhere((element) => element.containsKey(opdId));
                                                                              }
                                                                              return Row(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 7,
                                                                                    child: SizedBox(),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 3,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 13,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 6,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePriceOg ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    productDetailScreenController
                                                                            .isTypeBookSet
                                                                        ? Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                  color: Colors.grey,
                                                                                )),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Sub Total',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                  height: 40,
                                                                                  width: Get.width / 1.56,
                                                                                ),
                                                                                // VerticalDivider(
                                                                                //   color: Colors.black,
                                                                                //   thickness: 1,
                                                                                // ),
                                                                                Container(
                                                                                  height: 40,
                                                                                  width: Get.width / 5,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      tController.tableMapList.isEmpty
                                                                                          ? '0'
                                                                                          : tController.tableMapList[bookSETName] == null
                                                                                              ? '0'
                                                                                              : tController.tableMapList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toString(),
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                  color: Colors.grey,
                                                                                )),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Sub Total',
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                  height: 40,
                                                                                  width: Get.width / 1.56,
                                                                                ),
                                                                                Container(
                                                                                  height: 40,
                                                                                  width: Get.width / 5,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      tController.isMandatoryTableList.isEmpty
                                                                                          ? '0'
                                                                                          : tController.isMandatoryTableList[bookSETName] == null
                                                                                              ? '0'
                                                                                              : tController.isMandatoryTableList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toStringAsFixed(2),
                                                                                      style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                      productDetailScreenController
                                                              .isTypeBookSet
                                                          ? Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                      )),
                                                              height: 40,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Final Total',
                                                                        style: CommonTextStyle
                                                                            .aboutThisItemTextStyle,
                                                                      ),
                                                                    ),
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            1.56,
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            5,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        tController.tableMapList.isEmpty
                                                                            ? '0'
                                                                            : tController.tableMapList.values.toList().fold(0, (previousValue, element) => previousValue + element.fold(0, (previousValue, e) => previousValue + double.parse(e.values.toList()[0]))).toString(),
                                                                        style: CommonTextStyle
                                                                            .aboutThisItemTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                      )),
                                                              height: 40,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Final Total',
                                                                        style: CommonTextStyle
                                                                            .aboutThisItemTextStyle,
                                                                      ),
                                                                    ),
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            1.56,
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            5,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        tController.isMandatoryTableList.isEmpty
                                                                            ? '0'
                                                                            : tController.isMandatoryTableList.values.toList().fold(0, (previousValue, element) => previousValue + element.fold(0, (previousValue, e) => previousValue + double.parse(e.values.toList()[0]))).toStringAsFixed(2),
                                                                        style: CommonTextStyle
                                                                            .aboutThisItemTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                    ],
                                                  )
                                                : bookSetCustomType == '3'
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    Get.width /
                                                                        60,
                                                              ),

                                                              ///PARENT CHECK BOX.....
                                                              bookSetCustomType ==
                                                                      '0'
                                                                  ? SizedBox()
                                                                  : bookSetCustomType ==
                                                                          '2'
                                                                      ? SizedBox()
                                                                      : bookSetCustomType ==
                                                                              '3'
                                                                          ? Checkbox(
                                                                              activeColor: Colors.grey,
                                                                              value: productDetailScreenController.isTypeBookSet ?? false,
                                                                              onChanged: (value) {},
                                                                            )
                                                                          : Checkbox(
                                                                              activeColor: Colors.grey,
                                                                              value: productDetailScreenController.isTypeBookSet ?? false,
                                                                              onChanged: (value) {
                                                                                final listBookset = response.response[0].booksetDetails;
                                                                                productDetailScreenController.setIsSelectBookSet(type: value);
                                                                                if (!value) {
                                                                                  _productDetailScreenController.setTotalPrice(addValue: 0.0);
                                                                                  tController.allListClear();
                                                                                } else {
                                                                                  log("message ELSE $listBookset ");
                                                                                  listBookset.forEach((element) {
                                                                                    element.productInfo.forEach((e) {
                                                                                      if (e.productStockStatus == 'IN') {
                                                                                        _tableDataController.addAllBookset(bookSetName: element.pbdId, pId: e.productId, price: e.productSalePriceOg);
                                                                                      }
                                                                                    });
                                                                                  });
                                                                                  log("message ELSE  ${tController.tableMapList}");
                                                                                }
                                                                              },
                                                                            ),
                                                              bookSetCustomType ==
                                                                      '0'
                                                                  ? SizedBox()
                                                                  : bookSetCustomType ==
                                                                          '2'
                                                                      ? SizedBox()
                                                                      : bookSetCustomType ==
                                                                              '3'
                                                                          ? Text(
                                                                              'Custom',
                                                                              style: CommonTextStyle.cancelPrice,
                                                                            )
                                                                          : Text(
                                                                              'Custom'),
                                                            ],
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                    )),
                                                            height: 40,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Select',
                                                                      style: CommonTextStyle
                                                                          .aboutThisItemTextStyle,
                                                                    ),
                                                                  ),
                                                                  height: 40,
                                                                  width:
                                                                      Get.width /
                                                                          7,
                                                                ),
                                                                VerticalDivider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 1,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width:
                                                                      Get.width /
                                                                          3,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Particular',
                                                                      style: CommonTextStyle
                                                                          .aboutThisItemTextStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                                VerticalDivider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 1,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width:
                                                                      Get.width /
                                                                          13,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Qty',
                                                                      style: CommonTextStyle
                                                                          .aboutThisItemTextStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                                VerticalDivider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 1,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  // width: Get.width / 5.6,
                                                                  width:
                                                                      Get.width /
                                                                          7,
                                                                  child: Center(
                                                                    child: Text(
                                                                      ' Price  ',
                                                                      style: CommonTextStyle
                                                                          .aboutThisItemTextStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          bookSetCustomType ==
                                                                  '3'
                                                              ? ListView
                                                                  .builder(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemCount: response
                                                                      .response[
                                                                          0]
                                                                      .booksetDetails
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    String bookSETName = response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                    String pbdIdProduct = response
                                                                        .response[
                                                                            0]
                                                                        .booksetDetails[
                                                                            index]
                                                                        .pbdId;
                                                                    List<ProductInfo>
                                                                        productInfo =
                                                                        response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo;

                                                                    return Column(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                              )),
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              GetBuilder<ProductDetailScreenController>(
                                                                                builder: (subController) {
                                                                                  Map<String, List<Map<String, String>>> map = tController.tableMapList;
                                                                                  String booksetName = response.response[0].booksetDetails[index].pbdId;
                                                                                  List<ProductInfo> productInfo = response.response[0].booksetDetails[index].productInfo;
                                                                                  // BooksetDetail bookSetDetail = response.response[0].booksetDetails[index];
                                                                                  var allStock = response.response[0].booksetDetails[index].isMainBooksetShow;

                                                                                  ///SUB CATEGORY PARENT CHECK BOX....
                                                                                  return Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 7,
                                                                                    child: allStock == '1'
                                                                                        ? Checkbox(
                                                                                            value: map.keys.contains(booksetName)
                                                                                                ? map[booksetName].isEmpty
                                                                                                    ? false
                                                                                                    : true
                                                                                                : false,
                                                                                            activeColor: Colors.grey,
                                                                                            onChanged: (value) {
                                                                                              if (productDetailScreenController.isTypeBookSet) {
                                                                                                if (map.keys.contains(booksetName)) {
                                                                                                  if (map[booksetName].isEmpty) {
                                                                                                    productInfo.forEach((element) {
                                                                                                      tController.addParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                                      tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                                    });
                                                                                                  } else {
                                                                                                    tController.clearSubcategory(bookSetName: booksetName);
                                                                                                    tController.removePrice(bookSetName: booksetName);
                                                                                                  }
                                                                                                } else {
                                                                                                  productInfo.forEach((element) {
                                                                                                    tController.addParentCategory(bookSetName: booksetName, productId: element.productId);
                                                                                                    tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                                  });
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                          )
                                                                                        : SizedBox(),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              VerticalDivider(
                                                                                color: Colors.black,
                                                                                thickness: 1,
                                                                              ),
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                                    style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        ListView
                                                                            .builder(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          itemCount: response
                                                                              .response[0]
                                                                              .booksetDetails[index]
                                                                              .productInfo
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              (context, subindex) {
                                                                            String
                                                                                booksetName =
                                                                                response.response[0].booksetDetails[index].pbdId;
                                                                            String
                                                                                booksetId =
                                                                                response.response[0].booksetDetails[index].booksetId;
                                                                            String
                                                                                opdId =
                                                                                response.response[0].booksetDetails[index].productInfo[subindex].productId;
                                                                            String
                                                                                price =
                                                                                response.response[0].booksetDetails[index].productInfo[subindex].productSalePriceOg;
                                                                            String
                                                                                inStock =
                                                                                response.response[0].booksetDetails[index].productInfo[subindex].productStockStatus;
                                                                            return Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  border: Border.all(
                                                                                    color: Colors.grey,
                                                                                  )),
                                                                              height: 50,
                                                                              child: GetBuilder<TableDataController>(
                                                                                builder: (TableController) {
                                                                                  ///SUB CATEGORY CHILD CHECK BOX....
                                                                                  // if (tController.tableMapList.containsKey(booksetName)) {
                                                                                  //   int index = tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId));
                                                                                  // }
                                                                                  return Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 7,
                                                                                        child: inStock == 'IN'
                                                                                            ? Checkbox(
                                                                                                activeColor: Colors.grey,
                                                                                                onChanged: (value) {
                                                                                                  if (productDetailScreenController.isTypeBookSet) {
                                                                                                    log("IS CHECK VALUE$value");
                                                                                                    if (value == false) {
                                                                                                      // subTotal =
                                                                                                      //     0.0;
                                                                                                      // subTotalList
                                                                                                      //     .clear();
                                                                                                    }
                                                                                                    tController.addTableValue(key: booksetName, subKey: opdId, price: price);
                                                                                                  }
                                                                                                },
                                                                                                value: tController.tableMapList.isEmpty
                                                                                                    ? false
                                                                                                    : tController.tableMapList.containsKey(booksetName)
                                                                                                        ? tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId)) > -1
                                                                                                        : false
                                                                                                            ? true
                                                                                                            : false,
                                                                                              )
                                                                                            : SizedBox(),
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        // height: 40,
                                                                                        width: Get.width / 3,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                                            style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 13,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                                            style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 6,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePrice ?? ''}',
                                                                                            style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                        productDetailScreenController.isTypeBookSet
                                                                            ? Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    border: Border.all(
                                                                                      color: Colors.grey,
                                                                                    )),
                                                                                height: 40,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          'Sub Total',
                                                                                          style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                        ),
                                                                                      ),
                                                                                      height: 40,
                                                                                      width: Get.width / 1.56,
                                                                                    ),
                                                                                    // VerticalDivider(
                                                                                    //   color: Colors.black,
                                                                                    //   thickness: 1,
                                                                                    // ),
                                                                                    Container(
                                                                                      height: 40,
                                                                                      width: Get.width / 5,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          tController.tableMapList.isEmpty
                                                                                              ? '0'
                                                                                              : tController.tableMapList.containsKey(bookSETName)
                                                                                                  ? tController.tableMapList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toString()
                                                                                                  : "0",
                                                                                          style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    border: Border.all(
                                                                                      color: Colors.grey,
                                                                                    )),
                                                                                height: 40,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          'Sub Total',
                                                                                          style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                        ),
                                                                                      ),
                                                                                      height: 40,
                                                                                      width: Get.width / 1.56,
                                                                                    ),
                                                                                    // VerticalDivider(
                                                                                    //   color: Colors.black,
                                                                                    //   thickness: 1,
                                                                                    // ),
                                                                                    Container(
                                                                                      height: 40,
                                                                                      width: Get.width / 5,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          response.response[0].booksetDetails[index].totalBooksetSalePrice ?? '',
                                                                                          style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                      ],
                                                                    );
                                                                  },
                                                                )
                                                              : productDetailScreenController
                                                                      .isTypeBookSet
                                                                  ? ListView
                                                                      .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: response
                                                                          .response[
                                                                              0]
                                                                          .booksetDetails
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        String bookSETName = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .pbdId;
                                                                        String pbdIdProduct = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .pbdId;
                                                                        List<ProductInfo> productInfo = response
                                                                            .response[0]
                                                                            .booksetDetails[index]
                                                                            .productInfo;

                                                                        return Column(
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  border: Border.all(
                                                                                    color: Colors.grey,
                                                                                  )),
                                                                              height: 40,
                                                                              child: Row(
                                                                                children: [
                                                                                  GetBuilder<ProductDetailScreenController>(
                                                                                    builder: (subController) {
                                                                                      Map<String, List<Map<String, String>>> map = tController.tableMapList;
                                                                                      String booksetName = response.response[0].booksetDetails[index].pbdId;
                                                                                      List<ProductInfo> productInfo = response.response[0].booksetDetails[index].productInfo;
                                                                                      //  BooksetDetail bookSetDetail = response.response[0].booksetDetails[index];

                                                                                      ///SUB CATEGORY PARENT CHECK BOX....
                                                                                      return Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 7,
                                                                                        child: Checkbox(
                                                                                          value: map.keys.contains(booksetName)
                                                                                              ? map[booksetName].isEmpty
                                                                                                  ? false
                                                                                                  : true
                                                                                              : false,
                                                                                          activeColor: Colors.grey,
                                                                                          onChanged: (value) {
                                                                                            if (productDetailScreenController.isTypeBookSet) {
                                                                                              if (map.keys.contains(booksetName)) {
                                                                                                if (map[booksetName].isEmpty) {
                                                                                                  productInfo.forEach((element) {
                                                                                                    tController.addParentCategory(bookSetName: booksetName, productId: element.productId, price: element.productSalePriceOg);
                                                                                                    tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                                  });
                                                                                                } else {
                                                                                                  tController.clearSubcategory(bookSetName: booksetName);
                                                                                                  tController.removePrice(bookSetName: booksetName);
                                                                                                }
                                                                                              } else {
                                                                                                productInfo.forEach((element) {
                                                                                                  tController.addParentCategory(bookSetName: booksetName, productId: element.productId);
                                                                                                  tController.addPrice(bookSetName: booksetName, bookSetPrice: element.productSalePriceOg);
                                                                                                });
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            ListView.builder(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: response.response[0].booksetDetails[index].productInfo.length,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, subindex) {
                                                                                String booksetName = response.response[0].booksetDetails[index].pbdId;
                                                                                String booksetId = response.response[0].booksetDetails[index].booksetId;
                                                                                String opdId = response.response[0].booksetDetails[index].productInfo[subindex].productId;
                                                                                String price = response.response[0].booksetDetails[index].productInfo[subindex].productSalePriceOg;
                                                                                String inStock = response.response[0].booksetDetails[index].productInfo[subindex].productStockStatus;

                                                                                return Container(
                                                                                  width: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      border: Border.all(
                                                                                        color: Colors.grey,
                                                                                      )),
                                                                                  height: 40,
                                                                                  child: GetBuilder<TableDataController>(
                                                                                    builder: (TableController) {
                                                                                      ///SUB CATEGORY CHILD CHECK BOX....
                                                                                      if (tController.tableMapList.containsKey(booksetName)) {
                                                                                        int index = tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId));
                                                                                      }
                                                                                      return Row(
                                                                                        children: [
                                                                                          Container(
                                                                                              height: 40,
                                                                                              width: Get.width / 7,
                                                                                              child: Checkbox(
                                                                                                activeColor: Colors.grey,
                                                                                                onChanged: (value) {
                                                                                                  if (productDetailScreenController.isTypeBookSet) {
                                                                                                    log("IS CHECK VALUE$value");
                                                                                                    if (value == false) {
                                                                                                      // subTotal =
                                                                                                      //     0.0;
                                                                                                      // subTotalList
                                                                                                      //     .clear();
                                                                                                    }
                                                                                                    tController.addTableValue(key: booksetName, subKey: opdId, price: price);
                                                                                                  }
                                                                                                },
                                                                                                value: tController.tableMapList.isEmpty
                                                                                                    ? false
                                                                                                    : tController.tableMapList[booksetName].indexWhere((element) => element.containsKey(opdId)) > -1
                                                                                                        ? true
                                                                                                        : false,
                                                                                              )),
                                                                                          VerticalDivider(
                                                                                            color: Colors.black,
                                                                                            thickness: 1,
                                                                                          ),
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: Get.width / 3,
                                                                                            child: Text(
                                                                                              '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                            ),
                                                                                          ),
                                                                                          VerticalDivider(
                                                                                            color: Colors.black,
                                                                                            thickness: 1,
                                                                                          ),
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: Get.width / 13,
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          VerticalDivider(
                                                                                            color: Colors.black,
                                                                                            thickness: 1,
                                                                                          ),
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: Get.width / 6,
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePrice ?? ''}',
                                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            productDetailScreenController.isTypeBookSet
                                                                                ? Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        border: Border.all(
                                                                                          color: Colors.grey,
                                                                                        )),
                                                                                    height: 40,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'Sub Total',
                                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                            ),
                                                                                          ),
                                                                                          height: 40,
                                                                                          width: Get.width / 1.56,
                                                                                        ),
                                                                                        // VerticalDivider(
                                                                                        //   color: Colors.black,
                                                                                        //   thickness: 1,
                                                                                        // ),
                                                                                        Container(
                                                                                          height: 40,
                                                                                          width: Get.width / 5,
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              tController.tableMapList.isEmpty ? '0' : tController.tableMapList[bookSETName].fold(0, (previousValue, element) => previousValue + double.parse(element.values.toList()[0])).toString(),
                                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        border: Border.all(
                                                                                          color: Colors.grey,
                                                                                        )),
                                                                                    height: 40,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'Sub Total',
                                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                            ),
                                                                                          ),
                                                                                          height: 40,
                                                                                          width: Get.width / 1.56,
                                                                                        ),
                                                                                        // VerticalDivider(
                                                                                        //   color: Colors.black,
                                                                                        //   thickness: 1,
                                                                                        // ),
                                                                                        Container(
                                                                                          height: 40,
                                                                                          width: Get.width / 5,
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              response.response[0].booksetDetails[index].totalBooksetSalePrice ?? '',
                                                                                              style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    )
                                                                  : ListView
                                                                      .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: response
                                                                          .response[
                                                                              0]
                                                                          .booksetDetails
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  border: Border.all(
                                                                                    color: Colors.grey,
                                                                                  )),
                                                                              height: 40,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 7,
                                                                                    child: Checkbox(
                                                                                      value: response.response[0].booksetDetails[index].isMandatory == '1' ? true : productDetailScreenController.isCheckBox,
                                                                                      activeColor: Colors.grey,
                                                                                      onChanged: (value) {
                                                                                        if (response.response[0].booksetDetails[index].isMandatory == '0') {
                                                                                          switch (productDetailScreenController.isCheckBox) {
                                                                                            case true:
                                                                                              productDetailScreenController.setCheckBox(currentCheckBoxValue: false);
                                                                                              isSubTotal -= double.parse(response.response[0].booksetDetails[index].totalBooksetSalePrice);
                                                                                              _productDetailScreenController.setTotalPrice(addValue: isSubTotal);

                                                                                              productDetailScreenController.removePbdList(setValueRemove: response.response[0].booksetDetails[index].pbdId);

                                                                                              break;
                                                                                            case false:
                                                                                              isSubTotal += double.parse(response.response[0].booksetDetails[index].totalBooksetSalePrice);
                                                                                              _productDetailScreenController.setTotalPrice(addValue: isSubTotal);

                                                                                              productDetailScreenController.setCheckBox(currentCheckBoxValue: true);

                                                                                              productDetailScreenController.setPbdList(setValueAdd: response.response[0].booksetDetails[index].pbdId);

                                                                                              break;
                                                                                          }
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width / 34,
                                                                                  ),
                                                                                  VerticalDivider(
                                                                                    color: Colors.black,
                                                                                    thickness: 1,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].booksetName ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            ListView.builder(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: response.response[0].booksetDetails[index].productInfo.length,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, subindex) {
                                                                                return Container(
                                                                                  width: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      border: Border.all(
                                                                                        color: Colors.grey,
                                                                                      )),
                                                                                  height: 40,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 7,
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 3,
                                                                                        child: Text(
                                                                                          '${response.response[0].booksetDetails[index].productInfo[subindex].productName ?? ''}',
                                                                                          style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                        ),
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 13,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].quantity ?? ''}',
                                                                                            style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      VerticalDivider(
                                                                                        color: Colors.black,
                                                                                        thickness: 1,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 40,
                                                                                        width: Get.width / 6,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '${response.response[0].booksetDetails[index].productInfo[subindex].productSalePrice ?? ''}',
                                                                                            style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  border: Border.all(
                                                                                    color: Colors.grey,
                                                                                  )),
                                                                              height: 40,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        'Sub Tota',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                    height: 40,
                                                                                    width: Get.width / 1.56,
                                                                                  ),
                                                                                  // VerticalDivider(
                                                                                  //   color: Colors.black,
                                                                                  //   thickness: 1,
                                                                                  // ),
                                                                                  Container(
                                                                                    height: 40,
                                                                                    width: Get.width / 5,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${response.response[0].booksetDetails[index].totalBooksetSalePrice ?? ''}',
                                                                                        style: CommonTextStyle.aboutThisItemTextStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                          bookSetCustomType ==
                                                                  '3'
                                                              ? Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                  height: 40,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Final Total',
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: Get.width /
                                                                            1.56,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            Get.width /
                                                                                5,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            tController.tableMapList.isEmpty
                                                                                ? '0'
                                                                                //  : tController.tableMapList.values.toList().fold(0, (previousValue, element) => previousValue + element.fold(0, (previousValue, e) => previousValue + double.parse("1234"))).toString(),
                                                                                : tController.tableMapList.values.toList().fold(0, (previousValue, element) => previousValue + element.fold(0, (previousValue, e) => previousValue + double.parse(e.values.toList()[0]))).toString(),
                                                                            style:
                                                                                CommonTextStyle.aboutThisItemTextStyle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : productDetailScreenController
                                                                      .isTypeBookSet
                                                                  ? Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Final Total',
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 1.56,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 5,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                tController.tableMapList.isEmpty ? '0' : tController.tableMapList.values.toList().fold(0, (previousValue, element) => previousValue + element.fold(0, (previousValue, e) => previousValue + double.parse(e.values.toList()[0]))).toString(),
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Final Total',
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 1.56,
                                                                          ),
                                                                          // VerticalDivider(
                                                                          //   color: Colors.black,
                                                                          //   thickness: 1,
                                                                          // ),
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 5,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${productDetailScreenController.totalPriceOf ?? ''}',
                                                                                style: CommonTextStyle.aboutThisItemTextStyle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    response.response[0].relatedProducts != null
                                        ? SizedBox()
                                        : Text('View Similar',
                                            style: CommonTextStyle
                                                .aboutThisItemTextStyle),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    response.response[0].relatedProducts
                                            .isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Related Product',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorPicker.navyBlue),
                                            ),
                                          )
                                        : SizedBox(),
                                    Container(
                                      height: Get.height * 0.3,
                                      width: Get.width,
                                      child: response.response[0]
                                                  .relatedProducts !=
                                              null
                                          ? ListView.builder(
                                              itemCount: response.response[0]
                                                  .relatedProducts.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Stack(
                                                  children: [
                                                    Container(
                                                      width: Get.width * 0.5,
                                                      child: Card(
                                                        elevation: 5,
                                                        child: Material(
                                                          child: Ink(
                                                            color: Colors.white,
                                                            child: InkWell(
                                                              onTap: () {
                                                                _schoolDetailController.setTitleSlugProductDetailsScreen(
                                                                    titleSlugProductDetails: response
                                                                        .response[
                                                                            0]
                                                                        .relatedProducts[
                                                                            index]
                                                                        .productSlug);
                                                                bottomController
                                                                    .selectedScreen(
                                                                        'ProductDetailScreen');
                                                                _productDetailViewModel.productDetailViewModel(
                                                                    isLoading:
                                                                        false,
                                                                    slugName: response
                                                                        .response[
                                                                            0]
                                                                        .relatedProducts[
                                                                            index]
                                                                        .productSlug);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                width: Get.width * 0.3,
                                                                                child: CarouselSlider(
                                                                                  options: CarouselOptions(
                                                                                    height: Get.height * 0.17,
                                                                                    onPageChanged: (val, reason) {
                                                                                      _productDetailScreenController.setIsRelatedChangeIndex(newValue: val);
                                                                                      _productDetailScreenController.setCurrentRelatedId(curentValueId: response.response[0].relatedProducts[index].productId);
                                                                                    },
                                                                                    viewportFraction: 1.0,

                                                                                    enlargeCenterPage: false,
                                                                                    // autoPlay: false,
                                                                                  ),
                                                                                  items: response.response[0].relatedProducts.isEmpty || response.response[0].relatedProducts == null
                                                                                      ? Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Center(
                                                                                            child: commonImage(
                                                                                              widthImage: Get.width * 0.3,
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : response.response[0].relatedProducts[index].productImgs
                                                                                          .map((item) => Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Center(
                                                                                                    child: Image.network(
                                                                                                  item.productImg.trim(),
                                                                                                  width: Get.width * 0.3,
                                                                                                  fit: BoxFit.cover,
                                                                                                )),
                                                                                              ))
                                                                                          .toList(),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          response.response[0].relatedProducts[index].productImgs.length == 1
                                                                              ? SizedBox()
                                                                              : Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: List.generate(
                                                                                      response.response[0].relatedProducts[index].productImgs.length,
                                                                                      (subIndex) => Padding(
                                                                                            padding: EdgeInsets.all(Get.height * 0.002),
                                                                                            child: CircleAvatar(
                                                                                              radius: Get.height * 0.004,
                                                                                              backgroundColor: (productDetailScreenController.isRelatedChangeIndex == subIndex && productDetailScreenController.relatedProductId == response.response[0].relatedProducts[index].productId) ? Colors.black : Colors.grey,
                                                                                            ),
                                                                                          )),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Divider(
                                                                            thickness:
                                                                                1,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(left: Get.height * 0.006),
                                                                              child: Text(
                                                                                '${response.response[0].relatedProducts[index].productName ?? ''}',
                                                                                //overflow: TextOverflow.ellipsis,
                                                                                style: CommonTextStyle.productTitle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(left: Get.height * 0.006, right: Get.height * 0.006),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text("₹ ${response.response[0].relatedProducts[index].productSalePrice ?? ''}", style: CommonTextStyle.priceTextStyle),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Text(
                                                                                                'MRP',
                                                                                                style: CommonTextStyle.MRPTextStyle,
                                                                                              ),
                                                                                              Text(
                                                                                                '₹ ${response.response[0].relatedProducts[index].productPrice ?? ""}',
                                                                                                style: CommonTextStyle.cancelPrice,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Text(
                                                                                            "Incl. of all taxes",
                                                                                            style: CommonTextStyle.taxIncludeStyle,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      response.response[0].relatedProducts[index].productStockStatus == 'OUT'
                                                                                          ? Text(
                                                                                              'Out of Stock',
                                                                                              style: TextStyle(fontSize: Get.width / 45),
                                                                                            )
                                                                                          : (response.response[0].relatedProducts[index].productType == 'Single' && response.response[0].relatedProducts[index].variation == 'YES')
                                                                                              ? Material(
                                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                                  child: Ink(
                                                                                                    height: Get.height * 0.03,
                                                                                                    width: Get.width * 0.18,
                                                                                                    decoration: BoxDecoration(color: ColorPicker.navyBlue, borderRadius: BorderRadius.circular(5)),
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                        "View",
                                                                                                        style: TextStyle(fontSize: Get.height * 0.018),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              : response.response[0].relatedProducts[index].productType == 'Single'
                                                                                                  ? GetBuilder<ProductDetailScreenController>(
                                                                                                      builder: (controller) {
                                                                                                        var releatedProduct = response.response[0].relatedProducts[index];
                                                                                                        var _currentUserId = PreferenceManager.getTokenId();
                                                                                                        return AddCartButton(
                                                                                                          currentPageApiCall: () {
                                                                                                            _productDetailViewModel.productDetailViewModel(slugName: _schoolDetailController.titleSlugProductDetailsScreen, isLoading: false);
                                                                                                          },
                                                                                                          responsId: releatedProduct.productId,
                                                                                                          curentId: releatedProduct.productId,
                                                                                                          quantity: releatedProduct.productInUserCartQuantity,
                                                                                                          onTapDecrement: () {
                                                                                                            if (_currentUserId == null) {
                                                                                                              return Get.to(SignInScreen());
                                                                                                            } else {
                                                                                                              String pId = releatedProduct.productId;
                                                                                                              int qnt = releatedProduct.productInUserCartQuantity == '' ? 1 : int.parse(releatedProduct.productInUserCartQuantity);

                                                                                                              int index1 = controller.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));
                                                                                                              if (index1 == -1) {
                                                                                                                productDetailScreenController.setAddSelectProductList(id: releatedProduct.productId, quantity: qnt);
                                                                                                                index1 = productDetailScreenController.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));
                                                                                                              }
                                                                                                              print('INDEX...:$index1');
                                                                                                              if (index1 > -1) {
                                                                                                                if (controller.selectProductList[index1][pId] > 1) {
                                                                                                                  print('INDEX VALUE :${controller.selectProductList[index1][pId]}');
                                                                                                                  controller.setDecrementSelectListProductQDec(
                                                                                                                    pId,
                                                                                                                    qnt,
                                                                                                                  );
                                                                                                                  AddToCartReq _user = AddToCartReq();

                                                                                                                  _user.userId = PreferenceManager.getTokenId() ?? '0';
                                                                                                                  _user.productId = '${releatedProduct.productId}';
                                                                                                                  _user.qty = '${controller.selectProductList[index1][pId]}';
                                                                                                                  _user.studentName = '';

                                                                                                                  _user.studentRoll = '';
                                                                                                                  _user.pvsmId = '';
                                                                                                                  _user.variationsnIfo = [];
                                                                                                                  _user.additionalSetInfo = '';

                                                                                                                  _user.pbdId = '';
                                                                                                                  _user.booksetCustomize = '';
                                                                                                                  _user.booksetProductIds = '';

                                                                                                                  _user.booksetCustomizeArray = '';
                                                                                                                  _user.qtyUpdate = '1';
                                                                                                                  _addToCartViewModel.addToCartViewModel(model: _user);
                                                                                                                } else {
                                                                                                                  RemoveReqModel _user = RemoveReqModel();
                                                                                                                  _user.userId = '${PreferenceManager.getTokenId()}';
                                                                                                                  _user.cartId = '${releatedProduct.productInUserCartId}';
                                                                                                                  _removeCartViewModel.removeCartViewModel(model: _user).then((value) async {
                                                                                                                    _productDetailViewModel.productDetailViewModel(isLoading: false, slugName: _schoolDetailController.titleSlugProductDetailsScreen);
                                                                                                                    CommonSnackBar.showSnackBar(successStatus: true, msg: 'Removed from cart.');
                                                                                                                    countSetCart();

                                                                                                                    productDetailScreenController.removeSelectProductList(key: releatedProduct.productId);
                                                                                                                  });
                                                                                                                  print('remove from all');
                                                                                                                }
                                                                                                              }
                                                                                                            }
                                                                                                          },
                                                                                                          onTapIncrement: () {
                                                                                                            if (_currentUserId == null) {
                                                                                                              return Get.to(SignInScreen());
                                                                                                            } else {
                                                                                                              String pId = releatedProduct.productId;
                                                                                                              int qnt = releatedProduct.productInUserCartQuantity == ''
                                                                                                                  ? 1
                                                                                                                  : int.parse(
                                                                                                                      releatedProduct.productInUserCartQuantity,
                                                                                                                    );
                                                                                                              controller.setIncrementSelectListProductQInc(
                                                                                                                pId,
                                                                                                                qnt,
                                                                                                              );
                                                                                                              int index = controller.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));

                                                                                                              AddToCartReq _user = AddToCartReq();

                                                                                                              _user.userId = PreferenceManager.getTokenId() ?? '0';
                                                                                                              _user.productId = '${releatedProduct.productId}';

                                                                                                              _user.qty = '${controller.selectProductList[index][pId]}';
                                                                                                              _user.studentName = '';

                                                                                                              _user.studentRoll = '';
                                                                                                              _user.pvsmId = '';
                                                                                                              _user.variationsnIfo = [];
                                                                                                              _user.additionalSetInfo = '';

                                                                                                              _user.pbdId = '';
                                                                                                              _user.booksetCustomize = '';
                                                                                                              _user.booksetProductIds = '';

                                                                                                              _user.booksetCustomizeArray = '';
                                                                                                              _user.qtyUpdate = '1';
                                                                                                              _addToCartViewModel.addToCartViewModel(model: _user).then((value) {
                                                                                                                AddToCartResponse _addToCartResponse = _addToCartViewModel.apiResponse.data;
                                                                                                                if (_addToCartResponse.status == 200) {
                                                                                                                  CommonSnackBar.showSnackBar(successStatus: true, msg: _addToCartResponse.message);
                                                                                                                } else {
                                                                                                                  productDetailScreenController.setDecrementSelectListProductQDec(pId, qnt);

                                                                                                                  CommonSnackBar.showSnackBar(successStatus: false, msg: _addToCartResponse.message);
                                                                                                                }
                                                                                                              });
                                                                                                            }
                                                                                                          },
                                                                                                        );
                                                                                                      },
                                                                                                    )
                                                                                                  : SizedBox(),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    response
                                                                .response[0]
                                                                .relatedProducts[
                                                                    index]
                                                                .productDiscount
                                                                .isEmpty ||
                                                            response
                                                                    .response[0]
                                                                    .relatedProducts[
                                                                        index]
                                                                    .productDiscount ==
                                                                ''
                                                        ? SizedBox()
                                                        : Positioned(
                                                            left: -Get.width *
                                                                0.028,
                                                            top: -5,
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height:
                                                                  Get.height *
                                                                      0.07,
                                                              width:
                                                                  Get.height *
                                                                      0.07,
                                                              decoration: BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      blurRadius:
                                                                          5,
                                                                    )
                                                                  ],
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorPicker
                                                                      .redColorApp),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: Get
                                                                            .height *
                                                                        0.015),
                                                                child: Text(
                                                                  " ${response.response[0].relatedProducts[index].productDiscount ?? ''}\nOFF",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Get.height *
                                                                              0.017,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                  ],
                                                );
                                              })
                                          : Center(
                                              child: Text(
                                                  "No related product found!")),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return circularProgress();
          }
        },
      ),
    );
  }

  addButtonTabel(
      {String bookSetCustomType,
      ProductDetailScreenController productDetailScreenController,
      ProductDetailResponse response}) {
    return AddToCartWidget().addToCartNormal(onTap: () {
      var _currentUserId = PreferenceManager.getTokenId();
      if (_currentUserId == null) {
        Get.back();

        return Get.to(SignInScreen());
      } else {
        Get.back();
        AddToCartReq _user = AddToCartReq();

        ///start
        if (_formKey.currentState.validate()) {
          if ((bookSetCustomType == '1' || bookSetCustomType == '3') &&
              productDetailScreenController.isTypeBookSet == true) {
            List<Map> listFilterEncode = [];
            String pbdIdForApi = '';
            String productIdForApi = '';
            String valuseList;

            Map<String, List<Map<String, String>>> mapData;
            _tableDataController.tableMapList.forEach(
              (key, value) {
                pbdIdForApi = pbdIdForApi + key + ',';
                List<String> _list = [];

                String filterKey = jsonEncode("pbd_id");
                String filterSlugKey = jsonEncode("selected_product_ids");
                String filterValue = jsonEncode("$key");

                value.forEach((element) {
                  _list.add(jsonEncode(int.parse(element.keys.join(','))));
                });

                valuseList = value.fold(
                    '',
                    (previousValue, element) =>
                        previousValue +
                        (previousValue == '' ? '' : ',') +
                        element.keys
                            .toList()
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''));
                productIdForApi = productIdForApi + valuseList + ',';

                listFilterEncode.add({
                  filterKey: filterValue,
                  filterSlugKey: jsonEncode(valuseList)
                });
                print('dsd');

                mapData = _tableDataController.tableMapList;
              },
            );
            if (_tableDataController.tableMapList.length > 0) {
              PreferenceManager.getStorage.write(pbdId, listFilterEncode);

              print("STORE DATA ${PreferenceManager.getStorage.read(pbdId)}");
              var filterDataSendApi = PreferenceManager.getStorage.read(pbdId);
              print('CUSTOM ARRAY $filterDataSendApi');

              _user.userId = PreferenceManager.getTokenId() ?? '0';
              _user.productId = '${response.response[0].productId}';
              _user.qty = '1';
              _user.studentName = _nameController.text;
              _user.studentRoll = _mobileNumberController.text;
              _user.pvsmId =
                  '${productIdForApi.substring(0, productIdForApi.length - 1)}';
              _user.pbdId =
                  '${pbdIdForApi.substring(0, pbdIdForApi.length - 1)}';
              _user.booksetCustomize = '1';
              _user.booksetProductIds =
                  '${productIdForApi.substring(0, productIdForApi.length - 1)}';
              _user.additionalSetInfo = '';
              _user.qtyUpdate = '';

              _user.variationsnIfo = [];

              _user.booksetCustomizeArray = '$filterDataSendApi';
              _addToCartViewModel
                  .addToCartViewModel(model: _user)
                  .then((value) {
                _productDetailViewModel.productDetailViewModel(
                    isLoading: false,
                    slugName:
                        _schoolDetailController.titleSlugProductDetailsScreen);
                AddToCartResponse _response =
                    _addToCartViewModel.apiResponse.data;
                if (_response.status == 200) {
                  //clearTextEditController();

                  CommonSnackBar.showSnackBar(
                    msg: _response.message,
                    successStatus: true,
                  );
                } else {
                  CommonSnackBar.showSnackBar(msg: _response.message);
                }

                cartMainQ = 0;
                _productDetailScreenController.isOrderCountRelated = 0;
                _productDetailScreenController.currentId = '';

                countSetCart();
              });

              print(
                  '--------------------value-------------mapdata----$mapData');
            }
          }

          if (productDetailScreenController.isTypeBookSet == false) {
            List<Map> listFilterEncode = [];
            String pbdIdForApi = '';
            String productIdForApi = '';
            String valuseList;

            Map<String, List<Map<String, String>>> mapData;
            _tableDataController.isMandatoryTableList.forEach(
              (key, value) {
                pbdIdForApi = pbdIdForApi + key + ',';
                List<String> _list = [];

                String filterKey = jsonEncode("pbd_id");
                String filterSlugKey = jsonEncode("selected_product_ids");
                String filterValue = jsonEncode("$key");

                value.forEach((element) {
                  _list.add(jsonEncode(int.parse(element.keys.join(','))));
                });

                valuseList = value.fold(
                    '',
                    (previousValue, element) =>
                        previousValue +
                        (previousValue == '' ? '' : ',') +
                        element.keys
                            .toList()
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''));
                productIdForApi = productIdForApi + valuseList + ',';

                listFilterEncode.add({
                  filterKey: filterValue,
                  filterSlugKey: jsonEncode(valuseList)
                });

                mapData = _tableDataController.isMandatoryTableList;
              },
            );
            if (_tableDataController.isMandatoryTableList.length > 0) {
              PreferenceManager.getStorage.write(pbdId, listFilterEncode);

              print("STORE DATA ${PreferenceManager.getStorage.read(pbdId)}");
              var filterDataSendApi = PreferenceManager.getStorage.read(pbdId);
              print('CUSTOM ARRAY $filterDataSendApi');

              _user.userId = PreferenceManager.getTokenId() ?? '0';
              _user.productId = '${response.response[0].productId}';
              _user.qty = '1';
              _user.studentName = _nameController.text;
              _user.studentRoll = _mobileNumberController.text;
              _user.pvsmId =
                  '${productIdForApi.substring(0, productIdForApi.length - 1)}';
              _user.pbdId =
                  '${pbdIdForApi.substring(0, pbdIdForApi.length - 1)}';
              _user.booksetCustomize = '1';
              _user.booksetProductIds =
                  '${productIdForApi.substring(0, productIdForApi.length - 1)}';
              _user.additionalSetInfo = '';
              _user.qtyUpdate = '';

              _user.variationsnIfo = [];

              _user.booksetCustomizeArray = '$filterDataSendApi';
              _addToCartViewModel
                  .addToCartViewModel(model: _user)
                  .then((value) {
                AddToCartResponse _response =
                    _addToCartViewModel.apiResponse.data;
                if (_response.status == 200) {
                  clearTextEditController();
                  CommonSnackBar.showSnackBar(
                    msg: _response.message,
                    successStatus: true,
                  );
                } else {
                  CommonSnackBar.showSnackBar(msg: _response.message);
                }

                cartMainQ = 0;
                _productDetailScreenController.isOrderCountRelated = 0;
                _productDetailScreenController.currentId = '';

                countSetCart();
              });

              print(
                  '--------------------value-------------mapdata----$mapData');
            }
          }
        } else {
          CommonSnackBar.showSnackBar(msg: "Plase Enter Name & Mobile Value");
        }
      }
    });
  }

  addDi(
      {String bookSetCustomType,
      ProductDetailScreenController productDetailScreenController,
      ProductDetailResponse response}) {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                children: [
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CommanWidget.getTextFormField(
                        keyboardType: TextInputType.name,
                        labelText: "Enter Your Name",
                        textEditingController: _nameController,
                        regularExpression:
                            Utility.alphabetSpaceValidationPattern,
                        validationMessage: Utility.nameEmptyValidation,
                        // validationType: 'mobileno',
                        hintText: "",
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CommanWidget.getTextFormField(
                        keyboardType: TextInputType.phone,
                        labelText: "Enter Your mobile number",
                        textEditingController: _mobileNumberController,
                        inputLength: 10,
                        regularExpression: Utility.digitsValidationPattern,
                        validationMessage:
                            Utility.mobileNumberInValidValidation,
                        validationType: 'mobileno',
                        hintText: "",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          color: ColorPicker.redColorApp,
                        ),
                      ),
                      addButtonTabel(
                          response: response,
                          bookSetCustomType: bookSetCustomType,
                          productDetailScreenController:
                              productDetailScreenController)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              );
            },
          );
        });
  }

  Container topViewSlider(ProductDetailResponse response) {
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      color: Colors.white,
      child: CarouselSlider(
        carouselController: _mainController,
        options: CarouselOptions(
          onPageChanged: (val, reason) {
            _productDetailScreenController.setIsChangeIndex(newValue: val);
          },
          viewportFraction: 1.0,
          height: Get.height * 0.25,

          enlargeCenterPage: false,
          // autoPlay: false,
        ),
        items: response.response[0].productImgs.isEmpty ||
                response.response[0].productImgs == null
            ? commonImage(
                widthImage: Get.width,
                heightImage: Get.height * 0.25,
              )
            : response.response[0].productImgs
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item.productImg.trim(),
                        fit: BoxFit.fitHeight,
                        width: Get.width,
                        height: Get.height * 0.25,
                      )),
                    ))
                .toList(),
      ),
    );
  }

  Text productSalePrice(ProductDetailResponse response) {
    return Text(
      ' ₹ ${response.response[0].productSalePrice ?? ""}',
      style: CommonTextStyle.price,
      textAlign: TextAlign.left,
    );
  }

  Container likeWidget(ProductDetailResponse response) {
    return Container(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                response.response[0].productName ?? "",
                style: CommonTextStyle.bookName,
              ),
              width: Get.width / 1.2,
              //color: Colors.deepOrange,
            ),
          ),
          GestureDetector(
            onTap: () {
              PostWishListReqModel _userWish = PostWishListReqModel();
              _userWish.productId = response.response[0].productId;
              _userWish.status =
                  response.response[0].productInUserWishlist == '1'
                      ? 'REMOVE'
                      : 'ADD';
              _postWishListViewModel
                  .postWishListViewModel(model: _userWish)
                  .then((value) {
                _productDetailViewModel.productDetailViewModel(
                    slugName:
                        _schoolDetailController.titleSlugProductDetailsScreen,
                    isLoading: false);
                countSetWishCart();
              });
            },
            child: response.response[0].productInUserWishlist == '1'
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: Get.height * 0.035,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: Get.height * 0.035,
                  ),
          ),
        ],
      ),
    );
  }

  offStackWidget(ProductDetailResponse response) {
    return Positioned(
      top: Get.width * 0.01,
      right: -Get.width * 0.1,
      child: Container(
        alignment: Alignment.center,
        height: Get.height * 0.11,
        width: Get.width * 0.3,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ], shape: BoxShape.circle, color: ColorPicker.redColorApp),
        child: Padding(
          padding: EdgeInsets.only(right: Get.width * 0.02),
          child: Text(
            "${response.response[0].productDiscount ?? ""} \nOFF",
            style: TextStyle(
                fontSize: Get.height * 0.024,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
