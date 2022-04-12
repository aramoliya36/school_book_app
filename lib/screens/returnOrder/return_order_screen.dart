import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/image_upload_request_model.dart';
import 'package:skoolmonk/model/reqestModel/return_order_req_model.dart';
import 'package:skoolmonk/model/responseModel/get_oredrr_return_option_responsemodel.dart';
import 'package:skoolmonk/model/responseModel/image_upload_response_model.dart';
import 'package:skoolmonk/model/responseModel/order_return_req_responsemodel.dart';
import 'package:skoolmonk/viewModel/get_order_return_option_viewmodel.dart';
import 'package:skoolmonk/viewModel/return_order_req_viewmodel.dart';
import 'package:skoolmonk/viewModel/update_profile_view_model.dart';

class ProductReturnScreen extends StatefulWidget {
  const ProductReturnScreen(
      {this.title,
      this.returnType,
      this.orderId,
      this.subOrderId,
      this.productId,
      this.qty});
  final String title;
  final String returnType;
  final String orderId;
  final String subOrderId;
  final String productId;
  final String qty;

  @override
  _ProductReturnScreenState createState() => _ProductReturnScreenState();
}

class _ProductReturnScreenState extends State<ProductReturnScreen> {
  GetOrderReturnOptionViewModel _getOrderReturnOptionViewModel = Get.find();
  ReturnOrderReqViewModel _returnOrderReqViewModel = Get.find();
  UpdateProfileViewModel _updateProfileViewModel = Get.find();
  ReturnOrderReqModel _returnOrderReqModel = ReturnOrderReqModel();
  ImageUploadReq _imageUploadReq = ImageUploadReq();
  TextEditingController commentController = TextEditingController();
  String dropdownValue;
  int qtyProduct = 0;
  List filePath1 = [];
  List apiUrlPath = [];
  // List<Asset> images = List<Asset>();
  // String _error = 'No Error Dectected';
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children:
          List.generate(_getOrderReturnOptionViewModel.images.length, (index) {
        Asset asset = _getOrderReturnOptionViewModel.images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");

    filePath1.add(tempFile.path);

    print('----filePath11-----$filePath1');
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: _getOrderReturnOptionViewModel.images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SchoolMonk",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    resultList.forEach((element) {
      getImageFileFromAssets(element);
    });
    _getOrderReturnOptionViewModel.setImagePi(value: resultList);
  }

  @override
  void initState() {
    qtyProduct = int.parse(widget.qty);

    _getOrderReturnOptionViewModel.getOrderReturnOptionViewModel(
        returnReplaceType: widget.returnType);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _getOrderReturnOptionViewModel.images.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Product ${widget.title ?? ''}",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
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
        child: GetBuilder<GetOrderReturnOptionViewModel>(
          builder: (controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.modelProgress,
              progressIndicator: circularProgress(),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: Get.height * 0.08,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Order #",
                                              style: TextStyle(fontSize: 12)),
                                          SizedBox(
                                            width: Get.width * 0.04,
                                          ),
                                          Text(
                                            widget.subOrderId ?? '',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Text("Name :",
                                              style: TextStyle(fontSize: 12)),
                                          SizedBox(
                                            width: Get.width * 0.04,
                                          ),
                                          Text(
                                            _getOrderReturnOptionViewModel
                                                    .returnReplaceSinglePro
                                                    .productName ??
                                                '',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.1,
                                ),
                                Container(
                                  height: Get.height * 0.08,
                                  width: Get.width * 0.13,
                                  color: Colors.transparent,
                                  child: Image.network(
                                    _getOrderReturnOptionViewModel
                                        .returnReplaceSinglePro.productImg
                                        .trim(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Container(
                              height: Get.height * 0.03,
                              width: Get.width * 0.18,
                              decoration: BoxDecoration(
                                  color: ColorPicker.navyBlue,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (qtyProduct > 1) {
                                        qtyProduct--;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: Get.height * 0.02,
                                    ),
                                  ),
                                  Container(
                                    height: Get.height * 0.028,
                                    width: Get.width * 0.06,
                                    color: Colors.white,
                                    child: Center(
                                        child: Text(
                                      qtyProduct.toString() ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print(
                                          '---widget.qty---${int.parse(widget.qty)}');
                                      print('---qtyProduct---$qtyProduct');
                                      print(
                                          '-------aty---${int.parse(widget.qty) > qtyProduct}');
                                      if (int.parse(widget.qty) > qtyProduct) {
                                        qtyProduct++;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: Get.height * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Select from below reason",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                            ),
                            GetBuilder<GetOrderReturnOptionViewModel>(
                              builder: (controller) {
                                if (controller.apiResponse.status ==
                                    Status.COMPLETE) {
                                  GetOrderReturnReplaceResponse resOption =
                                      _getOrderReturnOptionViewModel
                                          .apiResponse.data;
                                  return Container(
                                    height: Get.height * 0.05,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 5)
                                        ]),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      // value: dropdownValue,
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          '${dropdownValue != null ? dropdownValue : 'Select'}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.expand_more,
                                        color: ColorPicker.navyBlue,
                                      ),
                                      iconSize: Get.height * 0.03,
                                      elevation: 16,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.transparent,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // dropdownValue = newValue;
                                          // selectedValueIndex = newValue;
                                        });
                                      },
                                      items: resOption.response
                                          .map((var companiesData) {
                                        return new DropdownMenuItem<String>(
                                          value: "$companiesData",
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.height * 0.006),
                                            child: new Text(
                                              companiesData.optionName,
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.017),
                                            ),
                                          ),
                                          onTap: () {
                                            print(
                                                'drop value${companiesData.optionName}');
                                            dropdownValue =
                                                companiesData.optionName;

                                            setState(() {});
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              "or Enter Reason for Return",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: Get.height * 0.015,
                            ),
                            Container(
                              height: Get.height * 0.06,
                              width: Get.width,
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 100,
                                color: ColorPicker.navyBlue,
                                child: InkWell(
                                  child: Center(child: Text("Pick images")),
                                  onTap: loadAssets,
                                ),
                              ),
                            ),
                            GetBuilder<GetOrderReturnOptionViewModel>(
                              builder: (controller1) {
                                return controller1.images.isEmpty
                                    ? SizedBox()
                                    : GridView.count(
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        children: List.generate(
                                            controller1.images.length, (index) {
                                          Asset asset =
                                              _getOrderReturnOptionViewModel
                                                  .images[index];
                                          return AssetThumb(
                                            asset: asset,
                                            width: 300,
                                            height: 300,
                                          );
                                        }),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                    InkWell(
                      onTap: () {
                        imageUp(controller: controller);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                            color: ColorPicker.navyBlue,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          "REQUEST FOR RETURN",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  imageUp({GetOrderReturnOptionViewModel controller}) async {
    apiUrlPath.clear();
    print('-------dropdownValue-------------$dropdownValue');
    if (dropdownValue != null) {
      if (commentController.text.isNotEmpty) {
        if (filePath1.isNotEmpty) {
          controller.modelProgress = true;

          filePath1.forEach((element) async {
            _imageUploadReq.img = element;
            print('-------------------pi--');
            await _updateProfileViewModel.imageUpload(model: _imageUploadReq);

            ImageUploadResponse resUrlApi =
                _updateProfileViewModel.imageUploadApiResponse.data;
            apiUrlPath.add(resUrlApi.response[0].path);
            if (filePath1.length == apiUrlPath.length) {
              _returnOrderReqModel.userId = PreferenceManager.getTokenId();
              _returnOrderReqModel.orderNo = widget.orderId;
              _returnOrderReqModel.subOrderNo = widget.subOrderId;
              _returnOrderReqModel.productId = widget.productId;
              _returnOrderReqModel.qty = qtyProduct.toString();
              _returnOrderReqModel.requestStatus = 'pending';
              _returnOrderReqModel.reason = dropdownValue;
              _returnOrderReqModel.comment = commentController.text;

              _returnOrderReqModel.files =
                  '${apiUrlPath.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
              print('-------widget.returnType----------${widget.returnType}');
              await _returnOrderReqViewModel
                  .returnOrderReqViewModel(
                      model: _returnOrderReqModel,
                      typeReturnReplace: widget.returnType)
                  .then((value) {
                controller.modelProgress = false;

                OrderReturnReqResponse _res =
                    _returnOrderReqViewModel.apiResponse.data;
                if (_res.status == 200) {
                  CommonSnackBar.showSnackBar(
                      successStatus: false, msg: _res.message);
                  Future.delayed(Duration(seconds: 2), () {
                    Get.back();
                  });
                } else {
                  CommonSnackBar.showSnackBar(
                      successStatus: false, msg: _res.message);
                }
              });
            }
          });
        } else {
          CommonSnackBar.showSnackBar(
              successStatus: false, msg: "Please Select Image");
        }
      } else {
        CommonSnackBar.showSnackBar(
            successStatus: false, msg: "Please Fill Reason");
      }
    } else {
      CommonSnackBar.showSnackBar(
          successStatus: false, msg: "Please Select Reason");
    }
  }
}
