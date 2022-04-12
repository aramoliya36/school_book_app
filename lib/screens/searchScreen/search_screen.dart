import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';
import 'package:skoolmonk/controller/search_controller.dart';
import 'package:skoolmonk/controller/sub_category_list_controller.dart';
import 'package:skoolmonk/model/repo/search_repo.dart';
import 'package:skoolmonk/model/reqestModel/add_to_cart_reqest.dart';
import 'package:skoolmonk/model/responseModel/search_product_model.dart';
import 'package:skoolmonk/model/responseModel/search_suggestion_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/viewModel/add_to_cart_view_model.dart';

import '../../common/circularprogress_indicator.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearchCall = false;
  SearchRepo searchRepo = SearchRepo();
  String userId = '';
  BottomController homeController = Get.find();
  SearchController _controller = Get.find();

  /// TextField Controller
  TextEditingController _searchProductController;

  @override
  void initState() {
    // TODO: implement initState
    userId = PreferenceManager.getTokenId() ?? '0';

    _searchProductController = TextEditingController();
    _controller.setSearchProduct('');

    super.initState();
  }

  Future searchSuggestionProducts(String productName) async {
    print("IS SEARCH CALL $isSearchCall");
    print("IS SEARCH SUGGSTION PRODUCT API CALL");
    dynamic response = await searchRepo.searchSuggestion(productName, userId);

    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchSuggestionModel _searchProductModel =
          SearchSuggestionModel.fromJson(response);

      return _searchProductModel;
    }
  }

  /// search products....
  Future searchProducts(String productName) async {
    print("IS SEARCH PRODUCT API CALL");
    dynamic response =
        await searchRepo.searchProductHomePage(productName, userId);
    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchProductModel _searchProductModel =
          SearchProductModel.fromJson(response);
      // isSearchCall = false;
      return _searchProductModel;
    }
  }

  SchoolDetailController _schoolDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        colorController.colorChange.value = 10;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {
          colorController.colorChange.value = 10;
          // homeController.selectedScreen('HomeScreen');
          // homeController.bottomIndex.value = 0;
          Get.back();
        },
        appTitle: "Search",
        leadingIcon: Icons.arrow_back_rounded);
  }

  Widget _buildBody() {
    log('ENTER BODY SING');

    return GetBuilder<SearchController>(
      builder: (controller) {
        log('ENTER COLUMN SING');

        return Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            // searchButton(),
            searchBar(
                title: "Search Products",
                width: Get.width,
                controller: _searchProductController,
                onSubmitted: (v) {
                  controller.setSearchProduct(_searchProductController.text);
                  isSearchCall = true;
                  FocusScope.of(context).unfocus();
                },
                // searchClick: true,
                // onSubmitted: () {
                //   controller.setSearchProduct(_searchProductController.text);
                //   isSearchCall = true;
                //   FocusScope.of(context).unfocus();
                // },

                onSearchTap: () {
                  controller.setSearchProduct(_searchProductController.text);
                  isSearchCall = true;
                  FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  print("IS SEARCH ALL SEARCH $value");
                  if (value.length > 0) {
                    searchSuggestionProducts(value);
                    // isSearchCall = false;
                    controller.setSearchProduct(value);

                    isSearchCall = false;
                  }
                }),
            isSearchCall == true
                ? Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      child: FutureBuilder(
                          future:
                              searchProducts(controller.searchProduct.value),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.response.length != 0) {
                                if (snapshot.data is SearchProductModel) {
                                  SearchProductModel _searchProductModel =
                                      snapshot.data;
                                  log('ENTER COMPLERTE SING');
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      //maxCrossAxisExtent: 300,
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2,

                                      mainAxisSpacing: Get.height * .01,
                                      crossAxisSpacing: Get.height * .01,
                                    ),
                                    itemBuilder: (context, index) {
                                      print(
                                          "STATUS DATA ${_searchProductModel.response[index].productStockStatus}");
                                      return GestureDetector(
                                        onTap: () {
                                          _schoolDetailController
                                              .setTitleSlugProductDetailsScreen(
                                                  titleSlugProductDetails:
                                                      _searchProductModel
                                                          .response[index]
                                                          .productSlug);

                                          homeController.bottomIndex.value = 0;

                                          homeController.selectedScreen(
                                              'ProductDetailScreen');
                                          Get.back();
                                        },
                                        child: buildBody(_searchProductModel
                                            .response[index]),
                                      );
                                    },
                                    itemCount:
                                        _searchProductModel.response.length,
                                  );
                                } else {
                                  return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: circularProgress(),
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.search),
                                        SizedBox(height: 30),
                                        Text('Search entire store here...'),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: circularProgress(),
                                ),
                              );
                            }
                          }),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      child: FutureBuilder(
                          future: searchSuggestionProducts(
                              controller.searchProduct.value),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.response.length != 0) {
                                if (snapshot.data is SearchSuggestionModel) {
                                  SearchSuggestionModel _searchProductModel =
                                      snapshot.data;
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          _searchProductModel.response.length,
                                          (index) {
                                        return InkWell(
                                          onTap: () {
                                            log("DATA ${_searchProductModel.response[index].productSlug}");
                                            if (_searchProductModel
                                                    .response[index]
                                                    .actionType ==
                                                "find") {
                                              _searchProductController.text =
                                                  _searchProductModel
                                                      .response[index]
                                                      .productName;
                                              setState(() {
                                                // _searchProductController()
                                              });
                                            } else {
                                              log("DETAILS TAB");

                                              _schoolDetailController
                                                  .setTitleSlugProductDetailsScreen(
                                                      titleSlugProductDetails:
                                                          _searchProductModel
                                                              .response[index]
                                                              .productSlug);
                                              homeController.selectedScreen(
                                                  'ProductDetailScreen');
                                              homeController.bottomIndex.value =
                                                  0;
                                              Get.back();
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              InkWell(
                                                child: Container(
                                                    width: Get.width,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      // borderRadius: BorderRadius.circular(10),
                                                      // border: Border.all(
                                                      //     color: Colors.grey.withOpacity(0.5),
                                                    ),
                                                    height: 30,
                                                    child: Text(
                                                        _searchProductModel
                                                            .response[index]
                                                            .productName)),
                                                onTap: () {
                                                  /*
                                                  controller.setSearchProduct(
                                                      _searchProductModel
                                                          .response[index]
                                                          .productSlug);
                                                  isSearchCall = true;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  setState(() {
                                                    _searchProductController
                                                            .text =
                                                        _searchProductModel
                                                            .response[index]
                                                            .productName;
                                                  });*/
                                                  if (_searchProductModel
                                                          .response[index]
                                                          .actionType ==
                                                      "find") {
                                                    controller.setSearchProduct(
                                                        _searchProductModel
                                                            .response[index]
                                                            .productSlug);
                                                    isSearchCall = true;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    setState(() {
                                                      _searchProductController
                                                              .text =
                                                          _searchProductModel
                                                              .response[index]
                                                              .productName;
                                                    });
                                                    /* _searchProductController
                                                            .text =
                                                        _searchProductModel
                                                            .response[index]
                                                            .productName;
                                                    setState(() {
                                                      // _searchProductController()
                                                    });*/
                                                  } else {
                                                    log("DETAILS TAB");

                                                    _schoolDetailController
                                                        .setTitleSlugProductDetailsScreen(
                                                            titleSlugProductDetails:
                                                                _searchProductModel
                                                                    .response[
                                                                        index]
                                                                    .productSlug);
                                                    homeController.selectedScreen(
                                                        'ProductDetailScreen');
                                                    homeController
                                                        .bottomIndex.value = 0;
                                                    Get.back();
                                                  }
                                                },
                                              ),
                                              Divider(
                                                color: Colors.black,
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: circularProgress(),
                                    ),
                                  );
                                }
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 40.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30),
                                      Text('Search your product here...'),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: circularProgress(),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            // productGridSearch()
          ],
        );
      },
    );
  }

  Widget buildBody(ProductResponse productResponse) {
    return productResponse == null
        ? Center(
            child: Text('No Product Available'),
          )
        : Column(
            children: [
              productResponse == null
                  ? SizedBox()
                  : SearchSuggestionGrid(
                      product: productResponse,
                    ),
            ],
          );
  }

  Widget searchBar(
      {width,
      title,
      onTap,
      onChanged,
      controller,
      onSearchTap,
      onSubmitted,
      bool showSearchTap = true}) {
    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.only(left: 5, top: 3),
        height: width / 8,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xfff3f3f3),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onTap: onTap,
                onChanged: onChanged,
                controller: controller,
                // onSubmitted: onChanged,
                onFieldSubmitted: onSubmitted,

                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: title,
                  hintStyle: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                    color: Color(0xff515C6F),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff515C6F),
                  ),
                ),
              ),
            ),
            showSearchTap
                ? InkWell(
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorPicker.themColor,
                        child: Icon(
                          Icons.forward,
                          size: 15,
                          color: Colors.black,
                        )),
                    onTap: onSearchTap,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class SearchSuggestionGrid extends StatefulWidget {
  final ProductResponse product;

  const SearchSuggestionGrid({Key key, this.product}) : super(key: key);

  @override
  _SearchSuggestionGridState createState() => _SearchSuggestionGridState();
}

