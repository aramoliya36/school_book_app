// To parse this JSON data, do
//
//     final variationInfo2Response = variationInfo2ResponseFromJson(jsonString);

import 'dart:convert';

VariationInfo2Response variationInfo2ResponseFromJson(String str) =>
    VariationInfo2Response.fromJson(json.decode(str));

String variationInfo2ResponseToJson(VariationInfo2Response data) =>
    json.encode(data.toJson());

class VariationInfo2Response {
  VariationInfo2Response({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory VariationInfo2Response.fromJson(Map<String, dynamic> json) =>
      VariationInfo2Response(
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
    this.pvsmId,
    this.productId,
    this.variation,
    this.quantity,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productStockStatus,
    this.variationImgGrp,
    this.productImgs,
    this.variationsInfo,
  });

  String pvsmId;
  String productId;
  String variation;
  String quantity;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productStockStatus;
  String variationImgGrp;
  List<ProductImg> productImgs;
  List<VariationsInfo> variationsInfo;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        pvsmId: json["pvsm_id"],
        productId: json["product_id"],
        variation: json["variation"],
        quantity: json["quantity"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productStockStatus: json["product_stock_status"],
        variationImgGrp: json["variation_img_grp"],
        productImgs: List<ProductImg>.from(
            json["product_imgs"].map((x) => ProductImg.fromJson(x))),
        variationsInfo: List<VariationsInfo>.from(
            json["variations_info"].map((x) => VariationsInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pvsm_id": pvsmId,
        "product_id": productId,
        "variation": variation,
        "quantity": quantity,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_stock_status": productStockStatus,
        "variation_img_grp": variationImgGrp,
        "product_imgs": List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "variations_info":
            List<dynamic>.from(variationsInfo.map((x) => x.toJson())),
      };
}

class ProductImg {
  ProductImg({
    this.productImg,
  });

  String productImg;

  factory ProductImg.fromJson(Map<String, dynamic> json) => ProductImg(
        productImg: json["product_img"],
      );

  Map<String, dynamic> toJson() => {
        "product_img": productImg,
      };
}

class VariationsInfo {
  VariationsInfo({
    this.variationsDataId,
    this.variationsOptionsName,
    this.variationName,
  });

  String variationsDataId;
  String variationsOptionsName;
  String variationName;

  factory VariationsInfo.fromJson(Map<String, dynamic> json) => VariationsInfo(
        variationsDataId: json["variations_data_id"],
        variationsOptionsName: json["variations_options_name"],
        variationName: json["variation_name"],
      );

  Map<String, dynamic> toJson() => {
        "variations_data_id": variationsDataId,
        "variations_options_name": variationsOptionsName,
        "variation_name": variationName,
      };
}
