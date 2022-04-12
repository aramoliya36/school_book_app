// To parse this JSON data, do
//
//     final purchaseHistoryByOrderResponse = purchaseHistoryByOrderResponseFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryByOrderResponse purchaseHistoryByOrderResponseFromJson(
        String str) =>
    PurchaseHistoryByOrderResponse.fromJson(json.decode(str));

String purchaseHistoryByOrderResponseToJson(
        PurchaseHistoryByOrderResponse data) =>
    json.encode(data.toJson());

class PurchaseHistoryByOrderResponse {
  PurchaseHistoryByOrderResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory PurchaseHistoryByOrderResponse.fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryByOrderResponse(
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
    this.order,
    this.userDeliveryAddress,
    this.orderData,
    this.orderSummary,
  });

  List<Order> order;
  List<UserDeliveryAddress> userDeliveryAddress;
  List<OrderDatum> orderData;
  List<OrderSummary> orderSummary;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
        userDeliveryAddress: List<UserDeliveryAddress>.from(
            json["user_delivery_address"]
                .map((x) => UserDeliveryAddress.fromJson(x))),
        orderData: List<OrderDatum>.from(
            json["order_data"].map((x) => OrderDatum.fromJson(x))),
        orderSummary: List<OrderSummary>.from(
            json["order_summary"].map((x) => OrderSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "user_delivery_address":
            List<dynamic>.from(userDeliveryAddress.map((x) => x.toJson())),
        "order_data": List<dynamic>.from(orderData.map((x) => x.toJson())),
        "order_summary":
            List<dynamic>.from(orderSummary.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.orderNo,
    this.userId,
    this.paymentMethod,
    this.orderTotalCost,
    this.orderDateTime,
    this.isPaymentDone,
    this.orderCompleted,
    this.orderStatus,
    this.orderMsgShow,
    this.orderMsg,
    this.userMetaId,
  });

  String orderNo;
  String userId;
  String paymentMethod;
  String orderTotalCost;
  DateTime orderDateTime;
  String isPaymentDone;
  String orderCompleted;
  String orderStatus;
  String orderMsgShow;
  String orderMsg;
  String userMetaId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderNo: json["order_no"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        orderTotalCost: json["order_total_cost"],
        orderDateTime: DateTime.parse(json["order_date_time"]),
        isPaymentDone: json["is_payment_done"],
        orderCompleted: json["order_completed"],
        orderStatus: json["order_status"],
        orderMsgShow: json["order_msg_show"],
        orderMsg: json["order_msg"],
        userMetaId: json["user_meta_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "user_id": userId,
        "payment_method": paymentMethod,
        "order_total_cost": orderTotalCost,
        "order_date_time": orderDateTime.toIso8601String(),
        "is_payment_done": isPaymentDone,
        "order_completed": orderCompleted,
        "order_status": orderStatus,
        "order_msg_show": orderMsgShow,
        "order_msg": orderMsg,
        "user_meta_id": userMetaId,
      };
}

class OrderDatum {
  OrderDatum({
    this.orderNo,
    this.subOrderNo,
    this.isInvoiceMade,
    this.invoiceLink,
    this.isCancelAvailable,
    this.orderCancelBtn,
    this.orderReqCancelBtn,
    this.orderCancelDataShow,
    this.orderCancelDataTitle,
    this.orderCancelData,
    this.orderCancelDataHtml,
    this.showTrackDataShow,
    this.showTrackDataTitle,
    this.showTrackData,
    this.showTrackDataHtml,
    this.orderDetail,
  });

  String orderNo;
  String subOrderNo;
  String isInvoiceMade;
  String invoiceLink;
  String isCancelAvailable;
  String orderCancelBtn;
  String orderReqCancelBtn;
  String orderCancelDataShow;
  String orderCancelDataTitle;
  List<Datum> orderCancelData;
  String orderCancelDataHtml;
  String showTrackDataShow;
  String showTrackDataTitle;
  List<Datum> showTrackData;
  String showTrackDataHtml;
  List<OrderDetail> orderDetail;

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        orderNo: json["order_no"],
        subOrderNo: json["sub_order_no"],
        isInvoiceMade: json["is_invoice_made"],
        invoiceLink: json["invoice_link"],
        isCancelAvailable: json["is_cancel_available"],
        orderCancelBtn: json["order_cancel_btn"],
        orderReqCancelBtn: json["order_req_cancel_btn"],
        orderCancelDataShow: json["order_cancel_data_show"],
        orderCancelDataTitle: json["order_cancel_data_title"],
        orderCancelData: List<Datum>.from(
            json["order_cancel_data"].map((x) => Datum.fromJson(x))),
        orderCancelDataHtml: json["order_cancel_data_html"],
        showTrackDataShow: json["show_track_data_show"],
        showTrackDataTitle: json["show_track_data_title"],
        showTrackData: List<Datum>.from(
            json["show_track_data"].map((x) => Datum.fromJson(x))),
        showTrackDataHtml: json["show_track_data_html"],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "sub_order_no": subOrderNo,
        "is_invoice_made": isInvoiceMade,
        "invoice_link": invoiceLink,
        "is_cancel_available": isCancelAvailable,
        "order_cancel_btn": orderCancelBtn,
        "order_req_cancel_btn": orderReqCancelBtn,
        "order_cancel_data_show": orderCancelDataShow,
        "order_cancel_data_title": orderCancelDataTitle,
        "order_cancel_data":
            List<dynamic>.from(orderCancelData.map((x) => x.toJson())),
        "order_cancel_data_html": orderCancelDataHtml,
        "show_track_data_show": showTrackDataShow,
        "show_track_data_title": showTrackDataTitle,
        "show_track_data":
            List<dynamic>.from(showTrackData.map((x) => x.toJson())),
        "show_track_data_html": showTrackDataHtml,
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.title,
    this.body,
    this.dateTime,
    this.isActive,
    this.color,
  });

  String title;
  String body;
  String dateTime;
  String isActive;
  Color color;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        body: json["body"],
        dateTime: json["date_time"],
        isActive: json["is_active"],
        color: colorValues.map[json["color"]],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": bodyValues.reverse[body],
        "date_time": dateTime,
        "is_active": isActive,
        "color": colorValues.reverse[color],
      };
}

