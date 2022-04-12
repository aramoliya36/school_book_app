import 'dart:developer';
import 'package:get/get.dart';

class SchoolController extends GetxController {
  RxString _selectedTitle = ''.obs;
  RxString _selectedString = ''.obs;

  RxString _selectedPinCodeForSchool = ''.obs;
  RxString _selectedSchoolSlug = ''.obs;

  RxBool _isSearchSchoolTabSelected = false.obs;
  RxBool _isFindSchoolByLocationSelected = false.obs;

  RxInt _selectedCityIdForSchool = 0.obs;
  RxInt _selectedStateIdForSchool = 0.obs;
  RxInt _selectedCountryIdForSchool = 0.obs;

  RxList _schoolsToFilter = [].obs;
  RxInt _selectedCountryIndexForSchool = 0.obs;
  RxInt _selectedCityIndexForSchool = 0.obs;

  RxInt get selectedCityIndexForSchool => _selectedCityIndexForSchool;

  void setSelectedCityIndexForSchool(int value) {
    _selectedCityIndexForSchool.value = value;
    update();
  }

  RxInt get selectedCountryIndexForSchool => _selectedCountryIndexForSchool;

  void setSelectedCountryIndexForSchool(int value) {
    _selectedCountryIndexForSchool.value = value;
    update();
  }

  RxString get selectedString => _selectedString;

  set setSelectedString(String value) {
    _selectedString.value = value;
    update();
  }

  RxString get selectedSchoolSlug => _selectedSchoolSlug;

  void setSelectedSchoolSlug(String value) {
    _selectedSchoolSlug.value = value;
    update();
  }

  RxInt get selectedCountryIdForSchool => _selectedCountryIdForSchool;

  RxString get selectedPinCodeForSchool => _selectedPinCodeForSchool;

  void setSelectedPinCodeForSchool(String value) {
    _selectedPinCodeForSchool.value = value;
    update();
  }

  void setSelectedCountryIdForSchool(int value) {
    _selectedCountryIdForSchool.value = value;
    update();
  }

  RxInt get selectedStateIdForSchool => _selectedStateIdForSchool;

  void setSelectedStateIdForSchool(int value) {
    _selectedStateIdForSchool.value = value;
    update();
  }

  RxInt get selectedCityIdForSchool => _selectedCityIdForSchool;

  void setSelectedCityIdForSchool(int value) {
    _selectedCityIdForSchool.value = value;
    update();
  }

  RxBool get isFindSchoolByLocationSelected => _isFindSchoolByLocationSelected;

  void setFindSchoolByLocationSelected(bool value) {
    _isFindSchoolByLocationSelected.value = value;
    update();
  }

  List get schoolsToFilter => _schoolsToFilter;

  set setSchoolsToFilter(List value) {
    _schoolsToFilter = value;
    update();
  }

  void schoolsToFilterAddSingleSchool(dynamic school) {
    _schoolsToFilter.add(school);
    update();
  }

  RxBool get isSearchSchoolTabSelected => _isSearchSchoolTabSelected;

  void setSearchSchoolTabSelected(bool value) {
    _isSearchSchoolTabSelected.value = value;
    update();
  }

  RxString get selectedTitle => _selectedTitle;
  String schoolSlugName;
  schoolSlugFindName({String schoolSlugSet}) {
    schoolSlugName = schoolSlugSet;
    update();
  }

  void setSelectedTitle(String value) {
    _selectedTitle = value.obs;
    log('category=>$_selectedTitle');
    update();
  }
}
