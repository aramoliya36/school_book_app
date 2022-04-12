import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/order_cancel_user_req.dart';
import 'package:skoolmonk/model/reqestModel/order_req_cancel_user_req.dart';
import 'package:skoolmonk/model/responseModel/order_cancel_user_response_model.dart';
import 'package:skoolmonk/model/responseModel/order_req_cancel_user_response_model.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_by_order_responsemodel.dart';
import 'package:skoolmonk/screens/complete_screen/complete_screen.dart';
import 'package:skoolmonk/screens/returnOrder/return_order_screen.dart';
import 'package:skoolmonk/viewModel/get_order_return_option_viewmodel.dart';
import 'package:skoolmonk/viewModel/order_cancel_user_viewmodel.dart';
import 'package:skoolmonk/viewModel/order_req_cancel_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_by_order_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderHistory1 extends StatefulWidget {
  const OrderHistory1({Key key}) : super(key: key);

  @override
  _OrderHistory1State createState() => _OrderHistory1State();
}

class _OrderHistory1State extends State<OrderHistory1> {
  PurchaseHistoryByOrderViewModel _purchaseHistoryByOrderViewModel = Get.find();
  GetOrderReturnOptionViewModel _getOrderReturnOptionViewModel = Get.find();
  OrderCancelUserViewModel _orderCancelUserViewModel = Get.find();
  OrderCancelUserReqModel _orderCancelUserReqModel = OrderCancelUserReqModel();
  OrderReqCancelUserReqModel _orderReqCancelUserReqModel =
      OrderReqCancelUserReqModel();
  OrderReqCancelUserViewModel _orderReqCancelUserViewModel = Get.find();
  @override
  void initState() {
    _purchaseHistoryByOrderViewModel.purchaseHistoryByOrderViewModel(
        orderNumber: _purchaseHistoryByOrderViewModel.orderNumber.value);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _purchaseHistoryByOrderViewModel.filterMapList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(0.01),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Order History",
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<PurchaseHistoryByOrderViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.ERROR) {
            return Center(child: serverErrorText());
          }
          if (controller.apiResponse.status == Status.LOADING) {
            return circularProgress();
          }
          PurchaseHistoryByOrderResponse response =
              _purchaseHistoryByOrderViewModel.apiResponse.data;
          var _res = response.response[0];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.018,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Order #", style: TextStyle(fontSize: 12)),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              Text(
                                response.response[0].order[0].orderNo ?? '',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 2,
                        ),

                        ///=========================2nd Row=============================///
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Order Date",
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(
                                width: Get.width * 0.42,
                              ),
                              Text("Order Total",
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              ///date
                              Text(
                                '${DateFormat().add_yMMMd().format(response.response[0].order[0].orderDateTime) ?? ''}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(
                                width: Get.width * 0.28,
                              ),
                              Text(
                                response.response[0].order[0].orderTotalCost ??
                                    '',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        SizedBox(
                          height: Get.height * 0.001,
                        ),

                        ///=====================3rd Shoo Image===================///

                        Divider(
                          color: Colors.grey.shade300,
                          height: 3,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ListView.builder(
                          itemCount: _res.orderData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, indexOrderData) {
                            if (controller.filterMapList.containsKey(
                                _res.orderData[indexOrderData].subOrderNo)) {
                            } else {
                              controller.filterMapList.addAll({
                                _res.orderData[indexOrderData].subOrderNo: true
                              });
                            }

                            if (controller.subOrderDrop.containsKey(
                                _res.orderData[indexOrderData].subOrderNo)) {
                            } else {
                              controller.subOrderDrop.addAll({
                                _res.orderData[indexOrderData].subOrderNo: true
                              });
                            }
                            print(
                                '----------add----filter---${controller.filterMapList}');
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                children: [
                                  Material(
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text("sub Order #",
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(
                                              width: Get.width * 0.04,
                                            ),
                                            Text(
                                              _res.orderData[indexOrderData]
                                                      .subOrderNo ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        controller.addSubOrderDrop(
                                            key: _res.orderData[indexOrderData]
                                                .subOrderNo,
                                            value: true);
                                      },
                                    ),
                                    elevation: 3,
                                  ),
                                  (controller.subOrderDrop[_res
                                              .orderData[indexOrderData]
                                              .subOrderNo] ==
                                          true)
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 3)),
                                                      height:
                                                          Get.height * 0.035,
                                                      width: Get.width * 0.22,
                                                      // color: Colors.red,
                                                      child: Center(
                                                          child: Text(
                                                        _res.order[0]
                                                                .orderCompleted ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: _res
                                                                .orderData[
                                                                    indexOrderData]
                                                                .orderCancelBtn ==
                                                            '1'
                                                        ? InkWell(
                                                            onTap: () async {
                                                              _orderCancelUserReqModel
                                                                      .orderNo =
                                                                  _res
                                                                      .orderData[
                                                                          indexOrderData]
                                                                      .orderNo;
                                                              _orderCancelUserReqModel
                                                                      .subOrderNo =
                                                                  _res
                                                                      .orderData[
                                                                          indexOrderData]
                                                                      .subOrderNo;
                                                              await _orderCancelUserViewModel
                                                                  .orderCancelUserViewModel(
                                                                      _orderCancelUserReqModel);
                                                              OrderCancelByResponse
                                                                  _resOrderCancel =
                                                                  _orderCancelUserViewModel
                                                                      .apiResponse
                                                                      .data;
                                                              if (_resOrderCancel
                                                                      .status ==
                                                                  200) {
                                                                _purchaseHistoryByOrderViewModel.purchaseHistoryByOrderViewModel(
                                                                    orderNumber:
                                                                        _purchaseHistoryByOrderViewModel
                                                                            .orderNumber
                                                                            .value);
                                                              }
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
                                                                  0.22,
                                                              // color: Colors.red,
                                                              child: Center(
                                                                  child: Text(
                                                                "Order Cancel",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                            ),
                                                          )
                                                        : InkWell(
                                                            onTap: () async {
                                                              _orderReqCancelUserReqModel
                                                                      .orderNo =
                                                                  _res
                                                                      .orderData[
                                                                          indexOrderData]
                                                                      .orderNo;
                                                              _orderReqCancelUserReqModel
                                                                      .subOrderNo =
                                                                  _res
                                                                      .orderData[
                                                                          indexOrderData]
                                                                      .subOrderNo;
                                                              await _orderReqCancelUserViewModel
                                                                  .orderReqCancelUserViewModel(
                                                                      _orderReqCancelUserReqModel);
                                                              OrderReqCancelByResponse
                                                                  _resReqOrderCancel =
                                                                  _orderReqCancelUserViewModel
                                                                      .apiResponse
                                                                      .data;
                                                              if (_resReqOrderCancel
                                                                      .status ==
                                                                  200) {
                                                                _purchaseHistoryByOrderViewModel.purchaseHistoryByOrderViewModel(
                                                                    orderNumber:
                                                                        _purchaseHistoryByOrderViewModel
                                                                            .orderNumber
                                                                            .value);
                                                              }
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
                                                              width: 200,
                                                              // color: Colors.red,
                                                              child: Center(
                                                                  child: Text(
                                                                "User Requested Order Cancel",
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
                                              ],
                                            ),
                                            _res.orderData[indexOrderData]
                                                        .isInvoiceMade ==
                                                    '1'
                                                ? Align(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          // if (await canLaunch(_res
                                                          //     .orderData[indexOrderData]
                                                          //     .isInvoiceMade)) {
                                                          print(
                                                              '------isIn----${_res.orderData[indexOrderData].invoiceLink.trim()}');
                                                          await launch(_res
                                                              .orderData[
                                                                  indexOrderData]
                                                              .invoiceLink
                                                              .trim());
                                                          // } else {
                                                          //   throw 'Could not launch ${_res.orderData[indexOrderData].isInvoiceMade}';
                                                          // }
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
                                                                  width: 3)),
                                                          height: Get.height *
                                                              0.035,
                                                          width: 120,
                                                          // color: Colors.red,
                                                          child: Center(
                                                              child: Text(
                                                            "Download invoice",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  )
                                                : SizedBox(),
                                            _res.orderData[indexOrderData]
                                                        .showTrackDataShow ==
                                                    '1'
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                controller.addFilterMap(
                                                                    key: _res
                                                                        .orderData[
                                                                            indexOrderData]
                                                                        .subOrderNo,
                                                                    value:
                                                                        true);
                                                                print(
                                                                    '------controller.filterMapList----------${controller.filterMapList}');
                                                              },
                                                              child: Text(
                                                                'Current Order Track',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(Icons
                                                              .arrow_drop_down)
                                                        ],
                                                      ),
                                                      Text(_res
                                                              .orderData[
                                                                  indexOrderData]
                                                              .showTrackDataTitle ??
                                                          ''),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            (_res.orderData[indexOrderData]
                                                            .showTrackDataShow ==
                                                        '1' &&
                                                    _res
                                                        .orderData[
                                                            indexOrderData]
                                                        .showTrackData
                                                        .isNotEmpty &&
                                                    controller.filterMapList[_res
                                                            .orderData[
                                                                indexOrderData]
                                                            .subOrderNo] ==
                                                        true)
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        ListView.builder(
                                                          itemCount: _res
                                                              .orderData[
                                                                  indexOrderData]
                                                              .showTrackData
                                                              .length,
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context,
                                                              indexShowTrack) {
                                                            int lastIndex = _res
                                                                    .orderData[
                                                                        indexOrderData]
                                                                    .showTrackData
                                                                    .length -
                                                                1;

                                                            return Container(
                                                              height:
                                                                  Get.height /
                                                                      8,
                                                              width: Get.width,
                                                              //color: Colors.deepOrange,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      // Container(
                                                                      //   height: Get.height / 8,
                                                                      //   width: Get.width / 8,
                                                                      //   decoration: BoxDecoration(
                                                                      //       color: Colors.blue, shape: BoxShape.circle),
                                                                      // ),
                                                                      CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                        radius:
                                                                            Get.height /
                                                                                35,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              Get.height / 36,
                                                                          backgroundColor: _res.orderData[indexOrderData].showTrackData[indexShowTrack].isActive == '0'
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          child:
                                                                              Icon(
                                                                            Icons.check,
                                                                            color: _res.orderData[indexOrderData].showTrackData[indexShowTrack].isActive == '0'
                                                                                ? Colors.white
                                                                                : Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      lastIndex ==
                                                                              indexShowTrack
                                                                          ? SizedBox()
                                                                          : Expanded(
                                                                              child: Container(
                                                                                child: VerticalDivider(
                                                                                  color: Colors.black,
                                                                                  thickness: 1,
                                                                                ),
                                                                              ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        _res.orderData[indexOrderData].showTrackData[indexShowTrack].title.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[indexOrderData].showTrackData[indexShowTrack].title ??
                                                                                ''),
                                                                        _res.orderData[indexOrderData].showTrackData[indexShowTrack].body.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[indexOrderData].showTrackData[indexShowTrack].body ??
                                                                                ''),
                                                                        _res.orderData[indexOrderData].showTrackData[indexShowTrack].dateTime.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[indexOrderData].showTrackData[indexShowTrack].dateTime ??
                                                                                ''),
                                                                        // Text(_res
                                                                        //         .orderData[indexOrderData]
                                                                        //         .orderCancelData[index]
                                                                        //         .dateTime ??
                                                                        //     ''),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height / 20,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        Html(
                                                          data:
                                                              """${_res.orderData[indexOrderData].showTrackDataHtml}""",
                                                          defaultTextStyle:
                                                              TextStyle(
                                                            fontFamily:
                                                                'Helvetica Neue',
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            (_res.orderData[indexOrderData]
                                                        .showTrackDataShow ==
                                                    '1')
                                                ? Container(
                                                    width: Get.width,
                                                    height: 2,
                                                    child: Divider(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            _res.orderData[indexOrderData]
                                                        .orderCancelDataShow ==
                                                    '1'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                controller.addFilterMap(
                                                                    key: _res
                                                                        .orderData[
                                                                            indexOrderData]
                                                                        .subOrderNo,
                                                                    value:
                                                                        true);
                                                                // controller
                                                                //     .setCancelTrack();
                                                              },
                                                              child: Text(
                                                                'Cancel Order Track',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Icon(Icons
                                                                .arrow_drop_down)
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(_res
                                                                  .orderData[
                                                                      indexOrderData]
                                                                  .orderCancelDataTitle ??
                                                              ''),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            (_res.orderData[indexOrderData]
                                                            .orderCancelDataShow ==
                                                        '1' &&
                                                    controller.filterMapList[_res
                                                            .orderData[
                                                                indexOrderData]
                                                            .subOrderNo] ==
                                                        true)
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        ListView.builder(
                                                          itemCount: _res
                                                              .orderData[
                                                                  indexOrderData]
                                                              .orderCancelData
                                                              .length,
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            int lastIndex = response
                                                                    .response[0]
                                                                    .orderData[
                                                                        indexOrderData]
                                                                    .orderCancelData
                                                                    .length -
                                                                1;

                                                            return Container(
                                                              height:
                                                                  Get.height /
                                                                      8,
                                                              width: Get.width,
                                                              //color: Colors.deepOrange,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      // Container(
                                                                      //   height: Get.height / 8,
                                                                      //   width: Get.width / 8,
                                                                      //   decoration: BoxDecoration(
                                                                      //       color: Colors.blue, shape: BoxShape.circle),
                                                                      // ),
                                                                      CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                        radius:
                                                                            Get.height /
                                                                                35,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              Get.height / 36,
                                                                          backgroundColor: _res.orderData[0].orderCancelData[index].isActive == '0'
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          child:
                                                                              Icon(
                                                                            Icons.check,
                                                                            color: _res.orderData[0].orderCancelData[index].isActive == '0'
                                                                                ? Colors.white
                                                                                : Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      lastIndex ==
                                                                              index
                                                                          ? SizedBox()
                                                                          : Expanded(
                                                                              child: Container(
                                                                                child: VerticalDivider(
                                                                                  color: Colors.black,
                                                                                  thickness: 1,
                                                                                ),
                                                                              ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        _res.orderData[0].orderCancelData[index].title.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[0].orderCancelData[index].title ??
                                                                                ''),
                                                                        _res.orderData[0].orderCancelData[index].body.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[0].orderCancelData[index].body ??
                                                                                ''),
                                                                        _res.orderData[0].orderCancelData[index].dateTime.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(_res.orderData[0].orderCancelData[index].dateTime ??
                                                                                ''),
                                                                        // Text(_res
                                                                        //         .orderData[indexOrderData]
                                                                        //         .orderCancelData[index]
                                                                        //         .dateTime ??
                                                                        //     ''),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height / 15.5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        Html(
                                                          data:
                                                              """${_res.orderData[indexOrderData].orderCancelDataHtml}""",
                                                          defaultTextStyle:
                                                              TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: response
                                                  .response[0]
                                                  .orderData[indexOrderData]
                                                  .orderDetail
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (context, indexSubPro) {
                                                var subPro = response
                                                    .response[0]
                                                    .orderData[indexOrderData]
                                                    .orderDetail[indexSubPro];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height:
                                                            Get.height * 0.16,
                                                        width: Get.width * 0.28,
                                                        child: subPro.productImg
                                                                .isEmpty
                                                            ? commonImage()
                                                            : Image.network(
                                                                subPro
                                                                    .productImg
                                                                    .trim(),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              subPro.productName ??
                                                                  '',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                            //height: 50,
                                                            width:
                                                                Get.width / 1.6,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            'Rs ${subPro.productSalePrice ?? ""}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.005,
                                                          ),
                                                          Text(
                                                            "Quantity : ${subPro.productQty ?? ''}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.025,
                                                          ),
                                                          (subPro.productReturn
                                                                      .isNotEmpty ||
                                                                  subPro
                                                                      .productReplace
                                                                      .isNotEmpty)
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    _getOrderReturnOptionViewModel.setReturnReplaceListOfComplete(
                                                                        value: subPro.productReturn.isNotEmpty
                                                                            ? subPro.productReturn
                                                                            : subPro.productReplace);

                                                                    Get.to(CompleteScreen(
                                                                        orderId: response
                                                                            .response[
                                                                                0]
                                                                            .order[
                                                                                0]
                                                                            .orderNo,
                                                                        name: subPro
                                                                            .productName));
                                                                  },
                                                                  child: Text(
                                                                    "View",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                          (subPro.orderReturnBtn ==
                                                                      '1' &&
                                                                  subPro
                                                                      .productReturn
                                                                      .isEmpty)
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    _getOrderReturnOptionViewModel
                                                                        .setReturnReplaceSin(
                                                                            value:
                                                                                subPro);

                                                                    Get.to(
                                                                        ProductReturnScreen(
                                                                      qty: subPro
                                                                          .productQty,
                                                                      productId:
                                                                          subPro
                                                                              .productId,
                                                                      title:
                                                                          'Return',
                                                                      returnType:
                                                                          '1',
                                                                      orderId: response
                                                                          .response[
                                                                              0]
                                                                          .order[
                                                                              0]
                                                                          .orderNo,
                                                                      subOrderId: response
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              indexOrderData]
                                                                          .subOrderNo,
                                                                    ));
                                                                  },
                                                                  child: Text(
                                                                    "Return this item",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                          (subPro.orderReplaceBtn ==
                                                                      '1' &&
                                                                  subPro
                                                                      .productReplace
                                                                      .isEmpty)
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _getOrderReturnOptionViewModel.setReturnReplaceSin(
                                                                          value:
                                                                              subPro);
                                                                      Get.to(
                                                                          ProductReturnScreen(
                                                                        qty: subPro
                                                                            .productQty,
                                                                        productId:
                                                                            subPro.productId,
                                                                        title:
                                                                            'Replace',
                                                                        returnType:
                                                                            '2',
                                                                        orderId: response
                                                                            .response[0]
                                                                            .order[0]
                                                                            .orderNo,
                                                                        subOrderId: response
                                                                            .response[0]
                                                                            .orderData[indexOrderData]
                                                                            .subOrderNo,
                                                                      ));
                                                                    },
                                                                    child: Text(
                                                                      "Replace this item",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : SizedBox()
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Order History",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _res.userDeliveryAddress[0].email ?? "",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text(
                            _res.userDeliveryAddress[0].mobile ?? "",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "${_res.userDeliveryAddress[0].address1},${_res.userDeliveryAddress[0].city},${_res.userDeliveryAddress[0].countries}",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.04,
                          // ),
                          // Text(
                          //   "2 items in your order",
                          //   style: TextStyle(color: Colors.black, fontSize: 18),
                          // ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DottedBorder(
                    color: Colors.black,
                    strokeWidth: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Container(
                        height: 170,
                        width: Get.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pricing Summary",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                                Text(
                                  _res.orderSummary[0].finalPrice ?? "",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax price",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                                Text(
                                  _res.orderSummary[0].finalTaxPrice ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total saving",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                                Text(
                                  _res.orderSummary[0].finalTotalSaving ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "shipping",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                                Text(
                                  _res.orderSummary[0].finalDeliveryPrice ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  _res.orderSummary[0].finalTotalPrice ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
