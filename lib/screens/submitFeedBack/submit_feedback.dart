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
import 'package:skoolmonk/model/reqestModel/image_upload_request_model.dart';
import 'package:skoolmonk/model/reqestModel/submit_review_req.dart';
import 'package:skoolmonk/model/responseModel/image_upload_response_model.dart';
import 'package:skoolmonk/model/responseModel/submit_feedback_response_model.dart';
import 'package:skoolmonk/viewModel/get_order_return_option_viewmodel.dart';
import 'package:skoolmonk/viewModel/submit_review_viewmodel.dart';
import 'package:skoolmonk/viewModel/update_profile_view_model.dart';

class SubmitFeedBackScreen extends StatefulWidget {
  const SubmitFeedBackScreen();

  @override
  _SubmitFeedBackScreenState createState() => _SubmitFeedBackScreenState();
}

class _SubmitFeedBackScreenState extends State<SubmitFeedBackScreen> {
  GetOrderReturnOptionViewModel _getOrderReturnOptionViewModel = Get.find();
  SubmitReviewReqModel _submitReviewReqModel = SubmitReviewReqModel();
  UpdateProfileViewModel _updateProfileViewModel = Get.find();

  UserSubmitReviewViewModel _userSubmitReviewViewModel = Get.find();
  ImageUploadReq _imageUploadReq = ImageUploadReq();
  TextEditingController commentController = TextEditingController();
  String dropdownValue;
  int qtyProduct = 0;
  List filePath1 = [];
  List apiUrlPath = [];

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
    _getOrderReturnOptionViewModel.images.clear();

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
          "Feedback",
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
                            TextFormField(
                              controller: commentController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Feedback',
                                alignLabelWithHint: true,
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 6,
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
                        controller.modelProgress = true;
                        imageUp();
                        controller.modelProgress = false;
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                            color: ColorPicker.navyBlue,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          "Submit Review",
                          style: TextStyle(color: Colors.white, fontSize: 18),
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

  imageUp() async {
    apiUrlPath.clear();

    if (filePath1.isNotEmpty) {
      filePath1.forEach((element) async {
        _imageUploadReq.img = element;
        await _updateProfileViewModel.imageUpload(model: _imageUploadReq);

        ImageUploadResponse resUrlApi =
            _updateProfileViewModel.imageUploadApiResponse.data;
        apiUrlPath.add(resUrlApi.response[0].path);
        if (filePath1.length == apiUrlPath.length) {
          if (commentController.text.isNotEmpty) {
            _submitReviewReqModel.userId = PreferenceManager.getTokenId();
            _submitReviewReqModel.feedBack = commentController.text;
            _submitReviewReqModel.files =
                '${apiUrlPath.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
            await _userSubmitReviewViewModel.userSubmitReviewViewModel(
                model: _submitReviewReqModel);
            SubmitReviewResponse _res =
                _userSubmitReviewViewModel.apiResponse.data;
            if (_res.status == 200) {
              CommonSnackBar.showSnackBar(
                  msg: _res.message, successStatus: true);
              Future.delayed(Duration(seconds: 2), () {
                Get.back();
              });
            } else {
              CommonSnackBar.showSnackBar(
                  msg: _res.message, successStatus: false);
            }
          } else {
            CommonSnackBar.showSnackBar(
                msg: 'Please Fill the FeedBack', successStatus: false);
          }
        }
      });
    } else {
      if (commentController.text.isNotEmpty) {
        _submitReviewReqModel.userId = PreferenceManager.getTokenId();
        _submitReviewReqModel.feedBack = commentController.text;
        _submitReviewReqModel.files = '';
        await _userSubmitReviewViewModel.userSubmitReviewViewModel(
            model: _submitReviewReqModel);
        SubmitReviewResponse _res1 =
            _userSubmitReviewViewModel.apiResponse.data;
        if (_res1.status == 200) {
          CommonSnackBar.showSnackBar(msg: _res1.message, successStatus: true);
          Future.delayed(Duration(seconds: 2), () {
            Get.back();
          });
        } else {
          CommonSnackBar.showSnackBar(msg: _res1.message, successStatus: false);
        }
      } else {
        CommonSnackBar.showSnackBar(
            msg: 'Please Fill the FeedBack', successStatus: false);
      }
    }
  }
}
