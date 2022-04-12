// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  CartResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.cart,
    this.cartInfo,
  });

  List<Cart> cart;
  List<CartInfo> cartInfo;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        cartInfo: List<CartInfo>.from(
            json["cart_info"].map((x) => CartInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "cart_info": List<dynamic>.from(cartInfo.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    this.cartId,
    this.productType,
    this.additionalSet,
    this.variation,
    this.productId,
    this.productName,
    this.productSlug,
    this.productImg,
    this.productPrice,
    this.qty,
    this.productDiscount,
    this.productSalePrice,
    this.productPriceWithoutTax,
    this.productGst,
    this.productGstQtyTotal,
    this.productFinalTotal,
    this.productSavingTotal,
    this.productStockStatus,
    this.studentName,
    this.studentRoll,
    this.productStatusError,
    this.productStatusErrorMsg,
    this.pvsmId,
    this.variationsOptionsName,
    this.variationsDetails,
    this.additionalSetIds,
    this.additionalSetDetails,
    this.pbdId,
    this.booksetOptionsName,
    this.booksetDetails,
  });

  String cartId;
  String productType;
  String additionalSet;
  String variation;
  String productId;
  String productName;
  String productSlug;
  String productImg;
  String productPrice;
  String qty;
  String productDiscount;
  String productSalePrice;
  String productPriceWithoutTax;
  String productGst;
  String productGstQtyTotal;
  String productFinalTotal;
  String productSavingTotal;
  ProductStockStatus productStockStatus;
  String studentName;
  String studentRoll;
  String productStatusError;
  String productStatusErrorMsg;
  String pvsmId;
  String variationsOptionsName;
  List<dynamic> variationsDetails;
  String additionalSetIds;
  List<dynamic> additionalSetDetails;
  String pbdId;
  String booksetOptionsName;
  List<BooksetDetail> booksetDetails;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cart_id"],
        productType: json["product_type"],
        additionalSet: json["additional_set"],
        variation: json["variation"],
        productId: json["product_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        productImg: json["product_img"],
        productPrice: json["product_price"],
        qty: json["qty"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productPriceWithoutTax: json["product_price_without_tax"],
        productGst: json["product_gst"],
        productGstQtyTotal: json["product_gst_qty_total"],
        productFinalTotal: json["product_final_total"],
        productSavingTotal: json["product_saving_total"],
        productStockStatus:
            productStockStatusValues.map[json["product_stock_status"]],
        studentName: json["student_name"],
        studentRoll: json["student_roll"],
        productStatusError: json["product_status_error"],
        productStatusErrorMsg: json["product_status_error_msg"],
        pvsmId: json["pvsm_id"],
        variationsOptionsName: json["variations_options_name"],
        variationsDetails:
            List<dynamic>.from(json["variations_details"].map((x) => x)),
        additionalSetIds: json["additional_set_ids"],
        additionalSetDetails:
            List<dynamic>.from(json["additional_set_details"].map((x) => x)),
        pbdId: json["pbd_id"],
        booksetOptionsName: json["bookset_options_name"],
        booksetDetails: List<BooksetDetail>.from(
            json["bookset_details"].map((x) => BooksetDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "product_type": productType,
        "additional_set": additionalSet,
        "variation": variation,
        "product_id": productId,
        "product_name": productName,
        "product_slug": productSlug,
        "product_img": productImg,
        "product_price": productPrice,
        "qty": qty,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_price_without_tax": productPriceWithoutTax,
        "product_gst": productGst,
        "product_gst_qty_total": productGstQtyTotal,
        "product_final_total": productFinalTotal,
        "product_saving_total": productSavingTotal,
        "product_stock_status":
            productStockStatusValues.reverse[productStockStatus],
        "student_name": studentName,
        "student_roll": studentRoll,
        "product_status_error": productStatusError,
        "product_status_error_msg": productStatusErrorMsg,
        "pvsm_id": pvsmId,
        "variations_options_name": variationsOptionsName,
        "variations_details":
            List<dynamic>.from(variationsDetails.map((x) => x)),
        "additional_set_ids": additionalSetIds,
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "pbd_id": pbdId,
        "bookset_options_name": booksetOptionsName,
        "bookset_details":
            List<dynamic>.from(booksetDetails.map((x) => x.toJson())),
      };
}

class BooksetDetail {
  BooksetDetail({
    this.pbdId,
    this.productId,
    this.booksetId,
    this.booksetName,
    this.isMandatory,
    this.totalBooksetPrice,
    this.totalBooksetSalePrice,
    this.productInfo,
  });

  String pbdId;
  String productId;
  String booksetId;
  String booksetName;
  String isMandatory;
  String totalBooksetPrice;
  String totalBooksetSalePrice;
  List<ProductInfo> productInfo;

  factory BooksetDetail.fromJson(Map<String, dynamic> json) => BooksetDetail(
        pbdId: json["pbd_id"],
        productId: json["product_id"],
        booksetId: json["bookset_id"],
        booksetName: json["bookset_name"],
        isMandatory: json["is_mandatory"],
        totalBooksetPrice: json["total_bookset_price"],
        totalBooksetSalePrice: json["total_bookset_sale_price"],
        productInfo: List<ProductInfo>.from(
            json["product_info"].map((x) => ProductInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pbd_id": pbdId,
        "product_id": productId,
        "bookset_id": booksetId,
        "bookset_name": booksetName,
        "is_mandatory": isMandatory,
        "total_bookset_price": totalBooksetPrice,
        "total_bookset_sale_price": totalBooksetSalePrice,
        "product_info": List<dynamic>.from(productInfo.map((x) => x.toJson())),
      };
}

class ProductInfo {
  ProductInfo({
    this.productId,
    this.productSlug,
    this.vendorSlug,
    this.categoryName,
    this.productName,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.quantity,
    this.productStockStatus,
  });

  String productId;
  String productSlug;
  VendorSlug vendorSlug;
  CategoryName categoryName;
  String productName;
  String productPrice;
  ProductDiscount productDiscount;
  String productSalePrice;
  String quantity;
  ProductStockStatus productStockStatus;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: vendorSlugValues.map[json["vendor_slug"]],
        categoryName: categoryNameValues.map[json["category_name"]],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDiscount: productDiscountValues.map[json["product_discount"]],
        productSalePrice: json["product_sale_price"],
        quantity: json["quantity"],
        productStockStatus:
            productStockStatusValues.map[json["product_stock_status"]],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlugValues.reverse[vendorSlug],
        "category_name": categoryNameValues.reverse[categoryName],
        "product_name": productName,
        "product_price": productPrice,
        "product_discount": productDiscountValues.reverse[productDiscount],
        "product_sale_price": productSalePrice,
        "quantity": quantity,
        "product_stock_status":
            productStockStatusValues.reverse[productStockStatus],
      };
}

enum CategoryName { CBSE_BOOKS, PENS, SCHOOL_BAG }

final categoryNameValues = EnumValues({
  "CBSE Books": CategoryName.CBSE_BOOKS,
  "Pens": CategoryName.PENS,
  "School Bag": CategoryName.SCHOOL_BAG
});

enum ProductDiscount { THE_10, THE_175, THE_20 }

final productDiscountValues = EnumValues({
  "10%": ProductDiscount.THE_10,
  "17.5%": ProductDiscount.THE_175,
  "20%": ProductDiscount.THE_20
});

enum ProductStockStatus { IN }

final productStockStatusValues = EnumValues({"IN": ProductStockStatus.IN});

enum VendorSlug { ABC_SKOOLMONK }

final vendorSlugValues =
    EnumValues({"abc-skoolmonk": VendorSlug.ABC_SKOOLMONK});

class CartInfo {
  CartInfo({
    this.isCouponCodeApplicable,
    this.isCouponCodeInsert,
    this.couponCodeMsg,
    this.couponCodeStatus,
    this.ccCcId,
    this.ccCouponCode,
    this.ccDiscount,
    this.ccCouponFor,
    this.ccCouponForId,
    this.ccDiscountType,
    this.ccMinPrice,
    this.ccStartDate,
    this.ccEndDate,
    this.couponDiscountPrice,
    this.couponDiscountMinusPrice,
    this.finalPrice,
    this.finalTaxPrice,
    this.finalSavingPrice,
    this.finalDeliveryPrice,
    this.finalTotalPrice,
    this.crFinalPrice,
    this.crFinalTaxPrice,
    this.crFinalSavingPrice,
    this.crFinalCartPrice,
    this.crFinalDeliveryPrice,
    this.crFinalTotalPrice,
    this.hideCheckoutButton,
    this.userAddressSelected,
  });

  String isCouponCodeApplicable;
  String isCouponCodeInsert;
  String couponCodeMsg;
  String couponCodeStatus;
  String ccCcId;
  String ccCouponCode;
  String ccDiscount;
  String ccCouponFor;
  String ccCouponForId;
  String ccDiscountType;
  String ccMinPrice;
  String ccStartDate;
  String ccEndDate;
  String couponDiscountPrice;
  String couponDiscountMinusPrice;
  String finalPrice;
  String finalTaxPrice;
  String finalSavingPrice;
  String finalDeliveryPrice;
  String finalTotalPrice;
  String crFinalPrice;
  String crFinalTaxPrice;
  String crFinalSavingPrice;
  String crFinalCartPrice;
  String crFinalDeliveryPrice;
  String crFinalTotalPrice;
  String hideCheckoutButton;
  String userAddressSelected;

  factory CartInfo.fromJson(Map<String, dynamic> json) => CartInfo(
        isCouponCodeApplicable: json["is_coupon_code_applicable"],
        isCouponCodeInsert: json["is_coupon_code_insert"],
        couponCodeMsg: json["coupon_code_msg"],
        couponCodeStatus: json["coupon_code_status"],
        ccCcId: json["cc_cc_id"],
        ccCouponCode: json["cc_coupon_code"],
        ccDiscount: json["cc_discount"],
        ccCouponFor: json["cc_coupon_for"],
        ccCouponForId: json["cc_coupon_for_id"],
        ccDiscountType: json["cc_discount_type"],
        ccMinPrice: json["cc_min_price"],
        ccStartDate: json["cc_start_date"],
        ccEndDate: json["cc_end_date"],
        couponDiscountPrice: json["coupon_discount_price"],
        couponDiscountMinusPrice: json["coupon_discount_minus_price"],
        finalPrice: json["final_price"],
        finalTaxPrice: json["final_tax_price"],
        finalSavingPrice: json["final_saving_price"],
        finalDeliveryPrice: json["final_delivery_price"],
        finalTotalPrice: json["final_total_price"],
        crFinalPrice: json["cr_final_price"],
        crFinalTaxPrice: json["cr_final_tax_price"],
        crFinalSavingPrice: json["cr_final_saving_price"],
        crFinalCartPrice: json["cr_final_cart_price"],
        crFinalDeliveryPrice: json["cr_final_delivery_price"],
        crFinalTotalPrice: json["cr_final_total_price"],
        hideCheckoutButton: json["hide_checkout_button"],
        userAddressSelected: json["user_address_selected"],
      );

  Map<String, dynamic> toJson() => {
        "is_coupon_code_applicable": isCouponCodeApplicable,
        "is_coupon_code_insert": isCouponCodeInsert,
        "coupon_code_msg": couponCodeMsg,
        "coupon_code_status": couponCodeStatus,
        "cc_cc_id": ccCcId,
        "cc_coupon_code": ccCouponCode,
        "cc_discount": ccDiscount,
        "cc_coupon_for": ccCouponFor,
        "cc_coupon_for_id": ccCouponForId,
        "cc_discount_type": ccDiscountType,
        "cc_min_price": ccMinPrice,
        "cc_start_date": ccStartDate,
        "cc_end_date": ccEndDate,
        "coupon_discount_price": couponDiscountPrice,
        "coupon_discount_minus_price": couponDiscountMinusPrice,
        "final_price": finalPrice,
        "final_tax_price": finalTaxPrice,
        "final_saving_price": finalSavingPrice,
        "final_delivery_price": finalDeliveryPrice,
        "final_total_price": finalTotalPrice,
        "cr_final_price": crFinalPrice,
        "cr_final_tax_price": crFinalTaxPrice,
        "cr_final_saving_price": crFinalSavingPrice,
        "cr_final_cart_price": crFinalCartPrice,
        "cr_final_delivery_price": crFinalDeliveryPrice,
        "cr_final_total_price": crFinalTotalPrice,
        "hide_checkout_button": hideCheckoutButton,
        "user_address_selected": userAddressSelected,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
