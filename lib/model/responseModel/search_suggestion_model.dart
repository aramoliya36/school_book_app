import 'dart:convert';

class SearchSuggestionModel {
  int status;
  String message;
  int count;
  List<SuggestionResponse> response;

  SearchSuggestionModel({this.status, this.message, this.count, this.response});

  SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      response = new List<SuggestionResponse>();
      json['response'].forEach((v) {
        response.add(new SuggestionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestionResponse {
  String productId;
  String productSlug;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String categoryName;
  String productImg;
  String productName;
  String actionType;

  SuggestionResponse(
      {this.productId,
      this.productSlug,
      this.vendorSlug,
      this.schoolSlug,
      this.type,
      this.productType,
      this.categoryName,
      this.productImg,
      this.productName,
      this.actionType});

  SuggestionResponse.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSlug = json['product_slug'];
    vendorSlug = json['vendor_slug'];
    schoolSlug = json['school_slug'];
    type = json['type'];
    productType = json['product_type'];
    categoryName = json['category_name'];
    productImg = json['Product_img'];
    productName = json['product_name'];
    actionType = json['action_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_slug'] = this.productSlug;
    data['vendor_slug'] = this.vendorSlug;
    data['school_slug'] = this.schoolSlug;
    data['type'] = this.type;
    data['product_type'] = this.productType;
    data['category_name'] = this.categoryName;
    data['Product_img'] = this.productImg;
    data['product_name'] = this.productName;
    data['action_type'] = this.actionType;
    return data;
  }
}

NoDataOrderModel noDataOrderModelFromJson(String str) =>
    NoDataOrderModel.fromJson(json.decode(str));

String noDataOrderModelToJson(NoDataOrderModel data) =>
    json.encode(data.toJson());

class NoDataOrderModel {
  NoDataOrderModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory NoDataOrderModel.fromJson(Map<String, dynamic> json) =>
      NoDataOrderModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<dynamic>.from(json["response"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(response.map((x) => x)),
      };
}
