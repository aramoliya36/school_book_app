import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skoolmonk/common/color_picker.dart';
import 'package:skoolmonk/model/responseModel/filter_personal_call_response_model.dart';
import 'package:skoolmonk/screens/filterScreen/widget/filter_body.dart';

class FilterCheckBox extends StatefulWidget {
  final FilterPerosonalCallRespons respons;

  const FilterCheckBox({this.respons});
  @override
  _FilterCheckBoxState createState() => _FilterCheckBoxState();
}

class _FilterCheckBoxState extends State<FilterCheckBox> {
  FilterDataList _filterDataList = Get.put(FilterDataList());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: Get.height * 0.8,
          child: GetBuilder<FilterDataList>(
            builder: (controller) {
              print("init");

              return Container(
                height: Get.height * 0.8,
                //color: Colors.deepOrange,
                child: ListView.builder(
                  itemCount: widget.respons.response[0].filters.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListView.builder(
                      itemCount: widget
                          .respons.response[0].filters[index].filterData.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, subIndex) {
                        return SizedBox(
                          height: Get.height * 0.05,
                          child: new CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: new Text(
                              widget.respons.response[0].filters[index]
                                  .filterData[subIndex].filterName,
                              style: TextStyle(fontSize: Get.height * 0.02),
                            ),
                            value: false,
                            contentPadding: EdgeInsets.zero,
                            activeColor: ColorPicker.navyBlue,
                            checkColor: Colors.white,
                            onChanged: (bool value) {
                              setState(() {
                                // selectedFilterData[key] = value;
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          )),
    );
  }
}
