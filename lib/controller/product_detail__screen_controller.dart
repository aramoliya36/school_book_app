import 'package:get/get.dart';

class ProductDetailScreenController extends GetxController {
  bool isCheckBox = false;
  double totalPriceOf = 0.0;
  int isChangeIndex = 0;
  int isRelatedChangeIndex = 1;
  int isOrderCount = 0;
  int isOrderCountRelated = 1;
  String currentId;
  String relatedProductId;
  bool isTypeBookSet = false;

  ///s
  List<Map<String, int>> selectProductList = [];
  clearSelectProductList() {
    selectProductList.clear();
    update();
  }

  removeSelectProductList({String key}) {
    int currentIndex =
        selectProductList.indexWhere((e) => e.keys.toList().contains(key));
    print('------------------$key-----------');
    print(
        '----- selectProductList.removeAt-----${selectProductList.indexWhere((e) => e.keys.toList().contains(key))}');
    selectProductList.removeAt(currentIndex);

    update();
    print('remove list id --$selectProductList');
  }

  setAddSelectProductList({
    String id,
    int quantity,
  }) {
    selectProductList.add({id: quantity});
    update();
  }

  setIncrementSelectListProductQInc(
    String id,
    int quantity,
  ) {
    int currentIndex =
        selectProductList.indexWhere((e) => e.keys.toList().contains(id));
    if (selectProductList.isEmpty) {
      selectProductList.add({id: quantity});
      update();
      currentIndex =
          selectProductList.indexWhere((e) => e.keys.toList().contains(id));
      selectProductList[currentIndex][id]++;
    } else if (currentIndex > -1) {
      selectProductList.add({id: quantity});
      update();
      currentIndex =
          selectProductList.indexWhere((e) => e.keys.toList().contains(id));
      selectProductList[currentIndex][id]++;
    } else {
      selectProductList.add({id: quantity});
      update();
      currentIndex =
          selectProductList.indexWhere((e) => e.keys.toList().contains(id));
      selectProductList[currentIndex][id]++;
    }
    update();
  }

  setDecrementSelectListProductQDec(
    String id,
    int quantity,
  ) {
    print('-------------$selectProductList');
    int currentIndex =
        selectProductList.indexWhere((e) => e.keys.toList().contains(id));
    if (quantity > 1) {
      if (selectProductList.isEmpty) {
        selectProductList.add({id: quantity - 1});
        currentIndex =
            selectProductList.indexWhere((e) => e.keys.toList().contains(id));
      } else if (currentIndex > -1) {
        if (selectProductList[currentIndex][id] > 1) {
          selectProductList[currentIndex][id]--;
        }
      } else {
        selectProductList.add({id: quantity - 1});
        currentIndex =
            selectProductList.indexWhere((e) => e.keys.toList().contains(id));
        //selectProductList[currentIndex][id]--;
      }
    } else {
      if (selectProductList.isEmpty) {
        selectProductList.add({id: quantity - 1});
      } else if (currentIndex > -1) {
        if (selectProductList[currentIndex][id] > 1) {
          selectProductList[currentIndex][id]--;
        }
      }
    }

    update();
  }

  removeCartSelectProductList() {}

  setIsSelectBookSet({bool type}) {
    isTypeBookSet = type;
    update();
  }

  setCurrentId({String curentValueId}) {
    currentId = curentValueId;
    update();
  }

  setClearCurrentId() {
    currentId = '';
    update();
  }

  setClearIsOrderCountRelated() {
    isOrderCountRelated = 1;
    update();
  }

  setIncrementOrderCountRelated() {
    isOrderCountRelated++;
    print('----first count---$isOrderCountRelated');

    update();
  }

  setDecrementOrderCountRelated() {
    if (isOrderCountRelated > 0) {
      isOrderCountRelated--;
      update();
    }
  }

  resetOrderCountRelated() {
    isOrderCountRelated = 0;
    update();
  }

  setFirstProductCartValue({int value}) {
    isOrderCount = value;

    update();
  }

  setIncrementIsOrderCount() {
    isOrderCount++;

    update();
  }

  setDecrementIsOrderCount() {
    if (isOrderCount > 0) {
      isOrderCount--;
      update();
    }
  }

  resetOrderCount() {
    isOrderCount = 0;
    update();
  }

  resetTotalPriceOf() {
    totalPriceOf = 0.0;
    update();
  }

  resetRelatedChangeIndex() {
    isRelatedChangeIndex = 0;
    update();
  }

  resetIsChangeIndex() {
    isChangeIndex = 0;
    update();
  }

  setIsChangeIndex({int newValue}) {
    isChangeIndex = newValue;
    update();
  }

  ///product details screen
  setIsRelatedChangeIndex({int newValue}) {
    isRelatedChangeIndex = newValue;
    update();
  }

  setCurrentRelatedId({String curentValueId}) {
    relatedProductId = curentValueId;
    update();
  }

  resetCurrentRelatedId() {
    relatedProductId = '';
    update();
  }

  setTotalPrice({double addValue}) {
    totalPriceOf = addValue;
    update();
  }

  resetCheckBoxValue() {
    isCheckBox = false;
    update();
  }

  setCheckBox({bool currentCheckBoxValue}) {
    isCheckBox = currentCheckBoxValue;
    update();
  }

  List<String> pbdIdList = [];

  setPbdList({String setValueAdd}) {
    pbdIdList.add(setValueAdd);
    update();
  }

  removePbdList({String setValueRemove}) {
    pbdIdList.remove(setValueRemove);
    update();
  }

  clearPbdList() {
    pbdIdList.clear();
    update();
  }
}
