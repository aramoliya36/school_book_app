import 'dart:developer';

import 'package:get/get.dart';

class TableDataController extends GetxController {
  ///is_mandatory table
  RxMap<String, List<Map<String, String>>> isMandatoryTableList =
      <String, List<Map<String, String>>>{}.obs;
  void addIsMandatoryTableValue({String key, String subKey, String price}) {
    final index = isMandatoryTableList[key]
        .indexWhere((element) => element.containsKey(subKey));
    log("INDEX CHANGE $index");

    if (index > -1) {
      isMandatoryTableList[key].removeAt(index);
    } else {
      isMandatoryTableList[key].add({'$subKey': '$price'});
    }

    log("ALL CHECK BOX LIST$isMandatoryTableList");
    update();
  }

  void addIsMandatoryParentCategory(
      {String bookSetName, String productId, String price}) {
    if (isMandatoryTableList.containsKey(bookSetName)) {
      isMandatoryTableList[bookSetName].add({'$productId': '$price'});
    } else {
      isMandatoryTableList.addAll({
        bookSetName: [
          {'$productId': '$price'}
        ]
      });
    }
    update();
  }

  void addAllIsMandatoryBookset(
      {String bookSetName, String pId, String price}) {
    if (isMandatoryTableList.containsKey(bookSetName)) {
      isMandatoryTableList[bookSetName].add({pId: price});
    } else {
      isMandatoryTableList.addAll({
        bookSetName: [
          {pId: price}
        ]
      });
    }
    update();
  }

  RxMap<String, List<String>> priceIsMandatoryAddList =
      <String, List<String>>{}.obs;

  void addIsMandatoryPrice({String bookSetName, String bookSetPrice}) {
    if (priceIsMandatoryAddList.containsKey(bookSetName)) {
      priceIsMandatoryAddList[bookSetName].add(bookSetPrice);
    } else {
      priceIsMandatoryAddList.addAll({
        bookSetName: [bookSetPrice]
      });
    }
    update();
  }

  void clearIsMandatorySubcategory({String bookSetName}) {
    isMandatoryTableList[bookSetName].clear();

    update();
  }

  void removeIsMandatoryPrice({String bookSetName, String bookSetPrice}) {
    priceIsMandatoryAddList.remove(bookSetName);
    update();
  }

  /// type 1,3 category table
  RxMap<String, List<Map<String, String>>> tableMapList =
      <String, List<Map<String, String>>>{}.obs;

  void addTableValue({String key, String subKey, String price}) {
    final index =
        tableMapList[key].indexWhere((element) => element.containsKey(subKey));
    log("INDEX CHANGE $index");

    if (index > -1) {
      tableMapList[key].removeAt(index);
    } else {
      tableMapList[key].add({'$subKey': '$price'});
    }

    log("ALL CHECK BOX LIST$tableMapList");
    update();
  }

  RxList<dynamic> categoryList = [].obs;

  void addParentCategory({String bookSetName, String productId, String price}) {
    if (tableMapList.containsKey(bookSetName)) {
      tableMapList[bookSetName].add({'$productId': '$price'});
    } else {
      tableMapList.addAll({
        bookSetName: [
          {'$productId': '$price'}
        ]
      });
    }
    update();
  }

  void clearSubcategory({String bookSetName}) {
    tableMapList[bookSetName].clear();

    update();
  }

  /// price logic

  RxMap<String, List<String>> priceAddList = <String, List<String>>{}.obs;

  void addPrice({String bookSetName, String bookSetPrice}) {
    if (priceAddList.containsKey(bookSetName)) {
      priceAddList[bookSetName].add(bookSetPrice);
    } else {
      priceAddList.addAll({
        bookSetName: [bookSetPrice]
      });
    }
    update();
  }

  void removePrice({String bookSetName, String bookSetPrice}) {
    priceAddList.remove(bookSetName);
    update();
  }

  RxMap<String, List<Map<String, String>>> bookSetPriceOf =
      <String, List<Map<String, String>>>{}.obs;

  void addAllBookset({String bookSetName, String pId, String price}) {
    if (tableMapList.containsKey(bookSetName)) {
      tableMapList[bookSetName].add({pId: price});
    } else {
      tableMapList.addAll({
        bookSetName: [
          {pId: price}
        ]
      });
    }
    update();
  }

  void allListClear() {
    tableMapList.clear();
    update();
  }
}
