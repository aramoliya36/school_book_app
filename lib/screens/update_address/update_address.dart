import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/adress_controller.dart';
import 'package:skoolmonk/controller/update_address_single_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/update_address_reqmodel.dart';
import 'package:skoolmonk/model/responseModel/get_city_by_state.dart';
import 'package:skoolmonk/model/responseModel/get_country_by_state._responsemodel.dart';
import 'package:skoolmonk/viewModel/get_city_by_state_view_model.dart';
import 'package:skoolmonk/viewModel/get_state_by_country_viewmodel.dart';
import 'package:skoolmonk/viewModel/single_save_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/update_address_viewmodel.dart';

import '../../model/responseModel/single_address_save_response.dart';

class UpdateAddress extends StatefulWidget {
  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  AddressId _addressId = Get.find();
  SingleAllUserAddressViewModel _singleAllUserAddressViewModel = Get.find();

  UpdateAddressSingleController _updateAddressSingleController = Get.find();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fNameController;
  TextEditingController lNameController;

  TextEditingController emailController;
  TextEditingController mobileController;
  TextEditingController address1Controller;
  TextEditingController address2Controller;
  TextEditingController pincodeController;

  UpdateAddressViewModel _updateAddressViewModel = Get.find();

  GetStateByCountryViewModel _getStateByCountryRepo = Get.find();
  GetCityByStateViewModel _getCityByStateViewModel = Get.find();
  String isSelectStateState;
  String isApiCodeStateState = '';
  String isSelectCity;
  String isApiCodeSelectCity = '';
  SingleMyResponse singleMyResponse = SingleMyResponse();

