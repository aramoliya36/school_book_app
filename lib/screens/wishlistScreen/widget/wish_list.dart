import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/add_cart_button.dart';
import 'package:skoolmonk/common/textStyle.dart';
import 'package:skoolmonk/common/whish_list_count_methode.dart';
import 'package:skoolmonk/model/responseModel/get_wish_list_response_model.dart';
import 'package:skoolmonk/screens/wishlistScreen/widget/wishlistscreen_button.dart';
import 'package:skoolmonk/viewModel/get_wish_list_view_model.dart';

import '../../../model/reqestModel/post_wishlist_req_model.dart';
import '../../../viewModel/post_wishlist_view_model.dart';

Expanded wishList(GetWishListResponseModel response) {
  PostWishListViewModel _postWishListViewModel = Get.find();
  GetWishListViewModel getWishListViewModel = Get.find();
  log('--------length  ---${response.response.length}');
  return Expanded(
    child: ListView.builder(
        itemCount: response.response.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
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
                            Image.network(
                              response.response[index].productImg.trim(),
                              height: Get.height * 0.12,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                PostWishListReqModel _userWish =
                                    PostWishListReqModel();
                                _userWish.productId =
                                    response.response[0].productId;
                                _userWish.status = response.response[index]
                                            .productInUserWishlist ==
                                        '1'
                                    ? 'REMOVE'
                                    : 'ADD';
                                _postWishListViewModel
                                    .postWishListViewModel(model: _userWish)
                                    .then((value) {
                                  countSetWishCart();
                                  getWishListViewModel.getWishListViewModel();
                                });
                              },
                              child: Text(
                                "Remove",
                                style: CommonTextStyle.redText,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '${response.response[index].productName ?? ''}',
                          style: TextStyle(
                              fontSize: Get.height * 0.021,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹ ${response.response[index].productSalePrice ?? ''}',
                              style: CommonTextStyle.priceTextStyle,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            // Text(
                            //   "You Save ₹16.00",
                            //   style: CommonTextStyle.taxInclude,
                            // ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CartButton(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
            ],
          );
        }),
  );
}

Widget wishButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            wishListButton(title: "Remove All", onPress: () {}),
            wishListButton(title: "Add to Cart", onPress: () {})
          ],
        ),
        SizedBox(
          height: Get.height * 0.04,
        )
      ],
    ),
  );
}
