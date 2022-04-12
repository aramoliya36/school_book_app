import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skoolmonk/common/app_bar.dart';
import 'package:skoolmonk/common/auth_Button.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/comman_widget.dart';
import 'package:skoolmonk/common/coomon_snackbar.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/bottom_controller.dart';
import 'package:skoolmonk/controller/setdob_controller.dart';
import 'package:skoolmonk/controller/validation_controller.dart';
import 'package:skoolmonk/model/apis/api_response.dart';
import 'package:skoolmonk/model/reqestModel/image_upload_request_model.dart';
import 'package:skoolmonk/model/reqestModel/update_profile_req_model.dart';
import 'package:skoolmonk/model/reqestModel/update_user_detail_req_model.dart';
import 'package:skoolmonk/model/responseModel/get_user_detail_responce_model.dart';
import 'package:skoolmonk/model/responseModel/image_upload_response_model.dart';
import 'package:skoolmonk/model/responseModel/update_userdetail_responce_model.dart';
import 'package:skoolmonk/screens/auth/SignIn/sign_in.dart';
import 'package:skoolmonk/screens/user/widget/update_mobile_screem.dart';
import 'package:skoolmonk/viewModel/get_profile.dart';
import 'package:skoolmonk/viewModel/update_profile_view_model.dart';
import 'package:skoolmonk/viewModel/update_userdetail_view_model.dart';

import '../../common/circularprogress_indicator.dart';

class UserUpdateProfileScreen extends StatefulWidget {
  const UserUpdateProfileScreen({Key key}) : super(key: key);

  @override
  _UserUpdateProfileScreenState createState() =>
      _UserUpdateProfileScreenState();
}

class _UserUpdateProfileScreenState extends State<UserUpdateProfileScreen> {
  File _image;
  final picker = ImagePicker();
  Size deviceSize;

  BottomController homeController = Get.find();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValidationController validationController =
      Get.put(ValidationController());
  RxString dropdownValue = "".obs;

  TextEditingController nameTextEditingController;
  TextEditingController lastNameTextEditingController;

  TextEditingController emailTextEditingController;

