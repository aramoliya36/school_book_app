import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/variation_info2_req.dart';
import 'package:skoolmonk/model/responseModel/add_to_cart_response_model.dart';
import 'package:skoolmonk/model/responseModel/variation_Info2_response_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/productDetail_view_model.dart';
import 'package:skoolmonk/viewModel/variation_info2_viewmodel.dart';

import 'cart_count_method.dart';
import 'coomon_snackbar.dart';

class CartButton extends StatefulWidget {
  final Function onTapDecrement;
  final Function onTapIncrement;
  final Function onTapFristIncrement;

  // final int cartQ;

  const CartButton({
    this.onTapDecrement,
    this.onTapIncrement,
    this.onTapFristIncrement,
  });

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  ProductDetailScreenController _productDetailScreenController = Get.find();
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
    if (_isSelect) {
      return Container(
        height: Get.height * 0.04,
        width: Get.width * 0.19,
        decoration: BoxDecoration(
            color: ColorPicker.navyBlue,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: widget.onTapDecrement,
              child: Icon(
                Icons.delete,
                size: Get.height * 0.03,
              ),
            ),
            GetBuilder<ProductDetailScreenController>(
              builder: (controller) {
                return Container(
                  height: Get.height * 0.039,
                  width: Get.width * 0.062,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    "${controller.isOrderCount}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                );
              },
            ),
            InkWell(
              onTap: widget.onTapIncrement,
              child: Icon(
                Icons.add,
                size: Get.height * 0.03,
              ),
            ),
          ],
        ),
      );
    } else {
      // _productDetailScreenController.resetOrderCount();
      return Material(
        borderRadius: BorderRadius.circular(5),
        child: Ink(
          height: Get.height * 0.04,
          width: Get.width * 0.19,
          decoration: BoxDecoration(
              color: ColorPicker.navyBlue,
              borderRadius: BorderRadius.circular(5)),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              setState(() {
                // _productDetailScreenController.resetOrderCount();
                widget.onTapFristIncrement;

                _isSelect = !_isSelect;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: Get.height * 0.03,
                ),
                Text(
                  "ADD",
                  style: TextStyle(fontSize: Get.height * 0.02),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

class AddCartButton extends StatefulWidget {
  final Function onTapIncrement;
  final Function onTapDecrement;
  final Function currentPageApiCall;
  final String curentId;
  final String responsId;
  final String quantity;
  final String variation;
  final String dropdownValue;
  final String variationCount;

  final String dropdownValue1;
  final Map dropdown;
  final Map dropdown1;

  const AddCartButton({
    this.dropdown,
    this.dropdown1,
    this.dropdownValue,
    this.dropdownValue1,
    this.variation,
    this.variationCount,
    this.onTapIncrement,
    this.onTapDecrement,
    this.curentId,
    this.responsId,
    this.quantity,
    this.currentPageApiCall,
  });

  @override
  _AddCartButtonState createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  ProductDetailScreenController _productDetailScreenController = Get.find();
  AddToCartViewModel _addToCartViewModel = Get.find();
  VariationInfo2ReqModel _userInfo2 = VariationInfo2ReqModel();
  VariationInfo2ViewModel _variationInfo2ViewModel = Get.find();
  ProductDetailViewModel _productDetailViewModel = Get.find();
  SchoolDetailController _schoolDetailController = Get.find();

  List variationInfo2 = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailScreenController>(
      builder: (controller) {
        return Material(
          child: controller.selectProductList.indexWhere((element) =>
                      element.keys.toList().contains(widget.curentId)) >
                  -1
              ? qntGreateeThan1()
              : controller.selectProductList.indexWhere((element) =>
                          element.keys.toList().contains(widget.curentId)) >
                      0
                  ? addQntBtn(controller)
                  : widget.quantity == ''
                      ? addQntBtn(controller)
                      : int.parse(widget.quantity) > 0
                          ? qntGreateeThan1()
                          : addQntBtn(controller),
        );
      },
    );
  }

  Material addQntBtn(ProductDetailScreenController controller) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      child: Ink(
        height: Get.height * 0.03,
        width: Get.width * 0.17,
        decoration: BoxDecoration(
            color: ColorPicker.navyBlue,
            borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () async {
            _productDetailScreenController.setCurrentId(
              curentValueId: widget.responsId,
            );
            _productDetailScreenController.resetOrderCountRelated();

            var userId = PreferenceManager.getTokenId();
            if (userId == null) {
              return Get.to(SignInScreen());
            } else {
              if (widget.variation == 'YES') {
                if (widget.variationCount == '2') {
                  if (widget.dropdownValue != null &&
                      widget.dropdownValue1 != null) {
                    _userInfo2.userId = PreferenceManager.getTokenId();
                    _userInfo2.productId = widget.curentId;

                    variationInfo2 = [];
                    variationInfo2.add(widget.dropdown);
                    variationInfo2.add(widget.dropdown1);

                    print('---variationInfo2-----$variationInfo2');

                    _userInfo2.variationsStock = variationInfo2;
                    await _variationInfo2ViewModel
                        .variationInfo2ViewModel(_userInfo2);
                    VariationInfo2Response info2Response =
                        _variationInfo2ViewModel.apiResponse.data;
                    if (info2Response.status == 200) {
                      int currentQnt = 1;
                      int currentIndex = controller.selectProductList
                          .indexWhere(
                              (e) => e.keys.toList().contains(widget.curentId));

                      if (controller.selectProductList.isEmpty) {
                        controller.selectProductList.add({
                          widget.curentId: widget.quantity == ''
                              ? 1
                              : int.parse(widget.quantity)
                        });
                      } else if (currentIndex > -1) {
                        currentQnt = controller.selectProductList[currentIndex]
                            [widget.curentId]++;
                      } else {
                        controller.selectProductList.add({
                          widget.curentId: widget.quantity == ''
                              ? 1
                              : int.parse(widget.quantity)
                        });
                      }
                      _productDetailScreenController
                          .setIncrementOrderCountRelated();

                      AddToCartReq _user = AddToCartReq();

                      _user.userId = userId;
                      _user.productId = '${widget.curentId}';
                      _user.qty = '$currentQnt';
                      log("QUNTY ${_user.qty}");
                      _user.studentName = '';

                      _user.studentRoll = '';
                      _user.pvsmId = info2Response.response[0].pvsmId;
                      _user.variationsnIfo = variationInfo2;
                      _user.additionalSetInfo = '';
                      _user.qtyUpdate = '1';

                      _user.pbdId = '';
                      _user.booksetCustomize = '';
                      _user.booksetProductIds = '';

                      _user.booksetCustomizeArray = '';

                      _addToCartViewModel
                          .addToCartViewModel(model: _user)
                          .then((value) {
                        AddToCartResponse _addToCartResponse =
                            _addToCartViewModel.apiResponse.data;
                        widget.currentPageApiCall();
                        if (_addToCartResponse.status == 200) {
                          CommonSnackBar.showSnackBar(
                              successStatus: true,
                              msg: _addToCartResponse.message);
                        }
                        countSetCart();
                      });
                    }
                  } else {
                    CommonSnackBar.showSnackBar(
                        successStatus: false, msg: "Please select variation");
                  }
                } else if (widget.dropdownValue != null &&
                    widget.variationCount == '1') {
                  _userInfo2.userId = PreferenceManager.getTokenId();
                  _userInfo2.productId = widget.curentId;

                  variationInfo2 = [];
                  variationInfo2.add(widget.dropdown);
                  // variationInfo2.add(widget.dropdown1);

                  print('---variationInfo2-----$variationInfo2');

                  _userInfo2.variationsStock = variationInfo2;
                  await _variationInfo2ViewModel
                      .variationInfo2ViewModel(_userInfo2);
                  VariationInfo2Response info2Response =
                      _variationInfo2ViewModel.apiResponse.data;
                  if (info2Response.status == 200) {
                    int currentQnt = 1;
                    int currentIndex = controller.selectProductList.indexWhere(
                        (e) => e.keys.toList().contains(widget.curentId));

                    if (controller.selectProductList.isEmpty) {
                      controller.selectProductList.add({
                        widget.curentId: widget.quantity == ''
                            ? 1
                            : int.parse(widget.quantity)
                      });
                    } else if (currentIndex > -1) {
                      currentQnt = controller.selectProductList[currentIndex]
                          [widget.curentId]++;
                    } else {
                      controller.selectProductList.add({
                        widget.curentId: widget.quantity == ''
                            ? 1
                            : int.parse(widget.quantity)
                      });
                    }
                    _productDetailScreenController
                        .setIncrementOrderCountRelated();

                    AddToCartReq _user = AddToCartReq();

                    _user.userId = userId;
                    _user.productId = '${widget.curentId}';
                    _user.qty = '$currentQnt';
                    log("QUNTY ${_user.qty}");
                    _user.studentName = '';

                    _user.studentRoll = '';
                    _user.pvsmId = info2Response.response[0].pvsmId;
                    _user.variationsnIfo = variationInfo2;
                    _user.additionalSetInfo = '';
                    _user.qtyUpdate = '1';

                    _user.pbdId = '';
                    _user.booksetCustomize = '';
                    _user.booksetProductIds = '';

                    _user.booksetCustomizeArray = '';

                    _addToCartViewModel
                        .addToCartViewModel(model: _user)
                        .then((value) {
                      AddToCartResponse _addToCartResponse =
                          _addToCartViewModel.apiResponse.data;
                      widget.currentPageApiCall();
                      if (_addToCartResponse.status == 200) {
                        CommonSnackBar.showSnackBar(
                            successStatus: true,
                            msg: _addToCartResponse.message);
                      }
                      countSetCart();
                    });
                  }
                } else {
                  CommonSnackBar.showSnackBar(
                      successStatus: false, msg: "Please select variation");
                }
              } else {
                int currentQnt = 1;
                int currentIndex = controller.selectProductList.indexWhere(
                    (e) => e.keys.toList().contains(widget.curentId));

                if (controller.selectProductList.isEmpty) {
                  controller.selectProductList.add({
                    widget.curentId:
                        widget.quantity == '' ? 1 : int.parse(widget.quantity)
                  });
                } else if (currentIndex > -1) {
                  currentQnt = controller.selectProductList[currentIndex]
                      [widget.curentId]++;
                } else {
                  controller.selectProductList.add({
                    widget.curentId:
                        widget.quantity == '' ? 1 : int.parse(widget.quantity)
                  });
                }
                _productDetailScreenController.setIncrementOrderCountRelated();

                AddToCartReq _user = AddToCartReq();

                _user.userId = userId;
                _user.productId = '${widget.curentId}';
                _user.qty = '$currentQnt';
                log("QUNTY ${_user.qty}");
                _user.studentName = '';

                _user.studentRoll = '';
                _user.pvsmId = '';
                _user.variationsnIfo = [];
                _user.additionalSetInfo = '';
                _user.qtyUpdate = '1';

                _user.pbdId = '';
                _user.booksetCustomize = '';
                _user.booksetProductIds = '';

                _user.booksetCustomizeArray = '';

                _addToCartViewModel
                    .addToCartViewModel(model: _user)
                    .then((value) {
                  AddToCartResponse _addToCartResponse =
                      _addToCartViewModel.apiResponse.data;
                  print('-----widget.currentPageApiCall-------');
                  widget.currentPageApiCall();

                  if (_addToCartResponse.status == 200) {
                    CommonSnackBar.showSnackBar(
                        successStatus: true, msg: _addToCartResponse.message);
                  }
                  countSetCart();
                });
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.shopping_cart,
                size: Get.height * 0.02,
                color: Colors.white,
              ),
              Text(
                "ADD",
                style:
                    TextStyle(fontSize: Get.height * 0.02, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container qntGreateeThan1() {
    return Container(
      height: Get.height * 0.03,
      width: Get.width * 0.18,
      decoration: BoxDecoration(
          color: ColorPicker.navyBlue, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onTapDecrement,
            child: Icon(
              Icons.delete,
              size: Get.height * 0.02,
              color: Colors.white,
            ),
          ),
          GetBuilder<ProductDetailScreenController>(
            builder: (controller) {
              String isCurrentValue = '${controller.selectProductList.isEmpty}';
              int index = controller.selectProductList
                  .indexWhere((e) => e.keys.toList().contains(widget.curentId));
              print('----cindex--$index');
              print('---clist---${controller.selectProductList}');
              int currentQuantity = 1;

              if (controller.selectProductList.isEmpty) {
                currentQuantity =
                    widget.quantity == '' ? 1 : int.parse(widget.quantity);
              } else if (index > -1) {
                currentQuantity =
                    controller.selectProductList[index][widget.curentId];
              } else {
                currentQuantity =
                    widget.quantity == '' ? 1 : int.parse(widget.quantity);
              }
              log("CONTROLLER ${controller.isOrderCountRelated}");
              log("_productDetailScreenController ${_productDetailScreenController.isOrderCountRelated}");
              return Container(
                height: Get.height * 0.028,
                width: Get.width * 0.06,
                color: Colors.white,
                child: Center(
                    child: Text(
                  "$currentQuantity",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              );
            },
          ),
          InkWell(
            onTap: widget.onTapIncrement,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: Get.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}

class CartUpdateButton extends StatefulWidget {
  final Function onTapIncrement;
  final Function onTapDecrement;
  final String updateValue;

  const CartUpdateButton(
      {this.onTapIncrement, this.onTapDecrement, this.updateValue});

  @override
  _CartUpdateButtonState createState() => _CartUpdateButtonState();
}

class _CartUpdateButtonState extends State<CartUpdateButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.03,
      width: Get.width * 0.18,
      decoration: BoxDecoration(
          color: ColorPicker.navyBlue, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onTapDecrement,
            child: Icon(
              Icons.delete,
              size: Get.height * 0.02,
            ),
          ),
          Container(
            height: Get.height * 0.028,
            width: Get.width * 0.06,
            color: Colors.white,
            child: Center(
                child: Text(
              widget.updateValue,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
          InkWell(
            onTap: widget.onTapIncrement,
            child: Icon(
              Icons.add,
              size: Get.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
