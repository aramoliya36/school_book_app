import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/remove_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/cart_response_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/cart_repo_view_model.dart';
import 'package:skoolmonk/viewModel/remove_cart_view_model.dart';
import '../../../common/cart_count_method.dart';
import '../../../common/color_picker.dart';
import '../../../model/responseModel/add_to_cart_response_model.dart';

Expanded cartList(CartResponse response) {
  RemoveCartViewModel _removeCartViewModel = Get.find();
  CartViewModel _cartViewModel = Get.find();
  // UpdateCartViewModel _updateCartViewModel = Get.find();
  // UpdateCartReq _updateCartReq = UpdateCartReq();
  AddToCartViewModel _addToCartViewModel = Get.find();
  // BottomController homeController = Get.find();
  // SubCategoryController subCategoryController = Get.find();
  // ProductDetailViewModel _productDetailViewModel = Get.find();
  // SchoolDetailController _schoolDetailController = Get.find();
  ProductDetailScreenController _productDetailScreenController = Get.find();

  return Expanded(
    child: response.response.isEmpty
        ? Center(
            child: Text('Cart is Empty'),
          )
        : ListView.builder(
            itemCount: response.response[0].cart.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              String pId = response.response[0].cart[index].productId;
              final resp = response.response[0].cart[index];
              var _currentUserId = PreferenceManager.getTokenId();
              return GetBuilder<ProductDetailScreenController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.height * 0.022,
                              vertical: Get.height * 0.015),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    response.response[0].cart[index].productImg
                                                .isEmpty ||
                                            response.response[0].cart[index]
                                                    .productImg ==
                                                ''
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: commonImage(
                                              heightImage: Get.height * 0.12,
                                            ),
                                          )
                                        : Image.network(
                                            response.response[0].cart[index]
                                                .productImg
                                                .trim(),
                                            height: Get.height * 0.12,
                                          ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width / 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            RemoveReqModel _user =
                                                RemoveReqModel();
                                            _user.userId =
                                                '${PreferenceManager.getTokenId()}';
                                            _user.cartId =
                                                '${response.response[0].cart[index].cartId}';
                                            _removeCartViewModel
                                                .removeCartViewModel(
                                                    model: _user)
                                                .then((value) async {
                                              _cartViewModel.cartViewModel();
                                              countSetCart();

                                              controller
                                                  .removeSelectProductList(
                                                      key: resp.productId);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: ColorPicker.redColorApp,
                                          ),
                                        ),
                                        Text('Remove')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${response.response[0].cart[index].productName ?? ''}',
                                        style: TextStyle(
                                            fontSize: Get.height * 0.014,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        response.response[0].cart[index]
                                                .booksetOptionsName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: Get.height * 0.014,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                    response.response[0].cart[index]
                                                .productType ==
                                            'Single'
                                        ? AddCartButton(
                                            responsId: response.response[0]
                                                .cart[index].productId,
                                            curentId: response.response[0]
                                                .cart[index].productId,
                                            quantity: response
                                                .response[0].cart[index].qty,
                                            onTapDecrement: () {
                                              if (_currentUserId == null) {
                                                return Get.to(SignInScreen());
                                              } else {
                                                int qnt = resp.qty == ''
                                                    ? 1
                                                    : int.parse(resp.qty);

                                                int index = controller
                                                    .selectProductList
                                                    .indexWhere((element) =>
                                                        element.keys
                                                            .toList()
                                                            .contains(pId));
                                                if (index == -1) {
                                                  controller
                                                      .setAddSelectProductList(
                                                          id: resp.productId,
                                                          quantity: qnt);
                                                  index = controller
                                                      .selectProductList
                                                      .indexWhere((element) =>
                                                          element.keys
                                                              .toList()
                                                              .contains(pId));
                                                }
                                                print('INDEX...:$index');
                                                if (index > -1) {
                                                  print(
                                                      'INDEX VALUE :${controller.selectProductList[index][pId]}');
                                                  if (controller
                                                              .selectProductList[
                                                          index][pId] >
                                                      1) {
                                                    controller
                                                        .setDecrementSelectListProductQDec(
                                                      pId,
                                                      qnt,
                                                    );
                                                    AddToCartReq _user =
                                                        AddToCartReq();

                                                    _user.userId =
                                                        PreferenceManager
                                                                .getTokenId() ??
                                                            '0';
                                                    _user.productId =
                                                        '${resp.productId}';
                                                    _user.qty =
                                                        '${controller.selectProductList[index][pId]}';
                                                    _user.studentName = '';
                                                    _user.qtyUpdate = '1';

                                                    _user.studentRoll = '';
                                                    _user.pvsmId = '';
                                                    _user.variationsnIfo = [];
                                                    _user.additionalSetInfo =
                                                        '';

                                                    _user.pbdId = '';
                                                    _user.booksetCustomize = '';
                                                    _user.booksetProductIds =
                                                        '';

                                                    _user.booksetCustomizeArray =
                                                        '';

                                                    _addToCartViewModel
                                                        .addToCartViewModel(
                                                            model: _user)
                                                        .then((value) {
                                                      AddToCartResponse
                                                          _resAddCart =
                                                          _addToCartViewModel
                                                              .apiResponse.data;
                                                      if (_resAddCart.status ==
                                                          200) {
                                                        CommonSnackBar
                                                            .showSnackBar(
                                                                successStatus:
                                                                    true,
                                                                msg: _resAddCart
                                                                    .message);
                                                      } else {
                                                        _productDetailScreenController
                                                            .setDecrementSelectListProductQDec(
                                                                pId, qnt);
                                                        CommonSnackBar
                                                            .showSnackBar(
                                                                successStatus:
                                                                    true,
                                                                msg: _resAddCart
                                                                    .message);
                                                      }
                                                      print('add to cart');
                                                      _cartViewModel
                                                          .cartViewModel(
                                                              isLoading: false);
                                                    });
                                                  } else {
                                                    RemoveReqModel _user =
                                                        RemoveReqModel();
                                                    _user.userId =
                                                        '${PreferenceManager.getTokenId()}';
                                                    _user.cartId =
                                                        '${resp.cartId}';
                                                    _removeCartViewModel
                                                        .removeCartViewModel(
                                                            model: _user)
                                                        .then((value) async {
                                                      await _cartViewModel
                                                          .cartViewModel();

                                                      countSetCart();

                                                      _productDetailScreenController
                                                          .removeSelectProductList(
                                                              key: resp
                                                                  .productId);
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
                                                String pId = resp.productId;
                                                int qnt = resp.qty == ''
                                                    ? 1
                                                    : int.parse(
                                                        resp.qty,
                                                      );
                                                controller
                                                    .setIncrementSelectListProductQInc(
                                                  pId,
                                                  qnt,
                                                );
                                                int index = controller
                                                    .selectProductList
                                                    .indexWhere((element) =>
                                                        element.keys
                                                            .toList()
                                                            .contains(pId));

                                                AddToCartReq _user =
                                                    AddToCartReq();

                                                _user.userId = PreferenceManager
                                                        .getTokenId() ??
                                                    '0';
                                                _user.productId =
                                                    '${resp.productId}';

                                                _user.qty =
                                                    '${controller.selectProductList[index][pId]}';
                                                _user.studentName = '';
                                                _user.qtyUpdate = '1';

                                                _user.studentRoll = '';
                                                _user.pvsmId = '';
                                                _user.variationsnIfo = [];
                                                _user.additionalSetInfo = '';

                                                _user.pbdId = '';
                                                _user.booksetCustomize = '';
                                                _user.booksetProductIds = '';

                                                _user.booksetCustomizeArray =
                                                    '';

                                                _addToCartViewModel
                                                    .addToCartViewModel(
                                                        model: _user)
                                                    .then((value) {
                                                  AddToCartResponse
                                                      _addToCartResponse =
                                                      _addToCartViewModel
                                                          .apiResponse.data;
                                                  if (_addToCartResponse
                                                          .status ==
                                                      200) {
                                                    CommonSnackBar.showSnackBar(
                                                        successStatus: true,
                                                        msg: _addToCartResponse
                                                            .message);
                                                  } else {
                                                    controller
                                                        .setDecrementSelectListProductQDec(
                                                            pId, qnt);

                                                    CommonSnackBar.showSnackBar(
                                                        successStatus: false,
                                                        msg: _addToCartResponse
                                                            .message);
                                                  }

                                                  _cartViewModel.cartViewModel(
                                                      isLoading: false);
                                                });
                                              }
                                            },
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              // Get.to(ProductInfoDetails(
                                              //   response: response,
                                              // ));
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Container(
                                                      width: double.infinity,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
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
                                                                        'Select',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            8,
                                                                  ),
                                                                  VerticalDivider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        1,
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            4,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Particular',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  VerticalDivider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        1,
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            14,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Qty',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  VerticalDivider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        1,
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    // width: Get.width / 5.6,
                                                                    width:
                                                                        Get.width /
                                                                            8,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        ' Price  ',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
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
                                                                  .cart[index]
                                                                  .booksetDetails
                                                                  .length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      subIndex) {
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
                                                                                Get.width / 8,
                                                                            child:
                                                                                Checkbox(
                                                                              value: true,
                                                                              activeColor: Colors.grey,
                                                                              onChanged: (value) {},
                                                                            ),
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
                                                                                'School Text Book',
                                                                                style: CommonTextStyle.cartItemSmallTextStyle,
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
                                                                          .cart[
                                                                              index]
                                                                          .booksetDetails[
                                                                              subIndex]
                                                                          .productInfo
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              thirdIndex) {
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
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                height: 40,
                                                                                width: Get.width / 8,
                                                                              ),
                                                                              VerticalDivider(
                                                                                color: Colors.black,
                                                                                thickness: 1,
                                                                              ),
                                                                              Container(
                                                                                //height: 40,
                                                                                width: Get.width / 4,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '${response.response[0].cart[index].booksetDetails[subIndex].productInfo[thirdIndex].productName ?? ''}',
                                                                                    style: CommonTextStyle.cartItemSmallTextStyle,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 3,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              VerticalDivider(
                                                                                color: Colors.black,
                                                                                thickness: 1,
                                                                              ),
                                                                              Container(
                                                                                height: 40,
                                                                                width: Get.width / 14,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '${response.response[0].cart[index].booksetDetails[subIndex].productInfo[thirdIndex].quantity ?? ''}',
                                                                                    style: CommonTextStyle.cartItemSmallTextStyle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              VerticalDivider(
                                                                                color: Colors.black,
                                                                                thickness: 1,
                                                                              ),
                                                                              Container(
                                                                                height: 40,
                                                                                width: Get.width / 7,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '${response.response[0].cart[index].booksetDetails[subIndex].productInfo[thirdIndex].productSalePrice ?? ''}',
                                                                                    style: CommonTextStyle.cartItemSmallTextStyle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
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
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Sub Total',
                                                                                style: CommonTextStyle.cartItemSmallTextStyle,
                                                                              ),
                                                                            ),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 1.76,
                                                                          ),
                                                                          // VerticalDivider(
                                                                          //   color: Colors.black,
                                                                          //   thickness: 1,
                                                                          // ),
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                Get.width / 8,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '${response.response[0].cart[index].booksetDetails[subIndex].totalBooksetSalePrice ?? ''}',
                                                                                style: CommonTextStyle.cartItemSmallTextStyle,
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
                                                                        'final Total',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            1.76,
                                                                  ),
                                                                  // VerticalDivider(
                                                                  //   color: Colors.black,
                                                                  //   thickness: 1,
                                                                  // ),
                                                                  Container(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width /
                                                                            8,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        '${response.response[0].cart[index].productFinalTotal ?? ''}',
                                                                        style: CommonTextStyle
                                                                            .cartItemSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              'Product Info',
                                              style: TextStyle(
                                                  color: ColorPicker.navyBlue),
                                            )),
                                    response.response[0].cart[index]
                                                .variation ==
                                            'YES'
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${response.response[0].cart[index].variationsOptionsName}'),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '₹ ${response.response[0].cart[index].productFinalTotal}',
                                      style: CommonTextStyle.priceTextStyle,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    // CartButton()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      response.response[0].cart[index].productStatusError == '0'
                          ? SizedBox()
                          : Row(
                              children: [
                                Icon(Icons.info_outline),
                                Expanded(
                                  child: Text(response.response[0].cart[index]
                                          .productStatusErrorMsg ??
                                      ''),
                                ),
                              ],
                            ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  );
                },
              );
            }),
  );
}
