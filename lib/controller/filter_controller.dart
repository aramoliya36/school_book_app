import 'package:get/get.dart';

import '../model/responseModel/filter_personal_call_response_model.dart';

class FilterController extends GetxController {
  List<String> filterData = [];
  String mainFilterTag = '';
  setMainFilterTage({String saveMainFilter}) {
    mainFilterTag = saveMainFilter;
    update();
  }

  setFilterData({String value}) {
    filterData.add(value);
    update();
  }

  clearFilterList() {
    filterData.clear();
    update();
  }

  RxList<Filter> schoolCatFilterList = <Filter>[].obs;
  void setSchoolCatProductList({Filter value}) {
    schoolCatFilterList.add(value);
    update();
  }

  void clearSchoolCatProductList() {
    schoolCatFilterList.clear();
    update();
  }
}
