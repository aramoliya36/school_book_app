import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/common/shared_preference.dart';
import 'package:skoolmonk/common/utility.dart';
import 'package:skoolmonk/controller/sub_category_controller.dart';
import 'package:skoolmonk/model/reqestModel/mainCategoriesSubcategoriesProductFilter_reqest.dart';
import 'package:skoolmonk/model/responseModel/MainCategoriesSubcategoriesProductFilterResponse_model.dart';
import 'package:skoolmonk/viewModel/mainCategoriesSubcategoriesProductFilter_view_model.dart';

class SubCategoryHeader extends StatefulWidget {
  final MainCategoriesSubcategoriesProductFilterResponse response;

  const SubCategoryHeader({Key key, this.response}) : super(key: key);
  @override
  _SubCategoryHeaderState createState() => _SubCategoryHeaderState();
}

class _SubCategoryHeaderState extends State<SubCategoryHeader> {
  MainCategoriesSubcategoriesProductFilterRequest _user =
      MainCategoriesSubcategoriesProductFilterRequest();
  MainCategoriesSubcategoriesProductFilterViewModel _filterViewModel =
      Get.find();
  SubCategoryController subCategoryController = Get.find();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.055,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
          itemCount: widget.response.response[0].subCategory.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var _respo = widget.response.response[0];
            return Padding(
              padding: EdgeInsets.all(Get.height * 0.01),
              child: GestureDetector(
                onTap: () async {
                  _filterViewModel.updateSet();
                  subCategoryController.setCatSlugFilter(
                      slugName: _respo.subCategory[index].catSlug);
                  _user.userId = PreferenceManager.getTokenId() ?? '0';
                  _user.catSlug = _respo.subCategory[index].catSlug;

                  _user.page = '0';
                  _user.count = 'NO';
                  _user.perpage = Utility.perPageSize.toString();
                  _user.filter = '';
                  await _filterViewModel
                      .mainCategoriesSubcategoriesProductFilterViewModel(
                          model: _user);
                  MainCategoriesSubcategoriesProductFilterResponse
                      _produtFound = _filterViewModel.apiResponse.data;
                  subCategoryController.setHeader(
                      value: _produtFound.response[0].subCategory.length);
                  subCategoryController.setListEmptyProduct(
                      value: _produtFound.response[0].product.length);

                  subCategoryController.setFilterProduct(
                      value: int.parse(
                          _produtFound.response[0].category[0].isFilterExits));
                  // setState(() {
                  //   currentIndex = index;
                  // });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: _respo.subCategory[index].catSlug ==
                              subCategoryController.catSlugFilter
                          ? ColorPicker.navyBlue
                          : Colors.white,
                      border: Border.all(
                          color: _respo.subCategory[index].catSlug ==
                                  subCategoryController.catSlugFilter
                              ? ColorPicker.navyBlue
                              : Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.005,
                        horizontal: Get.height * 0.005),
                    child: Center(
                        child: Text(
                      '${widget.response.response[0].subCategory[index].categoryName ?? ''}',
                      style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: _respo.subCategory[index].catSlug ==
                                  subCategoryController.catSlugFilter
                              ? Colors.white
                              : Colors.black),
                    )),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
