import 'package:flutter/material.dart';
import 'package:skoolmonk/common/textStyle.dart';

Padding availableProduct() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Text(
          "Available Products",
          style: CommonTextStyle.availableProductStyle,
        ),
        Spacer(),
        Text(
          "All",
          style: CommonTextStyle.productTitle,
        ),
        Icon(Icons.expand_more)
      ],
    ),
  );
}
