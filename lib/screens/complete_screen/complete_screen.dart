import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skoolmonk/common/common_image.dart';
import 'package:skoolmonk/model/responseModel/purchase_history_by_order_responsemodel.dart';
import 'package:skoolmonk/viewModel/get_order_return_option_viewmodel.dart';
import 'package:skoolmonk/viewModel/purchase_history_by_order_viewmodel.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({this.orderId, this.name});
  final String orderId;
  final String name;

  @override
  _CompleteScreenState createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  PurchaseHistoryByOrderViewModel _purchaseHistoryByOrderViewModel = Get.find();
  GetOrderReturnOptionViewModel _getOrderReturnOptionViewModel = Get.find();
  List<ProductRe> res;

  @override
  Widget build(BuildContext context) {
    List<ProductRe> res =
        _getOrderReturnOptionViewModel.returnReplaceListOfComplete;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Order Status",
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //  height: Get.height * 0.5,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            //height: Get.height * 0.08,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Order       #",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      widget.orderId ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Name       :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      widget.name ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Qty            :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      res[0].qty ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Reason    :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      res[0].reason ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Status      :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      res[0].requestStatus ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Date          :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      DateFormat()
                                              .add_yMMMd()
                                              .format(res[0].userReqDate) ??
                                          '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text("Comment :",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Text(
                                      res[0].comment ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: List.generate(res[0].files.length, (index) {
                            return Image.network(res[0].files[index].img.trim(),
                                errorBuilder: (context, error, stackTrace) {
                              return commonImage();
                            });
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
