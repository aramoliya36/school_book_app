import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/cart_count_method.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/controller/wish_list_controller.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/reqestModel/remove_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/add_to_cart_response_model.dart';
import 'package:skoolmonk/model/responseModel/get_wish_list_response_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';
import 'package:skoolmonk/viewModel/get_wish_list_view_model.dart';
import 'package:skoolmonk/viewModel/remove_cart_view_model.dart';
import '../../common/circularprogress_indicator.dart';
import '../../common/color_picker.dart';
import '../../common/common_image.dart';
import '../../common/servor_error_text.dart';
import '../../common/whish_list_count_methode.dart';
import '../../model/apis/api_response.dart';
import '../../model/reqestModel/post_wishlist_req_model.dart';
import '../../viewModel/post_wishlist_view_model.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  GetWishListViewModel getWishListViewModel = Get.find();
  WishListController _wishListController = Get.find();
  AddToCartViewModel _addToCartViewModel = Get.find();
  RemoveCartViewModel _removeCartViewModel = Get.find();

  PostWishListViewModel _postWishListViewModel = Get.find();
  // BottomController homeController = Get.find();
  SchoolDetailController _schoolDetailController = Get.find();
  BottomController homeController = Get.find();

  ProductDetailScreenController _productDetailScreenController = Get.find();

  int _changeIndex = 0;

  @override
  void initState() {
    getWishListViewModel.getWishListViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        colorController.colorChange.value = 10;
        homeController.selectedScreen('HomeScreen');
        homeController.bottomIndex.value = 0;

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Color(0xffF5F6F7),
        appBar: _buildAppBar(),
        body: GetBuilder<GetWishListViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return circularProgress();
            }
            if (controller.apiResponse.status == Status.ERROR) {
              return Material(
                  color: Colors.white, child: Center(child: serverErrorText()));
            }
            if (controller.apiResponse.status == Status.COMPLETE) {
              GetWishListResponseModel response = controller.apiResponse.data;
              return SingleChildScrollView(child: _buildBody(response));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {
          print('---------wishlist');
          //Get.back();

          colorController.colorChange.value = 10;
          homeController.selectedScreen('HomeScreen');
          homeController.bottomIndex.value = 0;

          print('---------wishlist1');
        },
        appTitle: "WishList",
        leadingIcon: Icons.arrow_back_rounded);
  }

  Widget _buildBody(GetWishListResponseModel response) {
    return Column(
      children: [
        response.response.length == 0
            ? Container(
                height: Get.height / 1.3,
                width: double.infinity,
                child: Center(child: Text('No WishList Data')))
            : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.height * 0.014, vertical: Get.height * 0.02),
          child: GridView.builder(
              itemCount: response.response.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: .63,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: Get.height * 0.01,
                  crossAxisSpacing: Get.height * 0.01),
              itemBuilder: (context, index) {
                final resp = response.response[index];
                return InkWell(
                  onTap: () {
                    print('SINGLE PRODUCT');
                    if (resp.productType == 'Single') {
                      print('SINGLE PRODUCT 1');

                      _schoolDetailController.setTitleSlugProductDetailsScreen(
                          titleSlugProductDetails: resp.productSlug);
                      //Get.to(ProductDetailScreen());
                      homeController.selectedScreen('ProductDetailScreen');

                      homeController.bottomIndex.value = 1;
                    } else {
                      print('SINGLE PRODUCT 2');

                      _schoolDetailController.setTitleSlugProductDetailsScreen(
                          titleSlugProductDetails: resp.productSlug);

                      homeController.bottomIndex.value = 2;

                      homeController.selectedScreen('ProductDetailScreen');
                    }
                  },
                  child: Card(
                    elevation: 5,
                    child: Material(
                      child: Ink(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  imageSliderWishWidget(index, response),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                height: Get.height / 29,
                                                // color: Colors.deepOrange,
                                                child: Text(
                                                  response.response[index]
                                                          .productName ??
                                                      '',
                                                  // overflow: TextOverflow
                                                  //     .ellipsis,
                                                  maxLines: 2,

                                                  style: CommonTextStyle
                                                      .productTitle,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "₹ ${response.response[index].productSalePrice ?? ''}",
                                                        style: CommonTextStyle
                                                            .priceTextStyle),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'MRP',
                                                          style: CommonTextStyle
                                                              .MRPTextStyle,
                                                        ),
                                                        Text(
                                                          ' ₹ ${response.response[index].productPrice ?? ''}',
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
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child:
                                                            Icon(Icons.delete),
                                                        onTap: () {
                                                          PostWishListReqModel
                                                              _userWish =
                                                              PostWishListReqModel();
                                                          _userWish.productId =
                                                              response
                                                                  .response[0]
                                                                  .productId;
                                                          _userWish.status =
                                                              'REMOVE';
                                                          _postWishListViewModel
                                                              .postWishListViewModel(
                                                                  model:
                                                                      _userWish)
                                                              .then((value) {
                                                            countSetWishCart();
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(),
                                                    resp.productStockStatus ==
                                                            'OUT'
                                                        ? Text(
                                                            'Out of Stock',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Get.width /
                                                                        40),
                                                          )
                                                        : (resp.productType ==
                                                                    'Single' &&
                                                                resp.variation ==
                                                                    'YES')
                                                            ? Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child: Ink(
                                                                  height:
                                                                      Get.height *
                                                                          0.03,
                                                                  width:
                                                                      Get.width *
                                                                          0.18,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorPicker
                                                                          .navyBlue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "View",
                                                                      style: TextStyle(
                                                                          fontSize: Get.height *
                                                                              0.018,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : (resp.productType ==
                                                                        'Single' &&
                                                                    resp.variation ==
                                                                        'NO')
                                                                ? GetBuilder<
                                                                    ProductDetailScreenController>(
                                                                    builder:
                                                                        (controller) {
                                                                      var _currentUserId =
                                                                          PreferenceManager
                                                                              .getTokenId();
                                                                      return AddCartButton(
                                                                        currentPageApiCall:
                                                                            () {
                                                                          getWishListViewModel
                                                                              .getWishListViewModel();
                                                                        },
                                                                        responsId:
                                                                            resp.productId,
                                                                        curentId:
                                                                            resp.productId,
                                                                        quantity:
                                                                            resp.productInUserCartQuantity,
                                                                        onTapDecrement:
                                                                            () async {
                                                                          if (_currentUserId ==
                                                                              null) {
                                                                            return Get.to(SignInScreen());
                                                                          } else {
                                                                            String
                                                                                pId =
                                                                                resp.productId;
                                                                            int qnt = resp.productInUserCartQuantity == ''
                                                                                ? 1
                                                                                : int.parse(resp.productInUserCartQuantity);

                                                                            int index =
                                                                                controller.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));
                                                                            if (index ==
                                                                                -1) {
                                                                              controller.setAddSelectProductList(id: resp.productId, quantity: qnt);
                                                                              index = controller.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));
                                                                            }

                                                                            print('INDEX...:$index');
                                                                            if (index >
                                                                                -1) {
                                                                              print('INDEX VALUE :${controller.selectProductList[index][pId]}');
                                                                              if (controller.selectProductList[index][pId] > 1) {
                                                                                controller.setDecrementSelectListProductQDec(
                                                                                  pId,
                                                                                  qnt,
                                                                                );
                                                                                AddToCartReq _user = AddToCartReq();

                                                                                _user.userId = PreferenceManager.getTokenId() ?? '0';
                                                                                _user.productId = '${resp.productId}';
                                                                                _user.qty = '${controller.selectProductList[index][pId]}';
                                                                                _user.studentName = '';
                                                                                _user.qtyUpdate = '1';

                                                                                _user.studentRoll = '';
                                                                                _user.pvsmId = '';
                                                                                _user.variationsnIfo = [];
                                                                                _user.additionalSetInfo = '';

                                                                                _user.pbdId = '';
                                                                                _user.booksetCustomize = '';
                                                                                _user.booksetProductIds = '';

                                                                                _user.booksetCustomizeArray = '';

                                                                                await _addToCartViewModel.addToCartViewModel(model: _user);
                                                                              } else {
                                                                                RemoveReqModel _user = RemoveReqModel();
                                                                                _user.userId = '${PreferenceManager.getTokenId()}';
                                                                                _user.cartId = '${resp.productInUserCartId}';
                                                                                _removeCartViewModel.removeCartViewModel(model: _user).then((value) async {
                                                                                  await getWishListViewModel.getWishListViewModel();

                                                                                  countSetCart();
                                                                                  CommonSnackBar.showSnackBar(successStatus: true, msg: 'Removed from cart.');

                                                                                  _productDetailScreenController.removeSelectProductList(key: resp.productId);
                                                                                });
                                                                                print('remove from all');
                                                                              }
                                                                            }
                                                                          }
                                                                        },
                                                                        onTapIncrement:
                                                                            () async {
                                                                          if (_currentUserId ==
                                                                              null) {
                                                                            return Get.to(SignInScreen());
                                                                          } else {
                                                                            String
                                                                                pId =
                                                                                resp.productId;
                                                                            int qnt = resp.productInUserCartQuantity == ''
                                                                                ? 1
                                                                                : int.parse(
                                                                                    resp.productInUserCartQuantity,
                                                                                  );
                                                                            controller.setIncrementSelectListProductQInc(
                                                                              pId,
                                                                              qnt,
                                                                            );
                                                                            int index =
                                                                                controller.selectProductList.indexWhere((element) => element.keys.toList().contains(pId));

                                                                            AddToCartReq
                                                                                _user =
                                                                                AddToCartReq();

                                                                            _user.userId =
                                                                                PreferenceManager.getTokenId() ?? '0';
                                                                            _user.productId =
                                                                                '${resp.productId}';

                                                                            _user.qty =
                                                                                '${controller.selectProductList[index][pId]}';
                                                                            _user.studentName =
                                                                                '';
                                                                            _user.qtyUpdate =
                                                                                '1';

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

                                                                            await _addToCartViewModel.addToCartViewModel(model: _user);
                                                                            AddToCartResponse
                                                                                _res =
                                                                                _addToCartViewModel.apiResponse.data;
                                                                            if (_res.status ==
                                                                                200) {
                                                                              getWishListViewModel.getWishListViewModel();

                                                                              CommonSnackBar.showSnackBar(successStatus: true, msg: _res.message);
                                                                            } else {
                                                                              controller.setDecrementSelectListProductQDec(
                                                                                pId,
                                                                                qnt,
                                                                              );
                                                                              CommonSnackBar.showSnackBar(successStatus: true, msg: _res.message);
                                                                            }
                                                                          }
                                                                        },
                                                                      );
                                                                    },
                                                                  )
                                                                : SizedBox(),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              response.response[index].productDiscount
                                          .isEmpty ||
                                      response.response[index]
                                              .productDiscount ==
                                          ''
                                  ? SizedBox()
                                  : Positioned(
                                      left: -Get.width * 0.02,
                                      top: -4,
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
                                          padding: EdgeInsets.only(
                                              left: Get.height * 0.012),
                                          child: Text(
                                            "${response.response[index].productDiscount ?? ''}\nOFF",
                                            style: TextStyle(
                                                fontSize: Get.height * 0.0183,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Expanded imageSliderWishWidget(int index, GetWishListResponseModel response) {
    return Expanded(
      flex: 3,
      child: Column(
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
                        _wishListController.setProductUniqId(
                            value: response.response[index].productId);
                      });
                    },
                    viewportFraction: 1.0,

                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: response.response[index].productImgs.isEmpty
                      ? commonImage(
                          widthImage: Get.width * 0.3,
                        )
                      : (response.response[index].productImgs)
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
          response.response[index].productImgs.length == 1
              ? SizedBox()
              : GetBuilder<WishListController>(
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        response.response[index].productImgs.length,
                        (subindex) => Padding(
                            padding: EdgeInsets.all(Get.height * 0.002),
                            child: CircleAvatar(
                              radius: Get.height * 0.004,
                              backgroundColor: (_changeIndex == subindex &&
                                      controller.productUniqId ==
                                          response.response[index].productId)
                                  ? Colors.black
                                  : Colors.grey,
                            )),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