  TextEditingController addressTextEditingController;
  TextEditingController mobileNoTextEditingController;
  DateTime selectedDate = DateTime.now();
  List<String> companiesList = ['Male', 'Female'];
  SetDateOfBirth setDateOfBirth = Get.put(SetDateOfBirth());
  GetProfileViewModel controller = Get.put(GetProfileViewModel());
  UpdateUserDetailViewModel updateUserDetailViewModel =
      Get.put(UpdateUserDetailViewModel());
  UpdateProfileViewModel updateProfileViewModel =
      Get.put(UpdateProfileViewModel());
  @override
  void initState() {
    // TODO: implement initState
    mobileNoTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    lastNameTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    validationController.termCondition = false.obs;
    validationController.obscureText = true.obs;

    controller.getProfile();

    if (PreferenceManager.getTokenId() == null) {
      Future.delayed(Duration.zero, () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Get.back();
                            // homeController.selectedScreen.value = 'HomeScreen';
                            homeController.bottomIndex.value = 0;
                            Get.to(SignInScreen());
                          },
                          color: ColorPicker.navyBlue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            homeController.selectedScreen('HomeScreen');
                            homeController.bottomIndex.value = 0;
                            Get.back();
                          },
                          color: ColorPicker.redColorApp,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              );
            });
      });
    }
    super.initState();
  }

  showMsg(String msg) {
    CommanWidget.snackBar(title: msg, message: '', position: SnackPosition.TOP);
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        homeController.bottomIndex.value = 0;

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          padding: EdgeInsets.only(bottom: Get.height * 0.025),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      right: -Get.height * 0.13,
                      top: -Get.height * 0.1,
                      child: Container(
                          height: Get.height * 0.4,
                          width: Get.width,
                          child: Image.asset("assets/images/bgprofile.png"))),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.height * 0.1,
                        bottom: Get.height * 0.04,
                        top: Get.height * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GetBuilder<GetProfileViewModel>(builder: (controller) {
                          if (controller.apiResponse.status ==
                              Status.COMPLETE) {
                            GetUserDetailResponce response =
                                controller.apiResponse.data;

                            return Container(
                              height: Get.height * 0.15,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(0, 1))
                                ],
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    image: _image == null
                                        ? response.response[0].profilePic ==
                                                    null ||
                                                response.response[0].profilePic
                                                    .isEmpty
                                            ? NetworkImage(
                                                "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg")
                                            : NetworkImage(response
                                                .response[0].profilePic
                                                .trim())
                                        : FileImage(
                                            _image,
                                          ),
                                    fit: BoxFit.cover),
                              ),
                            );
                          }
                          if (controller.apiResponse.status == Status.ERROR) {}
                          return Container(
                            height: Get.height * 0.15,
                            width: Get.width * 0.25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    offset: Offset(0, 1))
                              ],
                              border: Border.all(color: Colors.blue, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: buttonChangeProfile,
                          child: Text(
                            "Change Profile",
                            style: TextStyle(
                                color: ColorPicker.navyBlue,
                                fontSize: Get.height * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Form(
                  key: _formKey,
                  child: GetBuilder<GetProfileViewModel>(
                    init: controller,
                    builder: (controller) {
                      if (controller.apiResponse.status == Status.COMPLETE) {
                        GetUserDetailResponce getUserDetailResponce =
                            controller.apiResponse.data;

                        return editProfileForm(context, getUserDetailResponce);
                      } else if (controller.apiResponse.status ==
                          Status.ERROR) {
                        return Center(
                          child: Text("No User Data"),
                        );
                      } else {
                        return Center(child: circularProgress());
                      }
                    },
                  )),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: authBottomButton(
                title: "SAVE UPDATE", onTap: saveUpdateButtonOnTap)),
        GetBuilder<UpdateUserDetailViewModel>(
          init: updateUserDetailViewModel,
          builder: (controller) {
            if (updateUserDetailViewModel.apiResponse.status ==
                Status.LOADING) {
              return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(ColorPicker.navyBlue),
                    ),
                  ));
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  Future<void> saveUpdateButtonOnTap() async {
    UpdateUserDetailReqModel updateUserDetailReqModel =
        UpdateUserDetailReqModel();
    updateUserDetailReqModel.userId = PreferenceManager.getTokenId();
    updateUserDetailReqModel.fname = nameTextEditingController.text;
    updateUserDetailReqModel.lname = lastNameTextEditingController.text;
    updateUserDetailReqModel.dob = setDateOfBirth.dob.value;
    updateUserDetailReqModel.gender = dropdownValue.value;
    await updateUserDetailViewModel.updateUserDetail(updateUserDetailReqModel);

    if (updateUserDetailViewModel.apiResponse.status == Status.COMPLETE) {
      UpdateUserDetailResponce responce =
          updateUserDetailViewModel.apiResponse.data;
      if (responce.status == 200) {
        CommonSnackBar.showSnackBar(msg: responce.message, successStatus: true);
      } else {
        CommonSnackBar.showSnackBar(
          msg: responce.message,
        );
      }
    } else {
      CommonSnackBar.showSnackBar(
        msg: "No user data updated",
      );
    }
  }

  Widget _buildAppBar() {
    return CommonAppBar.commonAppBar(
        onPress: () {
          // Navigator.pop(context);
          homeController.bottomIndex.value = 0;
          homeController.setSelectedScreen('');
        },
        appTitle: "Edit Profile",
        leadingIcon: Icons.arrow_back_rounded);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String dob = formatter.format(picked);
      print('-----------------dob----------------$dob');
      setDateOfBirth.setDOB(dob);
      print('-----------------dob---------1-------${setDateOfBirth.dob}');
    }
  }

  Widget editProfileForm(BuildContext context, GetUserDetailResponce responce) {
    nameTextEditingController.text = responce.response[0].fname ?? "";
    lastNameTextEditingController.text = responce.response[0].lname ?? "";
    mobileNoTextEditingController.text = responce.response[0].mobile ?? "";
    setDateOfBirth.dob.value = responce.response[0].dob ?? "";
    dropdownValue.value =
        responce.response[0].gender == '' || responce.response[0].gender == null
            ? ""
            : responce.response[0].gender ?? "";
    emailTextEditingController.text = responce.response[0].email ?? "";

    return Material(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // shrinkWrap: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize.height / 25,
              ),

              ///Name...
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommanWidget.getTextFormField(
                      labelText: "Full Name",
                      textEditingController: nameTextEditingController,
                      inputLength: 30,
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.nameEmptyValidation,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.016,
                  ),
                  Expanded(
                    flex: 2,
                    child: CommanWidget.getTextFormField(
                      labelText: "Last Name",
                      textEditingController: lastNameTextEditingController,
                      hintText: "Enter Last Name",
                      inputLength: 30,
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.lastNameEmptyValidation,
                    ),
                  ),
                ],
              ),

              ///Mobile Number...
              InkWell(
                onTap: () {
                  homeController.bottomIndex.value = 0;
                  Get.to(UpdateMobileOTPScreen());
                },
                child: CommanWidget.getTextFormField(
                    labelText: "Mobile Number",
                    textEditingController: mobileNoTextEditingController,
                    inputLength: 10,
                    isEnable: false,
                    regularExpression: Utility.digitsValidationPattern,
                    validationMessage: Utility.mobileNumberInValidValidation,
                    validationType: 'mobileno',
                    hintText: "Enter Mobile No",
                    icon: Icons.edit),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date of Birth",
                          style: TextStyle(
                              color: ColorPicker.textLabel,
                              fontSize: Get.height * 0.02),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        InkWell(onTap: () {
                          _selectDate(context);
                        }, child: GetBuilder<SetDateOfBirth>(
                          builder: (controller1) {
                            return Container(
                              height: Get.height * 0.05,
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.02,
                                  vertical: Get.height * 0.009),
                              child: Text(
                                "${controller1.dob.value != "" ? controller1.dob.value.toString() : "D-O-B"}",
                                style: TextStyle(
                                    fontSize: Get.height * 0.021,
                                    color: Colors.black),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                color: const Color(0xffffffff),
                                border: Border.all(
                                    width: 1.0,
                                    color: ColorPicker.textFormBorder),
                              ),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.016,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              color: ColorPicker.textLabel,
                              fontSize: Get.height * 0.02),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(() {
                          return Container(
                            height: Get.height * 0.05,
                            width: Get.width,
                            decoration: ShapeDecoration(
                              // color: Colors.red,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0,
                                    color: ColorPicker.textFormBorder),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue.value == ""
                                  ? null
                                  : dropdownValue.value,
                              hint: Text("  Select gender"),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RotatedBox(
                                    quarterTurns: 135,
                                    child: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.black,
                                    )),
                              ),
                              iconSize: Get.height * 0.02,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String newValue) {
                                dropdownValue.value = newValue;
                                // selectedValueIndex.value = newValue;
                              },
                              items: companiesList.map((String companiesData) {
                                return new DropdownMenuItem<String>(
                                  value: "$companiesData",
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: new Text(companiesData,
                                        style: new TextStyle(
                                            fontSize: Get.height * 0.021,
                                            color: Colors.black)),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              ///Email...
              CommanWidget.getTextFormField(
                labelText: "Email Address",
                textEditingController: emailTextEditingController,
                validationType: Utility.emailText,
                hintText: "Enter Email Address",
                isEnable: false,
                inputLength: 50,
                regularExpression: Utility.emailAddressValidationPattern,
                validationMessage: Utility.emailEmptyValidation,
              ),

              ///Email...
              // CommanWidget.getTextFormField(
              //     labelText: "Address",
              //     textEditingController: addressTextEditingController,
              //     validationType: Utility.addressText,
              //     hintText: "Enter Address",
              //     inputLength: 50,
              //     regularExpression: Utility.addressValidationPattern,
              //     validationMessage: Utility.addressEmptyValidation,
              //     maxLine: 5),
              // sizedBox(),
            ],
          )),
    );
  }

  sizedBox() {
    return SizedBox(height: deviceSize.width / 14);
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=======================imagepathe${imaGe.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("=======================imagepathe${imaGe.path}");

    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=======================imagepathe${_image}");
        print("=======================imagepathe${imaGe.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future<void> buttonChangeProfile() async {
    Get.dialog(Center(
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorPicker.navyBlue)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  getGalleryImage().then((value) => upLoadProfile());
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  height: Get.height * 0.06,
                  width: Get.width * 0.3,
                  color: ColorPicker.navyBlue,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  getCamaroImage().then((value) => upLoadProfile());
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  height: Get.height * 0.06,
                  width: Get.width * 0.3,
                  color: ColorPicker.navyBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    // print("=========================getidd=${PreferenceManager.getTokenId()}");
  }

  upLoadProfile() async {
    if (_image == null) {
      CommonSnackBar.showSnackBar(msg: "Please select profile image");
      return;
    }
    ImageUploadReq imageUploadReq = ImageUploadReq();
    imageUploadReq.img = _image.path;
    print('----------profile Image Pathe---${_image.path}');
    await updateProfileViewModel.imageUpload(model: imageUploadReq);
    if (updateProfileViewModel.imageUploadApiResponse.status ==
        Status.COMPLETE) {
      ImageUploadResponse response =
          updateProfileViewModel.imageUploadApiResponse.data;
      if (response.status == 200) {
        UpdateProfileReq updateProfileReq = UpdateProfileReq();

        updateProfileReq.userId = PreferenceManager.getTokenId();

        updateProfileReq.profile = response.response[0].path;
        await updateProfileViewModel.updateProfile(model: updateProfileReq);
        if (updateProfileViewModel.apiResponse.status == Status.COMPLETE) {
          if (response.status == 200) {
            CommonSnackBar.showSnackBar(
                msg: response.message, successStatus: true);
          } else {
            CommonSnackBar.showSnackBar(msg: "Server error");
          }
        } else {
          CommonSnackBar.showSnackBar(msg: "Server error");
        }
      }
    } else {
      CommonSnackBar.showSnackBar(msg: "Server error");
    }
  }
}
