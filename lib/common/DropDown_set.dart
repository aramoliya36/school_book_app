import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_picker.dart';

class DropDownSet extends StatefulWidget {
  @override
  _DropDownSetState createState() => _DropDownSetState();
}

class _DropDownSetState extends State<DropDownSet> {
  String dropdownValue = "1 Set";
  String selectedValueIndex = "Select";
  List<String> companiesList = ['1 Set', '2 Set', '3 Set', '4 Set', '5 Set'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.035,
      width: Get.width * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: Icon(
          Icons.expand_more,
          color: ColorPicker.navyBlue,
        ),
        iconSize: Get.height * 0.03,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            selectedValueIndex = newValue;
          });
        },
        items: companiesList.map((String companiesData) {
          return new DropdownMenuItem<String>(
              value: "$companiesData",
              child: Padding(
                padding: EdgeInsets.only(left: Get.height * 0.006),
                child: new Text(
                  companiesData,
                  style: TextStyle(fontSize: Get.height * 0.017),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
