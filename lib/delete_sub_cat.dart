// import 'dart:developer';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:get/get.dart';
// import 'package:skoolmonk/common/app_bar.dart';
// import 'package:skoolmonk/common/circularprogress_indicator.dart';
// import 'package:skoolmonk/common/color_picker.dart';
// import 'package:skoolmonk/common/iconWidget.dart';
// import 'package:skoolmonk/common/servor_error_text.dart';
// import 'package:skoolmonk/common/shared_preference.dart';
// import 'package:skoolmonk/controller/bottom_controller.dart';
// import 'package:skoolmonk/controller/product_detail__screen_controller.dart';
// import 'package:skoolmonk/controller/sub_category_controller.dart';
// import 'package:skoolmonk/model/apis/api_response.dart';
// import 'package:skoolmonk/model/reqestModel/filter_categories_product_post_req_model.dart';
// import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
// import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
// import 'package:skoolmonk/screens/subCategoryListScreen/widget/sub_category_header.dart';
// import 'package:skoolmonk/screens/subCategoryListScreen/widget/sub_category_list_grid.dart';
// import 'package:skoolmonk/viewModel/mainCategoriesSubcategoriesProductFilter_view_model.dart';
// import 'package:skoolmonk/viewModel/sub_category_list_last_api_viewmodel.dart';
//
// import '../../common/circularprogress_indicator.dart';
// import '../../common/utility.dart';
// import '../../controller/filter_controller.dart';
// import '../../controller/filter_data_encoding.dart';
// import '../../model/apis/api_response.dart';
// import '../../model/repo/MainCategoriesSubcategoriesProductFilter_repo.dart';
// import '../../model/responseModel/filter_personal_call_response_model.dart';
// import '../../viewModel/filter_personal_call_view_model.dart';
// import '../../viewModel/mainCategoriesSubcategoriesProductFilter_view_model.dart';
// import '../bottombar/widget/category_bottom_bar_route.dart';
// import '../filterScreen/filterscreen.dart';
//
// class SubCategoryList extends StatefulWidget {
//   final Function onPress;
//   final Function willPopScope;
//
//   SubCategoryList({
//     this.onPress,
//     this.willPopScope,
//   });
//
//   @override
//   _SubCategoryListState createState() => _SubCategoryListState();
// }
//
// class _SubCategoryListState extends State<SubCategoryList> {
//   BottomController bottomController = Get.find();
//   ProductDetailScreenController _productDetailScreenController = Get.find();
//   bool isBottom = true, isDataLoad = false;
//   FilterController _filterController = Get.find();
//   FilterDataController _filterDataController = Get.find();
//   FilterDataController filterScreenController = Get.find();
//   FilterPersonalCallBottomViewModel _filterPersonalCallBottomViewModel =
//   Get.find();
//   MainCategoriesSubcategoriesProductFilterViewModel _filterViewModelMain =
//   Get.find();
//   MainCategoriesSubcategoriesProductFilterRequest _user =
//   MainCategoriesSubcategoriesProductFilterRequest();
//   FilterCategoriesProductRequest _userHomeRout =
//   FilterCategoriesProductRequest();
//   CarouselController _controller = CarouselController();
//   SubCategoryController subCategoryController = Get.find();
//   MainCategoriesSubcategoriesProductFilterResponse responseNew =
//   MainCategoriesSubcategoriesProductFilterResponse();
//   RxBool isLoading = false.obs;
//   int listLengthCount;
//   refreshCallBack() {
//     setState(() {});
//   }
//
//   Future<void> callFilterAPI() async {
//     _user.userId = PreferenceManager.getTokenId() ?? '0';
//     _user.catSlug = '${subCategoryController.catSlugFilter}';
//     _user.page = '0';
//     _user.count = 'YES';
//     _user.perpage = '30';
//     _user.filter = "";
//     await _filterPersonalCallBottomViewModel.filterPersonalCallBottomViewModel(
//         model: _user);
//   }
//
//   SubCategoryListLastViewModelController _fLast = Get.find();
//
//   Future<List<Product>> requestPaginationHomeRout({int offset}) async {
//     try {
//       var filterDataSendApi = PreferenceManager.getStorage.read("categorySlug");
//       _userHomeRout.userId = PreferenceManager.getTokenId() ?? '0';
//       _userHomeRout.filterSlug = '${subCategoryController.catSlugFilter}';
//       _userHomeRout.count = 'NO';
//       _userHomeRout.perPage = Utility.perPageSize.toString() ?? '0';
//
//       _userHomeRout.page = offset?.toString() == null ? '0' : offset.toString();
//       _userHomeRout.filters = '$filterDataSendApi';
//     } catch (e) {
//       log('ERROR ${e.toString()}');
//     }
//     responseNew = await _fLast.subCategoryListLastViewModelController(
//         model: _user, isLoading: false);
//
//     isLoading.value = true;
//     log("LOADING STATUS 1  $isLoading");
//
//     // setState(() {});
//     responseNew = _fLast.apiResponse.data;
//     var subCategory = responseNew.response[0].product;
//
//     return subCategory;
//   }
//
//   Future<List<Product>> requestPagination({int offset}) async {
//     try {
//       var filterDataSendApi = PreferenceManager.getStorage.read("categorySlug");
//       _user.userId = PreferenceManager.getTokenId() ?? '0';
//       _user.catSlug = '${subCategoryController.catSlugFilter}';
//       _user.page = offset?.toString() == null ? '0' : offset.toString();
//       _user.count = 'NO';
//       _user.perpage = Utility.perPageSize.toString() ?? '0';
//       _user.filter = '$filterDataSendApi';
//     } catch (e) {
//       log('ERROR ${e.toString()}');
//     }
//     responseNew = await _fLast.subCategoryListLastViewModelController(
//         model: _user, isLoading: false);
//
//     isLoading.value = true;
//     log("LOADING STATUS 1  $isLoading");
//
//     // setState(() {});
//     responseNew = _fLast.apiResponse.data;
//     var subCategory = responseNew.response[0].product;
//
//     return subCategory;
//   }
//
//   List<Product> passengers = [];
//
//   Future<MainCategoriesSubcategoriesProductFilterResponse>
//   mainCategorySubCategory() async {
//     try {
//       var filterDataSendApi = PreferenceManager.getStorage.read("categorySlug");
//       _user.userId = PreferenceManager.getTokenId() ?? '0';
//       _user.catSlug = '${subCategoryController.catSlugFilter}';
//       _user.page = '0';
//       _user.count = 'NO';
//       _user.perpage = Utility.perPageSize.toString() ?? '0';
//       _user.filter = '$filterDataSendApi';
//     } catch (e) {
//       log('ERROR ${e.toString()}');
//     }
//     await _filterViewModelMain
//         .mainCategoriesSubcategoriesProductFilterViewModel(model: _user);
//     responseNew = _filterViewModelMain.apiResponse.data;
//
//     return responseNew;
//   }
//
//   int currentPage = 1;
//   int totalPages;
//
//   UniqueKey uniqueKey = UniqueKey();
//   @override
//   void initState() {
//     subCategoryController.filterCallBack = false;
//     requestPagination();
//
//     PreferenceManager.getStorage.write("categorySlug", "");
//
//     callFilterAPI();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _filterController.clearFilterList();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     log("LOADING STATUS 2  $isLoading");
//
//     return GetBuilder<SubCategoryController>(
//       builder: (controller) {
//         return WillPopScope(
//           onWillPop: widget.willPopScope,
//           child: Scaffold(
//             appBar: _buildAppBar(controller),
//             body: Column(
//               children: [
//                 FutureBuilder<MainCategoriesSubcategoriesProductFilterResponse>(
//                   future: mainCategorySubCategory(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (snapshot.data != null) {
//                         return snapshot.data.response.isEmpty
//                             ? SizedBox()
//                             : snapshot.data.response[0].subCategory.length == 0
//                             ? SizedBox()
//                             : SubCategoryHeader(
//                           response: snapshot.data,
//                         );
//                       } else {
//                         return Text("Something went wrong!");
//                       }
//                     } else {
//                       return SizedBox();
//                     }
//                   },
//                 ),
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       Obx(() {
//                         return isLoading.value == true
//                             ? (controller.filterCallBack == false
//                             ? responseNew.response[0].product.length > 0
//                             : controller.productCallBack > 0)
//                             ? Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: Get.height * 0.014,
//                               vertical: Get.height * 0.02),
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child:
//                                 PagewiseGridView<Product>.count(
//                                     key: UniqueKey(),
//                                     pageSize: Utility.perPageSize,
//                                     crossAxisCount: 2,
//                                     mainAxisSpacing:
//                                     Get.height * .01,
//                                     crossAxisSpacing:
//                                     Get.height * .01,
//                                     //childAspectRatio: 0.66,
//                                     childAspectRatio: 0.80,
//                                     loadingBuilder: (_) => Center(
//                                         child:
//                                         circularProgress()),
//                                     itemBuilder: this.buildBody,
//                                     pageFuture: (pageIndex) {
//                                       log("PAGE CALL");
//                                       _fLast.pageIndex =
//                                           pageIndex;
//                                       return requestPagination(
//                                           offset: pageIndex *
//                                               Utility
//                                                   .perPageSize);
//                                     }),
//                               ),
//                             ],
//                           ),
//                         )
//                             : Center(child: Text("No data found!"))
//                             : SizedBox();
//                       }),
//                       Obx(() {
//                         return isLoading.value == true
//                             ? responseNew.response[0].category[0]
//                             .isFilterExits ==
//                             "1"
//                             ? Positioned(
//                           top: -Get.height * 0.032,
//                           right: -Get.height * 0.033,
//                           child: GestureDetector(
//                             onTap: () {
//                               // if (_filterPersonalCallBottomViewModel
//                               //         .apiResponse.status !=
//                               //     Status.COMPLETE) {
//                               //   return;
//                               // }
//                               if (isBottom == true) {
//                                 // setState(() {
//                                 isBottom = false;
//                                 //});
//                                 _filterController.setMainFilterTage(
//                                     saveMainFilter: "Publisher");
//                                 Get.bottomSheet(
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                           topRight:
//                                           Radius.circular(50),
//                                           topLeft:
//                                           Radius.circular(50)),
//
//                                       // BorderRadius.only(topRight: Radius.circular(30)),
//                                     ),
//                                     child: GetBuilder<
//                                         FilterPersonalCallBottomViewModel>(
//                                       builder: (controller) {
//                                         if (controller
//                                             .apiResponse.status ==
//                                             Status.LOADING) {
//                                           return circularProgress();
//                                         }
//                                         if (controller
//                                             .apiResponse.status ==
//                                             Status.ERROR) {
//                                           return serverErrorText();
//                                         }
//                                         if (controller
//                                             .apiResponse.status ==
//                                             Status.COMPLETE) {
//                                           FilterPerosonalCallRespons
//                                           subResponse = controller
//                                               .apiResponse.data;
//                                           _filterController
//                                               .clearSchoolCatProductList();
//                                           _filterController
//                                               .setSchoolCatProductList(
//                                               value: subResponse
//                                                   .response[0]
//                                                   .filters[0]);
//                                           // _filterDataController
//                                           //     .clearFilterMap();
//                                           return FilterScreen(
//                                             response: subResponse,
//                                             callBackFilter:
//                                             refreshCallBack,
//                                           );
//                                         } else {
//                                           return SizedBox();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ).whenComplete(() {
//                                   setState(() {
//                                     isBottom = true;
//                                   });
//                                 });
//                               }
//                             },
//                             child: CircleAvatar(
//                               radius: Get.height * 0.05,
//                               backgroundColor:
//                               ColorPicker.redColorApp,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     right: Get.height * 0.02,
//                                     top: Get.height * 0.022),
//                                 child: IconWidget.filter,
//                               ),
//                             ),
//                           ),
//                         )
//                             : SizedBox()
//                             : SizedBox();
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildBody(context, Product product, index) {
//     print('PRODUCT DATA  ${product.productStockStatus}');
//     return SubCategoryListGrid(
//       product: product,
//     );
//   }
//
//   Widget _buildAppBar(SubCategoryController controller) {
//     return CommonAppBar.commonAppBar(
//         onPress: widget.onPress,
//         appTitle: controller.selectedTitle ?? '',
//         leadingIcon: Icons.arrow_back_rounded);
//   }
// }
