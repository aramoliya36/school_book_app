import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/cart_count_method.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/controller/sub_category_list_controller.dart';
import 'package:skoolmonk/model/repo/MainCategoriesSubcategoriesProductFilter_repo.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/reqestModel/remove_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/remove_cart_view_model.dart';
import 'package:skoolmonk/viewModel/sub_category_list_last_api_viewmodel.dart';

import '../../../model/responseModel/add_to_cart_response_model.dart';

class SubCategoryListGrid extends StatefulWidget {
  final Product product;
  final int index;

  const SubCategoryListGrid({Key key, this.product, this.index})
      : super(key: key);

  @override
  _SubCategoryListGridState createState() => _SubCategoryListGridState();
}

class _SubCategoryListGridState extends State<SubCategoryListGrid> {
  BottomController homeController = Get.find();

  bool isBottom = true;
  MainCategoriesSubcategoriesProductFilterResponse responseNew =
      MainCategoriesSubcategoriesProductFilterResponse();
  ProductDetailScreenController _productDetailScreenController = Get.find();
  SubCategoryListController _subCategoryListController =
      Get.put(SubCategoryListController());
  BottomController bottomController = Get.find();
  AddToCartViewModel _addToCartViewModel = Get.find();
  SubCategoryController subCategoryController = Get.find();
  MainCategoriesSubcategoriesProductFilterRequest _user =
      MainCategoriesSubcategoriesProductFilterRequest();
  SchoolDetailController _schoolDetailController = Get.find();
  RemoveCartViewModel _removeCartViewModel = Get.find();
  SubCategoryListLastViewModelController _fLast = Get.find();

