import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/circularprogress_indicator.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/servor_error_text.dart';
import 'package:skoolmonk/controller/update_address_single_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/delete_address_reqest.dart';
import 'package:skoolmonk/model/reqestModel/update_select_req.dart';
import 'package:skoolmonk/model/responseModel/single_address_save_response.dart';
import 'package:skoolmonk/screens/addAddress/add_address_screen.dart';
import 'package:skoolmonk/screens/update_address/update_address.dart';
import 'package:skoolmonk/viewModel/delete_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_all_user_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/single_save_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/update_select_address_view_model.dart';

import '../../common/color_picker.dart';
import '../../common/color_picker.dart';
import '../../common/color_picker.dart';
import '../../common/color_picker.dart';
import '../../common/color_picker.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  UpdateSelectAddressViewModel _updateSelectAddressViewModel = Get.find();

  SingleAllUserAddressViewModel _singleAllUserAddressViewModel = Get.find();
  DeleteAddressViewModel _deleteAddressViewModel = Get.find();
  UpdateAddressSingleController _updateAddressSingleController = Get.find();
  GetAllUserAddressViewModel _getAllUserAddressViewModel = Get.find();

  @override
  void initState() {
    _singleAllUserAddressViewModel.singleAllUserAddressViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.98),
      appBar: CommonAppBar.commonAppBar(
          appTitle: 'Address',
          leadingIcon: Icons.arrow_back_rounded,
          onPress: () {
            Get.back();
          }),
      body: GetBuilder<SingleAllUserAddressViewModel>(
        builder: (controller) {
          log("STATUS MY ADDRESS ${controller.apiResponse.status}");
          if (controller.apiResponse.status == Status.LOADING) {
            return circularProgress();
          }
          if (controller.apiResponse.status == Status.ERROR) {
            return Material(
                color: Colors.white, child: Center(child: serverErrorText()));
          }
          if (controller.apiResponse.status == Status.COMPLETE) {
            SingleAllUserAddressResponse response = controller.apiResponse.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width / 30,
                  ),
                  MaterialButton(
                    color: ColorPicker.navyBlue,
                    child: Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.to(AddAddress());
                    },
                  ),
                  response.status == 400
                      ? Center(
                          child: Column(
                          children: [
                            SizedBox(
                              height: Get.width / 1.6,
                            ),
                            Text('No Address Found'),
                          ],
                        ))
                      : Padding(
                          padding: EdgeInsets.only(top: Get.height / 49),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: response.response.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return response.response.length > 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Get.height / 49),
                                      child: Column(
                                        children: [
                                          Container(
                                            // height: Get.height / 6,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(.35),
                                                      offset: Offset(0, 0),
                                                      blurRadius: 20)
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height / 40,
                                                  horizontal: Get.width / 26),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${response.response[index].fname ?? ''} ${response.response[index].lname ?? ''}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                Get.width / 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        height: Get.height / 40,
                                                        width: Get.width / 20,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .yellow,
                                                                width: 2)),
                                                        child: Checkbox(
                                                          focusColor: response
                                                                      .response[
                                                                          index]
                                                                      .isSelected ==
                                                                  '1'
                                                              ? Colors.yellow
                                                              : Colors.green,
                                                          checkColor:
                                                              Colors.white,
                                                          activeColor:
                                                              ColorPicker
                                                                  .navyBlue,
                                                          fillColor: MaterialStateProperty.all(response
                                                                      .response[
                                                                          index]
                                                                      .isSelected ==
                                                                  '1'
                                                              ? ColorPicker
                                                                  .navyBlue
                                                              : ColorPicker
                                                                  .navyBlue),
                                                          value: response
                                                                      .response[
                                                                          index]
                                                                      .isSelected ==
                                                                  '1'
                                                              ? true
                                                              : false,
                                                          onChanged:
                                                              (value) async {
                                                            UpdateSelectAddressReqModel
                                                                _userSelect =
                                                                UpdateSelectAddressReqModel();
                                                            _userSelect.userid =
                                                                response
                                                                    .response[
                                                                        index]
                                                                    .userId;
                                                            _userSelect
                                                                    .isSelected =
                                                                '1';
                                                            _userSelect
                                                                    .useraddressid =
                                                                response
                                                                    .response[
                                                                        index]
                                                                    .userAddressId;

                                                            await _updateSelectAddressViewModel
                                                                .updateSelectAddressViewModel(
                                                                    model:
                                                                        _userSelect)
                                                                .then((value) {
                                                              _getAllUserAddressViewModel
                                                                  .getAllUserAddressViewModel();

                                                              _singleAllUserAddressViewModel
                                                                  .singleAllUserAddressViewModel();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height / 60,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: Get.width / 1.6,
                                                        // color: ColorPicker.yellow,
                                                        child: Text(
                                                          '${response.response[index].address1 ?? ''} ${response.response[index].city ?? ''} ${response.response[index].state ?? ''} - ${response.response[index].pincode ?? ''}',
                                                          style: TextStyle(
                                                            fontSize:
                                                                Get.width / 27,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.update,
                                                            color: ColorPicker
                                                                .navyBlue,
                                                          ),
                                                          onPressed: () {
                                                            _updateAddressSingleController
                                                                .clearSetUpdateAddressScreen();
                                                            _updateAddressSingleController
                                                                .setUpdateAddressScreen(
                                                                    value: response
                                                                            .response[
                                                                        index]);

                                                            Get.to(
                                                                UpdateAddress());
                                                          }),
                                                      // MaterialButton(
                                                      //   color: ColorPicker
                                                      //       .navyBlue,
                                                      //   child:
                                                      //       Icon(Icons.update),
                                                      //   onPressed: () {
                                                      //     _updateAddressSingleController
                                                      //         .clearSetUpdateAddressScreen();
                                                      //     _updateAddressSingleController
                                                      //         .setUpdateAddressScreen(
                                                      //             value: response
                                                      //                     .response[
                                                      //                 index]);
                                                      //
                                                      //     Get.to(
                                                      //         UpdateAddress());
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height / 60,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${response.response[index].mobile ?? ''}',
                                                        style: TextStyle(
                                                          fontSize:
                                                              Get.width / 27,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: ColorPicker
                                                              .redColorApp,
                                                        ),
                                                        onPressed: () async {
                                                          DeleteAddressReqModel
                                                              _userDelete =
                                                              DeleteAddressReqModel();

                                                          _userDelete
                                                                  .useraddressid =
                                                              response
                                                                  .response[
                                                                      index]
                                                                  .userAddressId;
                                                          _userDelete.userid =
                                                              response
                                                                  .response[
                                                                      index]
                                                                  .userId;
                                                          await _deleteAddressViewModel
                                                              .deleteAddressViewModel(
                                                                  model:
                                                                      _userDelete)
                                                              .then((value) {
                                                            _singleAllUserAddressViewModel
                                                                .singleAllUserAddressViewModel();
                                                          });
                                                          // Get.back();
                                                        },
                                                      ),
                                                      // MaterialButton(
                                                      //   color: ColorPicker
                                                      //       .navyBlue,
                                                      //   child: Text(
                                                      //     'Delete',
                                                      //     style: TextStyle(
                                                      //         color:
                                                      //             Colors.white),
                                                      //   ),
                                                      //   onPressed: () async {
                                                      //     Get.dialog(
                                                      //       AlertDialog(
                                                      //         title: Text(
                                                      //             "Delete Address"),
                                                      //         actions: <Widget>[
                                                      //           FlatButton(
                                                      //             child: Text(
                                                      //                 "Delete"),
                                                      //             onPressed:
                                                      //                 () async {
                                                      //               DeleteAddressReqModel
                                                      //                   _userDelete =
                                                      //                   DeleteAddressReqModel();
                                                      //
                                                      //               _userDelete
                                                      //                       .useraddressid =
                                                      //                   response
                                                      //                       .response[index]
                                                      //                       .userAddressId;
                                                      //               _userDelete
                                                      //                       .userid =
                                                      //                   response
                                                      //                       .response[index]
                                                      //                       .userId;
                                                      //               await _deleteAddressViewModel
                                                      //                   .deleteAddressViewModel(
                                                      //                       model:
                                                      //                           _userDelete)
                                                      //                   .then(
                                                      //                       (value) {
                                                      //                 _singleAllUserAddressViewModel
                                                      //                     .singleAllUserAddressViewModel();
                                                      //               });
                                                      //               Get.back();
                                                      //             },
                                                      //           ),
                                                      //           FlatButton(
                                                      //             child: Text(
                                                      //                 "Cancel"),
                                                      //             onPressed:
                                                      //                 () {
                                                      //               Get.back();
                                                      //             },
                                                      //           )
                                                      //         ],
                                                      //       ),
                                                      //       barrierDismissible:
                                                      //           false,
                                                      //     );
                                                      //   },
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