class _SearchSuggestionGridState extends State<SearchSuggestionGrid> {
  int _changeIndex = 0;
  SubCategoryListController _subCategoryListController =
      Get.put(SubCategoryListController());
  ProductDetailScreenController _productDetailScreenController = Get.find();
  AddToCartViewModel _addToCartViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Card(
            elevation: 5,
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageSliderWidget(),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.006),
                            child: Text(
                              widget.product.productName ?? '',
                              // overflow: TextOverflow
                              //     .ellipsis,
                              style: CommonTextStyle.productTitle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.height * 0.006,
                                right: Get.height * 0.006),
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
                                              Expanded(
                                                child: Text(
                                                  'MRP',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Helvetica Neue',
                                                    fontSize: 10,
                                                    color:
                                                        const Color(0xff8e8e8e),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ' ₹ ${widget.product.productPrice ?? ''}',
                                                  style: CommonTextStyle
                                                      .cancelPrice,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Incl. of all taxes",
                                            style:
                                                CommonTextStyle.taxIncludeStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    widget.product.productType == 'Single'
                                        ? GetBuilder<
                                            ProductDetailScreenController>(
                                            builder: (controller) {
                                              var _currentUserId =
                                                  PreferenceManager
                                                      .getTokenId();
                                              return AddCartButton(
                                                responsId:
                                                    widget.product.productId,
                                                curentId:
                                                    widget.product.productId,
                                                quantity: widget.product
                                                    .productInUserCartQuantity,
                                                onTapDecrement: () {
                                                  if (_currentUserId == null) {
                                                    return Get.to(
                                                        SignInScreen());
                                                  } else {
                                                    String pId = widget
                                                        .product.productId;
                                                    int qnt = widget.product
                                                                .productInUserCartQuantity ==
                                                            ''
                                                        ? 1
                                                        : int.parse(widget
                                                            .product
                                                            .productInUserCartQuantity);

                                                    int index = controller
                                                        .selectProductList
                                                        .indexWhere((element) =>
                                                            element.keys
                                                                .toList()
                                                                .contains(pId));
                                                    print('INDEX...:$index');
                                                    if (index > -1) {
                                                      print(
                                                          'INDEX VALUE :${controller.selectProductList[index][pId]}');
                                                      if (controller
                                                                  .selectProductList[
                                                              index][pId] >
                                                          1) {
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
                                                        _user.studentName = '';
                                                        _user.qtyUpdate = '1';

                                                        _user.studentRoll = '';
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
                                                                model: _user);
                                                      }
                                                    }

                                                    controller
                                                        .setDecrementSelectListProductQDec(
                                                      pId,
                                                      qnt,
                                                    );
                                                  }
                                                },
                                                onTapIncrement: () {
                                                  if (_currentUserId == null) {
                                                    return Get.to(
                                                        SignInScreen());
                                                  } else {
                                                    String pId = widget
                                                        .product.productId;
                                                    int qnt = widget.product
                                                                .productInUserCartQuantity ==
                                                            ''
                                                        ? 1
                                                        : int.parse(
                                                            widget.product
                                                                .productInUserCartQuantity,
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

                                                    _user.userId =
                                                        PreferenceManager
                                                                .getTokenId() ??
                                                            '0';
                                                    _user.productId =
                                                        '${widget.product.productId}';
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
                                                            model: _user);
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
          widget.product.productDiscount.isEmpty ||
                  widget.product.productDiscount == ''
              ? SizedBox()
              : Positioned(
                  left: -Get.width / 30,
                  top: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: Get.height * 0.08,
                    width: Get.height * 0.08,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                      )
                    ], shape: BoxShape.circle, color: ColorPicker.redColorApp),
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.height * 0.024),
                      child: Text(
                        "${widget.product.productDiscount ?? ''}\nOFF",
                        style: TextStyle(
                            fontSize: Get.height * 0.02,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Expanded imageSliderWidget() {
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
      ),
    );
  }
}
