import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/school_details_controller.dart';

class bookSetDetailGrid extends StatefulWidget {
  @override
  _bookSetDetailGridState createState() => _bookSetDetailGridState();
}

class _bookSetDetailGridState extends State<bookSetDetailGrid> {
  BottomController homeController = Get.find();
  SchoolDetailController _schoolDetailController = Get.find();
  int _changeIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolDetailController>(
      builder: (controller) {
        return controller.schoolCatProductList.length == 0
            ? Expanded(child: Center(child: Text('Product Not Found')))
            : Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: GridView.builder(
                      itemCount: controller.schoolCatProductList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: 2 / 3,
                          childAspectRatio: 0.80,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Material(
                            child: Ink(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  _schoolDetailController
                                      .setTitleSlugProductDetailsScreen(
                                          titleSlugProductDetails: controller
                                              .schoolCatProductList[index]
                                              .productSlug);
                                  print(
                                      '======bsbsbbsbsbsb========${_schoolDetailController.titleSlugProductDetailsScreen}');

                                  homeController
                                      .selectedScreen('ProductDetailScreen');
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CarouselSlider(
                                                    options: CarouselOptions(
                                                      height: Get.height * 0.17,
                                                      onPageChanged:
                                                          (val, reason) {
                                                        setState(() {
                                                          _changeIndex = val;
                                                        });
                                                      },
                                                      viewportFraction: 1.0,

                                                      enlargeCenterPage: false,
                                                      // autoPlay: false,
                                                    ),
                                                    items: controller
                                                                .schoolCatProductList[
                                                                    index]
                                                                .productImg
                                                                .isEmpty ||
                                                            controller
                                                                    .schoolCatProductList[
                                                                        index]
                                                                    .productImg ==
                                                                null
                                                        ? commonImage(
                                                            widthImage:
                                                                Get.width * 0.3,
                                                          )
                                                        : (controller
                                                                .schoolCatProductList[
                                                                    index]
                                                                .productImgs)
                                                            .map(
                                                                (item) =>
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Center(
                                                                          child: Image.network(
                                                                        item.productImg
                                                                            .trim(),
                                                                        width: Get.width *
                                                                            0.3,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )),
                                                                    ))
                                                            .toList(),
                                                  ),
                                                ),
                                                controller
                                                            .schoolCatProductList[
                                                                index]
                                                            .productImgs
                                                            .length ==
                                                        1
                                                    ? SizedBox()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: List.generate(
                                                            controller
                                                                .schoolCatProductList[
                                                                    index]
                                                                .productImgs
                                                                .length,
                                                            (subindex) =>
                                                                Padding(
                                                                  padding: EdgeInsets.all(
                                                                      Get.height *
                                                                          0.002),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: Get
                                                                            .height *
                                                                        0.004,
                                                                    backgroundColor: _changeIndex ==
                                                                            subindex
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                )),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.height * 0.006),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: Get.width,
                                                      height: Get.height / 19,
                                                      // color: Colors.deepOrange,
                                                      child: Text(
                                                        controller
                                                                .schoolCatProductList[
                                                                    index]
                                                                .productName ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: CommonTextStyle
                                                            .productTitle,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.height * 0.006,
                                                    right: Get.height * 0.006),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "₹ ${controller.schoolCatProductList[index].productPrice ?? ""}",
                                                        style: CommonTextStyle
                                                            .priceTextStyle),
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
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'MRP',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Helvetica Neue',
                                                                    fontSize:
                                                                        Get.height *
                                                                            0.015,
                                                                    color: const Color(
                                                                        0xff8e8e8e),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  ' ₹ ${controller.schoolCatProductList[index].productSalePrice}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Helvetica Neue',
                                                                    fontSize:
                                                                        Get.height *
                                                                            0.013,
                                                                    color: const Color(
                                                                        0xff8e8e8e),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
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
                                                        controller
                                                                    .schoolCatProductList[
                                                                        index]
                                                                    .productType ==
                                                                'Single'
                                                            ? AddCartButton()
                                                            : SizedBox(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    controller.schoolCatProductList[index]
                                                .productDiscount.isEmpty ||
                                            controller
                                                    .schoolCatProductList[index]
                                                    .productDiscount ==
                                                ''
                                        ? SizedBox()
                                        : Positioned(
                                            left: -Get.height * 0.02,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: Get.height * 0.08,
                                              width: Get.height * 0.08,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 5,
                                                    )
                                                  ],
                                                  shape: BoxShape.circle,
                                                  color: ColorPicker.navyBlue),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.height * 0.02),
                                                child: Text(
                                                  "${controller.schoolCatProductList[index].productDiscount ?? ''} \nOFF",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                      }),
                ),
              );
      },
    );
  }
}

// BookSetCard(
//
// onPress: () {
// homeController.selectedScreen('ProductDetailScreen');
// },
// index: index,
// );
