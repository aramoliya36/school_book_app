import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/controller/product_detail__screen_controller.dart';

import 'color_picker.dart';

class AddTo extends GetxController {
  bool isSelect = false;
  String curruntId;
  setCurruntId({String id}) {
    curruntId = id;
    update();
  }

  setBoolValue() {
    isSelect = !isSelect;
    print('--------------------------isdslelect-------$isSelect');
    update();
  }
}

class AddToCartButtonWidget extends StatefulWidget {
  final Function onTapIncrement;
  final Function onTapDecrement;
  final String curentId;
  final String responsId;
  const AddToCartButtonWidget(
      {this.onTapIncrement,
      this.onTapDecrement,
      this.curentId,
      this.responsId});
  @override
  _AddToCartButtonWidgetState createState() => _AddToCartButtonWidgetState();
}

class _AddToCartButtonWidgetState extends State<AddToCartButtonWidget> {
  ProductDetailScreenController _productDetailScreenController = Get.find();
  AddTo _addTo = Get.put(AddTo());
  // bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTo>(
      builder: (controller) {
        return Material(
            child: (controller.curruntId == widget.curentId)
                ? Container(
                    height: Get.height * 0.03,
                    width: Get.width * 0.18,
                    decoration: BoxDecoration(
                        color: ColorPicker.navyBlue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: widget.onTapDecrement,
                          child: Icon(
                            Icons.delete,
                            size: Get.height * 0.02,
                          ),
                        ),
                        GetBuilder<ProductDetailScreenController>(
                          builder: (controller) {
                            return Container(
                              height: Get.height * 0.028,
                              width: Get.width * 0.06,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                "${controller.isOrderCountRelated}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: widget.onTapIncrement,
                          child: Icon(
                            Icons.add,
                            size: Get.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  )
                : Material(
                    borderRadius: BorderRadius.circular(5),
                    child: Ink(
                      height: Get.height * 0.03,
                      width: Get.width * 0.17,
                      decoration: BoxDecoration(
                          color: ColorPicker.navyBlue,
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          _addTo.setCurruntId(id: widget.responsId);
                          _productDetailScreenController.setCurrentId(
                              curentValueId: widget.responsId);
                          _productDetailScreenController
                              .resetOrderCountRelated();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: Get.height * 0.02,
                            ),
                            Text(
                              "ADD",
                              style: TextStyle(fontSize: Get.height * 0.02),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
      },
    );
  }
}