enum Body {
  EMPTY,
  WRONG_ITEM_WAS_SENT,
  THE_79566186435132168465123,
  THE_89841891561659684616
}

final bodyValues = EnumValues({
  "": Body.EMPTY,
  "79566186435132168465123": Body.THE_79566186435132168465123,
  "89841891561659684616": Body.THE_89841891561659684616,
  "Wrong item was sent": Body.WRONG_ITEM_WAS_SENT
});

enum Color { D6_D6_D6, THE_00_AC69 }

final colorValues =
    EnumValues({"#d6d6d6": Color.D6_D6_D6, "#00ac69": Color.THE_00_AC69});

class OrderDetail {
  OrderDetail({
    this.productId,
    this.productSlug,
    this.productName,
    this.productQty,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productGst,
    this.vendorSlug,
    this.schoolSlug,
    this.type,
    this.productType,
    this.variation,
    this.additionalSet,
    this.categoryName,
    this.productImg,
    this.vendorCompanyName,
    this.studentName,
    this.studentRoll,
    this.productIsReturnable,
    this.productReturnDays,
    this.productIsReplaceable,
    this.productReplaceDays,
    this.returnProductOn,
    this.returnDaysAvailableTillDate,
    this.replaceProductOn,
    this.replaceDaysAvailableTillDate,
    this.userReturnReqOn,
    this.userReplaceReqOn,
    this.productReturn,
    this.productReplace,
    this.orderReturnBtn,
    this.orderReplaceBtn,
    this.orderReplaceWebBtn,
    this.orderReturnWebBtn,
    this.orderReturnLinkShow,
    this.orderReplaceLinkShow,
    this.orderReturnLinkShowError,
    this.orderReplaceLinkShowError,
    this.orderReturnLink,
    this.orderReplaceLink,
  });

