// To parse this JSON data, do
//
//     final purchaseHistoryDeliveredResponse = purchaseHistoryDeliveredResponseFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryDeliveredResponse purchaseHistoryDeliveredResponseFromJson(
        String str) =>
    PurchaseHistoryDeliveredResponse.fromJson(json.decode(str));

String purchaseHistoryDeliveredResponseToJson(
        PurchaseHistoryDeliveredResponse data) =>
    json.encode(data.toJson());

class PurchaseHistoryDeliveredResponse {
  PurchaseHistoryDeliveredResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory PurchaseHistoryDeliveredResponse.fromJson(
          Map<String, dynamic> json) =>
      PurchaseHistoryDeliveredResponse(
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
    this.orderData,
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
  List<OrderDatum> orderData;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
        orderData: List<OrderDatum>.from(
            json["order_data"].map((x) => OrderDatum.fromJson(x))),
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
        "order_data": List<dynamic>.from(orderData.map((x) => x.toJson())),
      };
}

class OrderDatum {
  OrderDatum({
    this.orderNo,
    this.subOrderNo,
    this.isInvoiceMade,
    this.invoiceLink,
    this.orderDetail,
  });

  String orderNo;
  String subOrderNo;
  String isInvoiceMade;
  String invoiceLink;
  List<OrderDetail> orderDetail;

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        orderNo: json["order_no"],
        subOrderNo: json["sub_order_no"],
        isInvoiceMade: json["is_invoice_made"],
        invoiceLink: json["invoice_link"],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "sub_order_no": subOrderNo,
        "is_invoice_made": isInvoiceMade,
        "invoice_link": invoiceLink,
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.productId,
    this.productSlug,
    this.productName,
  });

  String productId;
  ProductSlug productSlug;
  String productName;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["product_id"],
        productSlug: productSlugValues.map[json["product_slug"]],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlugValues.reverse[productSlug],
        "product_name": productName,
      };
}

enum ProductName {
  BUSY_BEES_HINDI_PATHMALA_1,
  BUSY_BEES_HINDI_PATHMALA_2,
  MARGE_BOOKSET
}

final productNameValues = EnumValues({
  "Busy Bees Hindi Pathmala - 1": ProductName.BUSY_BEES_HINDI_PATHMALA_1,
  "Busy Bees Hindi Pathmala - 2": ProductName.BUSY_BEES_HINDI_PATHMALA_2,
  "Marge Bookset": ProductName.MARGE_BOOKSET
});

enum ProductSlug {
  BUSY_BEES_HINDI_PATHMALA_1,
  BUSY_BEES_HINDI_PATHMALA_2,
  MARGE_BOOKSET
}

final productSlugValues = EnumValues({
  "busy-bees-hindi-pathmala---1": ProductSlug.BUSY_BEES_HINDI_PATHMALA_1,
  "busy-bees-hindi-pathmala---2": ProductSlug.BUSY_BEES_HINDI_PATHMALA_2,
  "marge-bookset": ProductSlug.MARGE_BOOKSET
});

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
