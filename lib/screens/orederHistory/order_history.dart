import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_delivered_responsemodel.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_responsemodel.dart';
import 'package:skoolmonk/screens/singleProductHistory/single_product_history.dart';
import 'package:skoolmonk/viewModel/purchase_history_by_order_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_delivered_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_viewmodel.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PurchaseHistoryViewModel _purchaseHistoryViewModel = Get.find();
  PurchaseHistoryDeliveredViewModel _purchaseHistoryDeliveredViewModel =
      Get.find();
  PurchaseHistoryByOrderViewModel _purchaseHistoryByOrderViewModel = Get.find();

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        leadingIcon: Icons.arrow_back_outlined,
        appTitle: "Order History",
        onPress: () {
          Get.back();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    _purchaseHistoryViewModel.purchaseHistoryViewModel(orderType: 'C');
    _purchaseHistoryDeliveredViewModel.purchaseHistoryDeliveredViewModel(
        orderType: "P");
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorColor: ColorPicker.navyBlue,
            tabs: [
              Container(
                height: Get.height * 0.05,
                width: Get.width * 0.3,
                child: Center(
                  child: Text(
                    "Active Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: Get.height * 0.05,
                width: Get.width * 0.3,
                child: Center(
                  child: Text(
                    "Delivered",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              // height: Get.height * 0.8,
              width: Get.width,
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  GetBuilder<PurchaseHistoryViewModel>(
                    builder: (controller) {
                      if (controller.apiResponse.status == Status.ERROR) {
                        return Center(child: serverErrorText());
                      }
                      if (controller.apiResponse.status == Status.LOADING) {
                        return circularProgress();
                      }
                      PurchaseHistoryResponse _response =
                          controller.apiResponse.data;
                      return _response.response.isEmpty
                          ? Center(child: Text('Active Order Empty'))
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: Get.height * 0.82,
                                      width: Get.width,
                                      child: ListView.builder(
                                        itemCount: _response.response.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // height: Get.height * 0.24,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: .6,
                                                    color: Colors.grey
                                                        .withOpacity(.5),
                                                  )),
                                              child: Column(
                                                children: [
                                                  ///=======================1st Row=============================///
                                                  SizedBox(
                                                    height: Get.height * 0.018,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text("Order #",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.04,
                                                        ),
                                                        Text(
                                                          _response
                                                                  .response[
                                                                      index]
                                                                  .orderNo ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                        Spacer(),
                                                        TextButton(
                                                            onPressed: () {
                                                              _purchaseHistoryByOrderViewModel
                                                                      .orderNumber
                                                                      .value =
                                                                  _response
                                                                      .response[
                                                                          index]
                                                                      .orderNo;
                                                              Get.to(
                                                                  OrderHistory1());
                                                            },
                                                            child: Text(
                                                              "View Details",
                                                              style: TextStyle(
                                                                  color: ColorPicker
                                                                      .navyBlue),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                    height: 1,
                                                  ),

                                                  ///=========================2nd Row=============================///
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text("Order Date",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.42,
                                                        ),
                                                        Text("Order Total",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          DateFormat()
                                                              .add_yMMMd()
                                                              .format(_response
                                                                      .response[
                                                                          index]
                                                                      .orderDateTime ??
                                                                  ''),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.28,
                                                        ),
                                                        Text(
                                                          _response
                                                              .response[index]
                                                              .orderTotalCost,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Divider(
                                                    color: Colors.grey,
                                                    height: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),

                                                  ///=====================3rd Shoo Image===================///
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: _response
                                                        .response[index]
                                                        .orderData
                                                        .length,
                                                    itemBuilder:
                                                        (context, indexName) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Icon(
                                                                Icons.circle,
                                                                size: 10,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                _response
                                                                        .response[
                                                                            index]
                                                                        .orderData[
                                                                            indexName]
                                                                        .orderDetail[
                                                                            0]
                                                                        .productName ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                  Row(
                                                    children: [
                                                      _response
                                                              .response[index]
                                                              .orderCompleted
                                                              .isEmpty
                                                          ? SizedBox()
                                                          : Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 10),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    _purchaseHistoryByOrderViewModel
                                                                            .orderNumber
                                                                            .value =
                                                                        _response
                                                                            .response[index]
                                                                            .orderNo;
                                                                    Get.to(
                                                                        OrderHistory1());
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 3)),
                                                                    height: Get
                                                                            .height *
                                                                        0.035,
                                                                    width:
                                                                        Get.width *
                                                                            0.25,
                                                                    // color: Colors.red,
                                                                    child: Center(
                                                                        child: Text(
                                                                      _response
                                                                              .response[index]
                                                                              .orderCompleted ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 3)),
                                                            height: Get.height *
                                                                0.035,
                                                            width: Get.width *
                                                                0.25,
                                                            // color: Colors.red,
                                                            child: Center(
                                                                child: Text(
                                                              _response
                                                                      .response[
                                                                          index]
                                                                      .orderStatus ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  _response.response[index]
                                                              .orderMsgShow ==
                                                          '1'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(_response
                                                              .response[index]
                                                              .orderMsg),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                  GetBuilder<PurchaseHistoryDeliveredViewModel>(
                    builder: (controllerDelivered) {
                      if (controllerDelivered.apiResponse.status ==
                          Status.ERROR) {
                        return Center(child: serverErrorText());
                      }
                      if (controllerDelivered.apiResponse.status ==
                          Status.LOADING) {
                        return circularProgress();
                      }
                      PurchaseHistoryDeliveredResponse _responseDelivered =
                          controllerDelivered.apiResponse.data;
                      return _responseDelivered.response.isEmpty
                          ? Center(child: Text('Delivered Order Empty'))
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: Get.height * 0.82,
                                      width: Get.width,
                                      child: ListView.builder(
                                        itemCount:
                                            _responseDelivered.response.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // height: Get.height * 0.24,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: .6,
                                                    color: Colors.grey
                                                        .withOpacity(.5),
                                                  )),
                                              child: Column(
                                                children: [
                                                  ///=======================1st Row=============================///
                                                  SizedBox(
                                                    height: Get.height * 0.018,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text("Order #",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.04,
                                                        ),
                                                        Text(
                                                          _responseDelivered
                                                                  .response[
                                                                      index]
                                                                  .orderNo ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                        Spacer(),
                                                        TextButton(
                                                            onPressed: () {
                                                              _purchaseHistoryByOrderViewModel
                                                                      .orderNumber
                                                                      .value =
                                                                  _responseDelivered
                                                                      .response[
                                                                          index]
                                                                      .orderNo;
                                                              Get.to(
                                                                  OrderHistory1());
                                                            },
                                                            child: Text(
                                                              "View Details",
                                                              style: TextStyle(
                                                                  color: ColorPicker
                                                                      .navyBlue),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                    height: 1,
                                                  ),

                                                  ///=========================2nd Row=============================///
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text("Order Date",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.42,
                                                        ),
                                                        Text("Order Total",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          DateFormat()
                                                              .add_yMMMd()
                                                              .format(_responseDelivered
                                                                      .response[
                                                                          index]
                                                                      .orderDateTime ??
                                                                  ''),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.28,
                                                        ),
                                                        Text(
                                                          _responseDelivered
                                                              .response[index]
                                                              .orderTotalCost,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Divider(
                                                    color: Colors.grey,
                                                    height: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),

                                                  ///=====================3rd Shoo Image===================///
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        _responseDelivered
                                                            .response[index]
                                                            .orderData
                                                            .length,
                                                    itemBuilder:
                                                        (context, indexName) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Icon(
                                                                Icons.circle,
                                                                size: 10,
                                                              ),
                                                            ),
                                                            Text(_responseDelivered
                                                                    .response[
                                                                        index]
                                                                    .orderData[
                                                                        indexName]
                                                                    .orderDetail[
                                                                        0]
                                                                    .productName ??
                                                                ''),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              _purchaseHistoryByOrderViewModel
                                                                      .orderNumber
                                                                      .value =
                                                                  _responseDelivered
                                                                      .response[
                                                                          index]
                                                                      .orderNo;
                                                              Get.to(
                                                                  OrderHistory1());
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          3)),
                                                              height:
                                                                  Get.height *
                                                                      0.035,
                                                              width: Get.width *
                                                                  0.25,
                                                              // color: Colors.red,
                                                              child: Center(
                                                                  child: Text(
                                                                _responseDelivered
                                                                        .response[
                                                                            index]
                                                                        .orderCompleted ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 3)),
                                                            height: Get.height *
                                                                0.035,
                                                            width: Get.width *
                                                                0.25,
                                                            // color: Colors.red,
                                                            child: Center(
                                                                child: Text(
                                                              _responseDelivered
                                                                      .response[
                                                                          index]
                                                                      .orderStatus ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  _responseDelivered
                                                              .response[index]
                                                              .orderMsgShow ==
                                                          '1'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              _responseDelivered
                                                                  .response[
                                                                      index]
                                                                  .orderMsg),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