  String productId;
  String productSlug;
  String productName;
  String productQty;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productGst;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String additionalSet;
  String categoryName;
  String productImg;
  String vendorCompanyName;
  String studentName;
  String studentRoll;
  String productIsReturnable;
  String productReturnDays;
  String productIsReplaceable;
  String productReplaceDays;
  String returnProductOn;
  String returnDaysAvailableTillDate;
  String replaceProductOn;
  String replaceDaysAvailableTillDate;
  String userReturnReqOn;
  String userReplaceReqOn;
  List<ProductRe> productReturn;
  List<ProductRe> productReplace;
  String orderReturnBtn;
  String orderReplaceBtn;
  String orderReplaceWebBtn;
  String orderReturnWebBtn;
  String orderReturnLinkShow;
  String orderReplaceLinkShow;
  String orderReturnLinkShowError;
  String orderReplaceLinkShowError;
  String orderReturnLink;
  String orderReplaceLink;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        productName: json["product_name"],
        productQty: json["product_qty"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productGst: json["product_gst"],
        vendorSlug: json["vendor_slug"],
        schoolSlug: json["school_slug"],
        type: json["type"],
        productType: json["product_type"],
        variation: json["variation"],
        additionalSet: json["additional_set"],
        categoryName: json["category_name"],
        productImg: json["product_img"],
        vendorCompanyName: json["vendor_company_name"],
        studentName: json["student_name"],
        studentRoll: json["student_roll"],
        productIsReturnable: json["product_is_returnable"],
        productReturnDays: json["product_return_days"],
        productIsReplaceable: json["product_is_replaceable"],
        productReplaceDays: json["product_replace_days"],
        returnProductOn: json["return_product_on"],
        returnDaysAvailableTillDate: json["return_days_available_till_date"],
        replaceProductOn: json["replace_product_on"],
        replaceDaysAvailableTillDate: json["replace_days_available_till_date"],
        userReturnReqOn: json["user_return_req_on"],
        userReplaceReqOn: json["user_replace_req_on"],
        productReturn: List<ProductRe>.from(
            json["product_return"].map((x) => ProductRe.fromJson(x))),
        productReplace: List<ProductRe>.from(
            json["product_replace"].map((x) => ProductRe.fromJson(x))),
        orderReturnBtn: json["order_return_btn"],
        orderReplaceBtn: json["order_replace_btn"],
        orderReplaceWebBtn: json["order_replace_web_btn"],
        orderReturnWebBtn: json["order_return_web_btn"],
        orderReturnLinkShow: json["order_return_link_show"],
        orderReplaceLinkShow: json["order_replace_link_show"],
        orderReturnLinkShowError: json["order_return_link_show_error"],
        orderReplaceLinkShowError: json["order_replace_link_show_error"],
        orderReturnLink: json["order_return_link"],
        orderReplaceLink: json["order_replace_link"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "product_name": productName,
        "product_qty": productQty,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_gst": productGst,
        "vendor_slug": vendorSlug,
        "school_slug": schoolSlug,
        "type": type,
        "product_type": productType,
        "variation": variation,
        "additional_set": additionalSet,
        "category_name": categoryName,
        "product_img": productImg,
        "vendor_company_name": vendorCompanyName,
        "student_name": studentName,
        "student_roll": studentRoll,
        "product_is_returnable": productIsReturnable,
        "product_return_days": productReturnDays,
        "product_is_replaceable": productIsReplaceable,
        "product_replace_days": productReplaceDays,
        "return_product_on": returnProductOn,
        "return_days_available_till_date": returnDaysAvailableTillDate,
        "replace_product_on": replaceProductOn,
        "replace_days_available_till_date": replaceDaysAvailableTillDate,
        "user_return_req_on": userReturnReqOn,
        "user_replace_req_on": userReplaceReqOn,
        "product_return":
            List<dynamic>.from(productReturn.map((x) => x.toJson())),
        "product_replace":
            List<dynamic>.from(productReplace.map((x) => x.toJson())),
        "order_return_btn": orderReturnBtn,
        "order_replace_btn": orderReplaceBtn,
        "order_replace_web_btn": orderReplaceWebBtn,
        "order_return_web_btn": orderReturnWebBtn,
        "order_return_link_show": orderReturnLinkShow,
        "order_replace_link_show": orderReplaceLinkShow,
        "order_return_link_show_error": orderReturnLinkShowError,
        "order_replace_link_show_error": orderReplaceLinkShowError,
        "order_return_link": orderReturnLink,
        "order_replace_link": orderReplaceLink,
      };
}

class ProductRe {
  ProductRe({
    this.oprrId,
    this.userId,
    this.orderNo,
    this.vendorId,
    this.productId,
    this.qty,
    this.type,
    this.userReq,
    this.userReqDate,
    this.reason,
    this.comment,
    this.requestStatus,
    this.files,
    this.productReturnDataShow,
    this.productReturnDataTitle,
    this.productReturnData,
    this.productReturnDataHtml,
  });

