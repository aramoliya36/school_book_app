import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/adress_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/post_add_address_reqest.dart';
import 'package:skoolmonk/model/responseModel/get_city_by_state.dart';
import 'package:skoolmonk/model/responseModel/get_country_by_state._responsemodel.dart';
import 'package:skoolmonk/model/responseModel/get_user_detail_responce_model.dart';
import 'package:skoolmonk/model/responseModel/post_add_address_response_model.dart';
import 'package:skoolmonk/viewModel/get_all_user_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/get_city_by_state_view_model.dart';
import 'package:skoolmonk/viewModel/get_profile.dart';
import 'package:skoolmonk/viewModel/get_state_by_country_viewmodel.dart';
import 'package:skoolmonk/viewModel/post_add_address_viewmodel.dart';
import 'package:skoolmonk/viewModel/single_save_address_viewmodel.dart';

import '../../common/circularprogress_indicator.dart';
import '../../common/servor_error_text.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddressId _addressId = Get.find();
  GetAllUserAddressViewModel _getAllUserAddressViewModel = Get.find();
  SingleAllUserAddressViewModel _singleAllUserAddressViewModel = Get.find();
  GetProfileViewModel _getProfileViewModel = Get.find();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  AddAddressViewModel _addAddressViewModel = Get.find();

  GetStateByCountryViewModel _getStateByCountryRepo = Get.find();
  GetCityByStateViewModel _getCityByStateViewModel = Get.find();
  String isSelectStateState = '';
  String isApiCodeStateState = '';
  String isSelectCity = '';
  String isApiCodeSelectCity = '';

  @override
  void initState() {
    // TODO: implement initState
    _getProfileViewModel.getProfile();

    _getStateByCountryRepo.getStateByCountryViewModel();
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
      body: GetBuilder<GetProfileViewModel>(
        builder: (controller) {
          GetUserDetailResponce _getUserDetails =
              _getProfileViewModel.apiResponse.data;

          if (controller.apiResponse.status == Status.LOADING) {
            return circularProgress();
          }
          if (controller.apiResponse.status == Status.ERROR) {
            return Material(
                color: Colors.white, child: Center(child: serverErrorText()));
          }
          if (controller.apiResponse.status == Status.COMPLETE) {
            // fNameController.text = _getUserDetails.response[0].fname;
            // lNameController.text = _getUserDetails.response[0].lname;
            // emailController.text = _getUserDetails.response[0].email;
            // mobileController.text = _getUserDetails.response[0].mobile;
            return SingleChildScrollView(
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
                          validationType: 'email',
                          regularExpression:
                              Utility.emailAddressValidationPattern,
                          validationMessage: Utility.kUserNameEmptyValidation,
                          hintText: "Enter Email Id"),
                      CommanWidget.getTextFormField(
                          labelText: "Mobile Number",
                          textEditingController: mobileController,
                          inputLength: 10,
                          regularExpression: Utility.digitsValidationPattern,
                          validationMessage:
                              Utility.mobileNumberInValidValidation,
                          validationType: 'mobileno',
                          hintText: "Enter Mobile Number"),
                      SizedBox(
                        height: 8,
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
                                              : "Select State",
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
                                      items: stateListResponse.response
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                            value: value.name,
                                            onTap: () {
                                              isSelectStateState = value.name;
                                              isApiCodeStateState =
                                                  value.stateId;
                                              isSelectCity = '';
                                            },
                                            child: Center(
                                              child: Text(
                                                '${value.name}',
                                                style: TextStyle(
                                                    color: Colors.black),
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
                                          isSelectCity != null &&
                                                  isSelectCity != ""
                                              ? isSelectCity
                                              : "Select city",
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
                                                style: TextStyle(
                                                    color: Colors.black),
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
                        height: 8,
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
                              print('milan okkkk');
                              if (isApiCodeSelectCity == '' &&
                                  isApiCodeStateState == '') {
                                return CommonSnackBar.showSnackBar(
                                    msg: 'Please Enter State &City');
                              } else {
                                AddAddressReqModel _user = AddAddressReqModel();
                                _user.fname = fNameController.text;
                                _user.lname = lNameController.text;
                                _user.email = emailController.text;
                                _user.mobile = mobileController.text;
                                _user.state = isApiCodeStateState;
                                _user.city = isApiCodeSelectCity;
                                _user.address1 = address1Controller.text;
                                _user.address2 = address2Controller.text;
                                _user.pincode = pincodeController.text;
                                _addAddressViewModel
                                    .addAddressViewModel(model: _user)
                                    .then((value) {
                                  if (_addAddressViewModel.apiResponse.status ==
                                      Status.COMPLETE) {
                                    _singleAllUserAddressViewModel
                                        .singleAllUserAddressViewModel();

                                    AddAddressResponse response =
                                        _addAddressViewModel.apiResponse.data;
                                    if (response.response[0].userId ==
                                        PreferenceManager.getTokenId()) {
                                      _addressId.userAddressId =
                                          response.response[0].userAddressId;
                                      _addressId.userId = int.parse(
                                          response.response[0].userId);
                                      _getAllUserAddressViewModel
                                          .getAllUserAddressViewModel();
                                      log('GET.BACK');
                                      Get.back();
                                    }
                                  }
                                });
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
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
