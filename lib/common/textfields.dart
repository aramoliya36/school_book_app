import 'package:flutter/material.dart';

Widget SimpleTextfield(hintText,
    {TextEditingController controller,
    Function validator,
    TextInputType keyboardType}) {
  if (validator == null) {
    validator = (value) {
      if (value == "" || value == null) {
        return "Please Fill $hintText";
      } else {
        return null;
      }
    };
  }

  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      hintText: hintText,
      errorStyle: TextStyle(
        color: Colors.red,
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
//      suffixIcon: Icon(
//        Icons.remove_red_eye,
//        color: colorPalette.navyBlue,
//      ),
    ),
  );
}

Widget SuffixTextfield({
  String hintText,
  Widget suffixIcon,
  TextEditingController controller,
  bool obscureText,
  Function validator,
  Function onTap,
}) {
  if (validator == null) {
    validator = (value) {
      if (value == "" || value == null) {
        return "Please Fill $hintText";
      } else {
        return null;
      }
    };
  }

  return TextFormField(
    validator: validator,
    onTap: onTap,
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