  String oprrId;
  String userId;
  String orderNo;
  String vendorId;
  String productId;
  String qty;
  String type;
  String userReq;
  DateTime userReqDate;
  String reason;
  String comment;
  String requestStatus;
  List<FileElement> files;
  String productReturnDataShow;
  String productReturnDataTitle;
  List<Datum> productReturnData;
  String productReturnDataHtml;

  factory ProductRe.fromJson(Map<String, dynamic> json) => ProductRe(
        oprrId: json["oprr_id"],
        userId: json["user_id"],
        orderNo: json["order_no"],
        vendorId: json["vendor_id"],
        productId: json["product_id"],
        qty: json["qty"],
        type: json["type"],
        userReq: json["user_req"],
        userReqDate: DateTime.parse(json["user_req_date"]),
        reason: json["reason"],
        comment: json["comment"],
        requestStatus: json["request_status"],
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        productReturnDataShow: json["product_return_data_show"],
        productReturnDataTitle: json["product_return_data_title"],
        productReturnData: List<Datum>.from(
            json["product_return_data"].map((x) => Datum.fromJson(x))),
        productReturnDataHtml: json["product_return_data_html"],
      );

  Map<String, dynamic> toJson() => {
        "oprr_id": oprrId,
        "user_id": userId,
        "order_no": orderNo,
        "vendor_id": vendorId,
        "product_id": productId,
        "qty": qty,
        "type": type,
        "user_req": userReq,
        "user_req_date": userReqDate.toIso8601String(),
        "reason": bodyValues.reverse[reason],
        "comment": comment,
        "request_status": requestStatus,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "product_return_data_show": productReturnDataShow,
        "product_return_data_title": productReturnDataTitle,
        "product_return_data":
            List<dynamic>.from(productReturnData.map((x) => x.toJson())),
        "product_return_data_html": productReturnDataHtml,
      };
}

class FileElement {
  FileElement({
    this.img,
  });

  String img;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
      };
}

class OrderSummary {
  OrderSummary({
    this.finalPrice,
    this.finalTaxPrice,
    this.finalTotalSaving,
    this.finalDeliveryPrice,
    this.finalTotalPrice,
  });

  String finalPrice;
  String finalTaxPrice;
  String finalTotalSaving;
  String finalDeliveryPrice;
  String finalTotalPrice;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        finalPrice: json["final_price"],
        finalTaxPrice: json["final_tax_price"],
        finalTotalSaving: json["final_total_saving"],
        finalDeliveryPrice: json["final_delivery_price"],
        finalTotalPrice: json["final_total_price"],
      );

  Map<String, dynamic> toJson() => {
        "final_price": finalPrice,
        "final_tax_price": finalTaxPrice,
        "final_total_saving": finalTotalSaving,
        "final_delivery_price": finalDeliveryPrice,
        "final_total_price": finalTotalPrice,
      };
}

class UserDeliveryAddress {
  UserDeliveryAddress({
    this.fname,
    this.mname,
    this.lname,
    this.email,
    this.mobile,
    this.address1,
    this.address2,
    this.countries,
    this.state,
    this.city,
    this.pincode,
    this.latitudes,
    this.longitude,
  });

  String fname;
  String mname;
  String lname;
  String email;
  String mobile;
  String address1;
  String address2;
  String countries;
  String state;
  String city;
  String pincode;
  String latitudes;
  String longitude;

  factory UserDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      UserDeliveryAddress(
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        email: json["email"],
        mobile: json["mobile"],
        address1: json["address1"],
        address2: json["address2"],
        countries: json["countries"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        latitudes: json["latitudes"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "email": email,
        "mobile": mobile,
        "address1": address1,
        "address2": address2,
        "countries": countries,
        "state": state,
        "city": city,
        "pincode": pincode,
        "latitudes": latitudes,
        "longitude": longitude,
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