  // MainCategoriesSubcategoriesProductFilterViewModel _filterViewModel =
  //     Get.find();
  MainCategoriesSubcategoriesProductFilterResponse _resRemove;
  int _changeIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('productStockStatus----${widget.product.productStockStatus}');
    print('productStockStatus----${widget.product.productId}');
    print('productStockStatus--variation--${widget.product.variation}');
    print('productStockStatus--index--${widget.index}');
    return Card(
      elevation: 5,
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              _schoolDetailController.setTitleSlugProductDetailsScreen(
                  titleSlugProductDetails: widget.product.productSlug);
              bottomController.selectedScreen('ProductDetailScreen');
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: imageSliderWidget()),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Divider(
                            thickness: 1,
                          ),
                          Container(
                            width: Get.width,
                            height: Get.height / 23,
                            // color: Colors.deepOrange,
                            child: Container(
                              child: Align(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width / 80),
                                  child: Text(
                                    widget.product.productName ?? '',
                                    //overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: CommonTextStyle.productTitle,
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              width: Get.width / 3,
                              // color: Colors.deepOrange,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Get.height * 0.006,
                                  // left: Get.height * 0.006,
                                  right: Get.height * 0.006),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width / 80),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "₹ ${widget.product.productSalePrice ?? ''}",
                                        style: CommonTextStyle.priceTextStyle),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'MRP',
                                                    style: TextStyle(
                                                      fontSize: Get.width / 46,
                                                      color: Color(0xff8e8e8e),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' ₹ ${widget.product.productPrice ?? ''}',
                                                    style: CommonTextStyle
                                                        .cancelPrice,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Incl. of all taxes",
                                                style: CommonTextStyle
                                                    .taxIncludeStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        widget.product.productStockStatus ==
                                                'OUT'
                                            ? Text(
                                                'Out of Stock',
                                                style: TextStyle(
                                                    fontSize: Get.width / 40),
                                              )
                                            : (widget.product.productType ==
                                                        'Single' &&
                                                    widget.product.variation ==
                                                        "NO")
                                                ? GetBuilder<
                                                    ProductDetailScreenController>(
                                                    builder: (controller) {
                                                      var _currentUserId =
                                                          PreferenceManager
                                                              .getTokenId();
                                                      return AddCartButton(
                                                        responsId: widget
                                                            .product.productId,
                                                        curentId: widget
                                                            .product.productId,
                                                        quantity: widget.product
                                                            .productInUserCartQuantity,
                                                        currentPageApiCall:
                                                            () async {
                                                          // homeController
                                                          //     .selectedScreen(
                                                          //         'ProductDetailScreen');
                                                          // homeController
                                                          //     .selectedScreen(
                                                          //         'SubCategoryList');
                                                          var filterDataSendApi =
                                                              PreferenceManager
                                                                  .getStorage
                                                                  .read(
                                                                      "categorySlug");

                                                          _user.userId =
                                                              PreferenceManager
                                                                      .getTokenId() ??
                                                                  '0';
                                                          _user.catSlug =
                                                              '${subCategoryController.catSlugFilter}';
                                                          _user.page = _fLast
                                                                      .pageIndex
                                                                      ?.toString() ==
                                                                  null
                                                              ? '0'
                                                              : _fLast.pageIndex
                                                                  .toString();
                                                          _user.count = 'NO';
                                                          _user
                                                              .perpage = Utility
                                                                  .perPageSize
                                                                  .toString() ??
                                                              '0';
                                                          _user.filter =
                                                              '$filterDataSendApi';
                                                          await _fLast
                                                              .subCategoryListLastViewModelController(
                                                                  model: _user,
                                                                  isLoading:
                                                                      true);
                                                          _fLast.isAddRightNow =
                                                              true;
                                                          _resRemove = _fLast
                                                              .apiResponse.data;
                                                        },
                                                        onTapDecrement: () {
                                                          if (_currentUserId ==
                                                              null) {
                                                            return Get.to(
                                                                SignInScreen());
                                                          } else {
                                                            String pId = widget
                                                                .product
                                                                .productId;
                                                            int qnt = widget
                                                                        .product
                                                                        .productInUserCartQuantity ==
                                                                    ''
                                                                ? 0
                                                                : int.parse(widget
                                                                    .product
                                                                    .productInUserCartQuantity);

                                                            int index = controller
                                                                .selectProductList
                                                                .indexWhere((element) =>
                                                                    element.keys
                                                                        .toList()
                                                                        .contains(
                                                                            pId));
                                                            if (index == -1) {
                                                              controller.setAddSelectProductList(
                                                                  id: widget
                                                                      .product
                                                                      .productId,
                                                                  quantity:
                                                                      qnt);
                                                              index = controller
                                                                  .selectProductList
                                                                  .indexWhere((element) => element
                                                                      .keys
                                                                      .toList()
                                                                      .contains(
                                                                          pId));
                                                            }

                                                            print(
                                                                'INDEX...:$index');

                                                            if (index > -1) {
                                                              print(
                                                                  'INDEX VALUE :${controller.selectProductList[index][pId]}');
                                                              if (controller.selectProductList[
                                                                          index]
                                                                      [pId] >
                                                                  1) {
                                                                AddToCartReq
                                                                    _user =
                                                                    AddToCartReq();
                                                                controller
                                                                    .setDecrementSelectListProductQDec(
                                                                  pId,
                                                                  qnt,
                                                                );
                                                                _user.userId =
                                                                    PreferenceManager
                                                                            .getTokenId() ??
                                                                        '0';
                                                                _user.productId =
                                                                    '${widget.product.productId}';
                                                                _user.qty =
                                                                    '${controller.selectProductList[index][pId]}';
                                                                _user.qtyUpdate =
                                                                    '1';

                                                                _user.studentName =
                                                                    '';

                                                                _user.studentRoll =
                                                                    '';
                                                                _user.pvsmId =
                                                                    '';
                                                                _user.variationsnIfo =
                                                                    [];
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
                                                                  // Get.back();
                                                                  // homeController
                                                                  //     .selectedScreen(
                                                                  //         'SubCategoryList');
                                                                });
                                                              } else {
                                                                RemoveReqModel
                                                                    _userRemove =
                                                                    RemoveReqModel();
                                                                _userRemove
                                                                        .userId =
                                                                    '${PreferenceManager.getTokenId()}';
                                                                _userRemove
                                                                    .cartId = _fLast
                                                                            .isAddRightNow ==
                                                                        true
                                                                    ? _resRemove
                                                                        .response[
                                                                            0]
                                                                        .product[widget
                                                                            .index]
                                                                        .productInUserCartId
                                                                    : widget
                                                                        .product
                                                                        .productInUserCartId;
                                                                // '${widget.product.productInUserCartId}';
                                                                _removeCartViewModel
                                                                    .removeCartViewModel(
                                                                        model:
                                                                            _userRemove)
                                                                    .then(
                                                                        (value) async {
                                                                  controller.removeSelectProductList(
                                                                      key: widget
                                                                          .product
                                                                          .productId);
                                                                  // homeController
                                                                  //     .selectedScreen(
                                                                  //         'ProductDetailScreen');
                                                                  // homeController
                                                                  //     .selectedScreen(
                                                                  //         'SubCategoryList');
                                                                  countSetCart();

                                                                  print(
                                                                      '-------List OF COUNT ${controller.selectProductList}');
                                                                });
                                                              }
                                                            }
                                                          }
                                                        },
                                                        onTapIncrement: () {
                                                          if (_currentUserId ==
                                                              null) {
                                                            return Get.to(
                                                                SignInScreen());
                                                          } else {
                                                            String pId = widget
                                                                .product
                                                                .productId;
                                                            int qnt = widget
                                                                        .product
                                                                        .productInUserCartQuantity ==
                                                                    ''
                                                                ? 0
                                                                : int.parse(
                                                                    widget
                                                                        .product
                                                                        .productInUserCartQuantity,
                                                                  );
                                                            print('----$pId');
                                                            print('----$qnt');
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
                                                                        .contains(
                                                                            pId));

                                                            AddToCartReq _user =
                                                                AddToCartReq();

                                                            _user.userId =
                                                                PreferenceManager
                                                                        .getTokenId() ??
                                                                    '0';
                                                            _user.productId =
                                                                '${widget.product.productId}';
                                                            _user.qty =
                                                                '${controller.selectProductList[index][pId]}';
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
                                                            _user.qtyUpdate =
                                                                '1';

                                                            _addToCartViewModel
                                                                .addToCartViewModel(
                                                                    model:
                                                                        _user)
                                                                .then((value) {
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
                                                                controller
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
                                                          }
                                                        },
                                                      );
                                                    },
                                                  )
                                                : (widget.product.productType ==
                                                            'Single' &&
                                                        widget.product
                                                                .variation ==
                                                            "YES")
                                                    ? Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Ink(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.18,
                                                          decoration: BoxDecoration(
                                                              color: ColorPicker
                                                                  .navyBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.018),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                widget.product.productDiscount == ''
                    ? SizedBox()
                    : Positioned(
                        left: -Get.width * 0.028,
                        top: -5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: Get.height * 0.07,
                          width: Get.height * 0.07,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                )
                              ],
                              shape: BoxShape.circle,
                              color: ColorPicker.redColorApp),
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.015),
                            child: Text(
                              "${widget.product.productDiscount ?? ''}\nOFF",
                              style: TextStyle(
                                  fontSize: Get.height * 0.017,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSliderWidget() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: Get.width * 0.3,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: Get.height * 0.17,
                  onPageChanged: (val, reason) {
                    setState(() {
                      _changeIndex = val;
                      _subCategoryListController.setProductUniqId(
                          value: widget.product.productId);
                    });
                  },
                  viewportFraction: 1.0,

                  enlargeCenterPage: false,
                  // autoPlay: false,
                ),
                items: widget.product.productImgs.isEmpty
                    ? commonImage(
                        widthImage: Get.width * 0.3,
                      )
                    : (widget.product.productImgs)
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Image.network(
                              item.productImg.trim(),
                              width: Get.width * 0.3,
                              fit: BoxFit.cover,
                            )),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
        widget.product.productImgs.length == 1
            ? SizedBox()
            : GetBuilder<SubCategoryListController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.product.productImgs.length,
                      (subindex) => Padding(
                          padding: EdgeInsets.all(Get.height * 0.002),
                          child: CircleAvatar(
                            radius: Get.height * 0.004,
                            backgroundColor: (_changeIndex == subindex &&
                                    controller.productUniqId ==
                                        widget.product.productId)
                                ? Colors.black
                                : Colors.grey,
                            // backgroundColor: (controller.productUniqId.isEmpty ||
                            //         _changeIndex == subindex)
                            //     ? Colors.black
                            //     : (controller.productUniqId ==
                            //                 widget.respons.response[0]
                            //                     .product[index].productId &&
                            //             _changeIndex == subindex)
                            //         ? Colors.black
                            //         : Colors.grey,
                          )),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
