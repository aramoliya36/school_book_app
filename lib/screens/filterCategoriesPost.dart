import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/model/responseModel/filter_categories_product_post_response_model.dart';
import 'package:skoolmonk/viewModel/FilterCategoriesProductPost_viewmodel.dart';

class HomeRouteProduct extends StatefulWidget {
  const HomeRouteProduct({Key key}) : super(key: key);

  @override
  _HomeRouteProductState createState() => _HomeRouteProductState();
}

class _HomeRouteProductState extends State<HomeRouteProduct> {
  int _changeIndex = 0;

  FilterCategoriesProductPostViewModel _filterCategoriesProductPostViewModel =
      Get.find();
  @override
  void initState() {
    // TODO: implement initState
    _filterCategoriesProductPostViewModel
        .filterCategoriesProductPostViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GetBuilder<FilterCategoriesProductPostViewModel>(
        builder: (controller) {
          FilterCategoriesProductPostResponse response =
              controller.apiResponse.data;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.height * 0.014,
                    vertical: Get.height * 0.02),
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
                        onTap: () {},
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        response
                                                                .response[index]
                                                                .product[0]
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
                                                      height:
                                                          Get.height * 0.005,
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "₹ ${response.response[index].product[0].productSalePrice ?? ''}",
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
                                                                ' ₹ ${response.response[index].product[0].productPrice ?? ''}',
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
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    response.response[index].product[0]
                                                .productDiscount.isEmpty ||
                                            response.response[index].product[0]
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
                                                  color:
                                                      ColorPicker.redColorApp),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.height * 0.012),
                                                child: Text(
                                                  "${response.response[index].product[0].productDiscount ?? ''}\nOFF",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.0183,
                                                      fontWeight:
                                                          FontWeight.w500,
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
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {},
        appTitle: 'milan',
        leadingIcon: Icons.arrow_back_rounded);
  }

  Expanded imageSliderWishWidget(
      int index, FilterCategoriesProductPostResponse response) {
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
                        _filterCategoriesProductPostViewModel.setProductUniqId(
                            value:
                                response.response[index].product[0].productId);
                      });
                    },
                    viewportFraction: 1.0,

                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: response.response[index].product[0].productImgs.isEmpty
                      ? commonImage(
                          widthImage: Get.width * 0.3,
                        )
                      : (response.response[index].product[0].productImgs)
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
          response.response[index].product[0].productImgs.length == 1
              ? SizedBox()
              : GetBuilder<FilterCategoriesProductPostViewModel>(
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        response.response[index].product[0].productImgs.length,
                        (subindex) => Padding(
                            padding: EdgeInsets.all(Get.height * 0.002),
                            child: CircleAvatar(
                              radius: Get.height * 0.004,
                              backgroundColor: (_changeIndex == subindex &&
                                      controller.productUniqId ==
                                          response.response[index].product[0]
                                              .productId)
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