  @override
  void initState() {
    // TODO: implement initState

    isSelectStateState = null;
    isSelectCity = null;
    _getStateByCountryRepo.getStateByCountryViewModel();

    singleMyResponse = _updateAddressSingleController.updateScreenSingle[0];
    isApiCodeStateState = singleMyResponse.state_id;
    isApiCodeSelectCity = singleMyResponse.city_id;
    _getCityByStateViewModel.getCityByStateViewModel(
        stdId: isApiCodeStateState);

    log("MY STATE ${isApiCodeStateState}");
    log("MY STATE city ${isApiCodeSelectCity}");
    mobileController = TextEditingController(text: singleMyResponse.mobile);
    lNameController = TextEditingController(text: singleMyResponse.lname);
    fNameController = TextEditingController(text: singleMyResponse.fname);
    emailController = TextEditingController(text: singleMyResponse.email);
    address1Controller = TextEditingController(text: singleMyResponse.address1);
    address2Controller = TextEditingController(text: singleMyResponse.address2);
    pincodeController = TextEditingController(text: singleMyResponse.pincode);
    //  isSelectStateState =
    //     _updateAddressSingleController.updateScreenSingle[0].state;
    // isSelectCity = _updateAddressSingleController.updateScreenSingle[0].city;
    // isSelectStateState =
    //     _updateAddressSingleController.updateScreenSingle[0].state;
    // isSelectCity = _updateAddressSingleController.updateScreenSingle[0].city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.commonAppBar(
          appTitle: 'Address',
          leadingIcon: Icons.arrow_back_rounded,
          onPress: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: Column(
              children: [
                CommanWidget.getTextFormField(
                    labelText: "First Name",
                    textEditingController: fNameController,
                    // inputLength: 10,
                    regularExpression: Utility.alphabetValidationPattern,
                    validationMessage: Utility.nameEmptyValidation,
                    hintText: "Enter First Name"),
                CommanWidget.getTextFormField(
                    labelText: "Last Name",
                    textEditingController: lNameController,
                    regularExpression: Utility.alphabetValidationPattern,
                    validationMessage: Utility.lastNameEmptyValidation,
                    hintText: "Enter Last Name"),
                CommanWidget.getTextFormField(
                    labelText: "Email Id",
                    textEditingController: emailController,
                    regularExpression: Utility.emailAddressValidationPattern,
                    validationMessage: Utility.kUserNameEmptyValidation,
                    validationType: 'email',
                    hintText: "Enter Email Id"),
                CommanWidget.getTextFormField(
                    labelText: "Mobile Number",
                    textEditingController: mobileController,
                    inputLength: 10,
                    regularExpression: Utility.digitsValidationPattern,
                    validationMessage: Utility.mobileNumberInValidValidation,
                    validationType: 'mobileno',
                    hintText: "Enter Mobile Number"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GetBuilder<GetStateByCountryViewModel>(
                      builder: (subController) {
                        if (subController.apiResponse.status ==
                            Status.COMPLETE) {
                          GetCountryByStateResponse stateListResponse =
                              subController.apiResponse.data;
                          return Container(
                            height: Get.height / 20,
                            width: Get.width / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                            ),
                            // color: ColorPicker.themColor,
                            child: Center(
                              child: DropdownButton<String>(
                                elevation: 10,
                                underline: SizedBox(),
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    isSelectStateState != null &&
                                            isSelectStateState != ""
                                        ? isSelectStateState
                                        : singleMyResponse.state != null
                                            ? singleMyResponse.state
                                            : 'Select State',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                dropdownColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                // iconEnabledColor: Colors.white,
                                items: stateListResponse.response.map((value) {
                                  return DropdownMenuItem<String>(
                                      value: value.name,
                                      onTap: () {
                                        isSelectStateState = value.name;
                                        isApiCodeStateState = value.stateId;
                                        isSelectCity = '';
                                        singleMyResponse.city = '';
                                      },
                                      child: Center(
                                        child: Text(
                                          '${value.name}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) async {
                                  setState(() {});
                                  await _getCityByStateViewModel
                                      .getCityByStateViewModel(
                                          stdId: isApiCodeStateState);
                                },
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Spacer(),
                    GetBuilder<GetCityByStateViewModel>(
                      builder: (cityController) {
                        if (cityController.apiResponse.status ==
                            Status.COMPLETE) {
                          GetCityByCountryResponse cityResponse =
                              cityController.apiResponse.data;
                          return Container(
                            height: Get.height / 20,
                            width: Get.width / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: DropdownButton(
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    isSelectCity != null && isSelectCity != ""
                                        ? isSelectCity
                                        : singleMyResponse.city != null &&
                                                singleMyResponse.city != ''
                                            ? singleMyResponse.city
                                            : 'Select city',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                underline: SizedBox(),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black),
                                items: cityResponse.response.map((val) {
                                  return DropdownMenuItem<String>(
                                      value: val.name,
                                      onTap: () {
                                        isApiCodeSelectCity = val.cityId;
                                      },
                                      child: Center(
                                        child: Text(
                                          '${val.name}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      isSelectCity = val;
                                      log("SET ID $isSelectCity");
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CommanWidget.getTextFormField(
                    labelText: "Address 1",
                    textEditingController: address1Controller,
                    regularExpression: Utility.addressValidationPattern,
                    validationMessage: Utility.addressEmptyValidation,
                    hintText: "Enter Address 1"),
                CommanWidget.getTextFormField(
                    labelText: "Address 2",
                    textEditingController: address2Controller,
                    regularExpression: Utility.addressValidationPattern,
                    validationMessage: Utility.addressEmptyValidation,
                    hintText: "Enter Address 2"),
                CommanWidget.getTextFormField(
                    labelText: "Pincode",
                    textEditingController: pincodeController,
                    regularExpression: Utility.digitsValidationPattern,
                    validationMessage: Utility.pincodeEmptyValidation,
                    hintText: "Enter Pincode "),
                SizedBox(
                  height: 20,
                ),
                authBottomButton(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        if (isApiCodeSelectCity == '' &&
                            isApiCodeStateState == '') {
                          return CommonSnackBar.showSnackBar(
                              msg: 'Please Enter State &City');
                        } else {
                          UpdateAddressReqModel _user = UpdateAddressReqModel();
                          _user.useraddressid = _updateAddressSingleController
                              .updateScreenSingle[0].userAddressId;
                          _user.userId = _updateAddressSingleController
                              .updateScreenSingle[0].userId;
                          _user.fname = fNameController.text;
                          _user.lname = lNameController.text;
                          _user.email = emailController.text;
                          _user.mobile = mobileController.text;
                          _user.state = isApiCodeStateState;
                          _user.city = isApiCodeSelectCity;
                          _user.address1 = address1Controller.text;
                          _user.address2 = address2Controller.text;
                          _user.pincode = pincodeController.text;
                          await _updateAddressViewModel
                              .updateAddressViewModel(model: _user)
                              .then((value) {
                            _singleAllUserAddressViewModel
                                .singleAllUserAddressViewModel();

                            Get.back();
                          });
                          // if (_updateAddressViewModel.apiResponse.status ==
                          //     Status.COMPLETE) {
                          //   AddAddressResponse response =
                          //       _updateAddressViewModel.apiResponse.data;
                          //   if (response.response[0].userId ==
                          //       PreferenceManager.getTokenId()) {
                          //     _addressId.userAddressId =
                          //         response.response[0].userAddressId;
                          //     _addressId.userId =
                          //         int.parse(response.response[0].userId);
                          //     print('amrendddddddddd---dd--d--d--d-d');
                          //     Get.back();
                          //   }
                          // }

                        }
                      } else {
                        return CommonSnackBar.showSnackBar(
                            msg: 'Please Enter All Value');
                      }
                    },
                    title: 'Add Address'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
