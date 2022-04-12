// To parse this JSON data, do
//
//     final subCategoryHeaderResponse = subCategoryHeaderResponseFromJson(jsonString);

import 'dart:convert';

SubCategoryHeaderResponse subCategoryHeaderResponseFromJson(String str) =>
    SubCategoryHeaderResponse.fromJson(json.decode(str));

String subCategoryHeaderResponseToJson(SubCategoryHeaderResponse data) =>
    json.encode(data.toJson());

class SubCategoryHeaderResponse {
  SubCategoryHeaderResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory SubCategoryHeaderResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoryHeaderResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.categoryId,
    this.catSlug,
    this.categoryName,
    this.categoryImg,
    this.productCount,
    this.isSubcategoryExits,
    this.isFilterExits,
    this.subcategoryCount,
    this.subcategory,
    this.subSubcategoryCount,
    this.subSubcategory,
  });

  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;
  String productCount;
  String isSubcategoryExits;
  String isFilterExits;
  int subcategoryCount;
  List<Response> subcategory;
  int subSubcategoryCount;
  List<Response> subSubcategory;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        catSlug: json["cat_slug"] == null ? null : json["cat_slug"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        categoryImg: json["category_img"] == null ? null : json["category_img"],
        productCount:
            json["product_count"] == null ? null : json["product_count"],
        isSubcategoryExits: json["is_subcategory_exits"] == null
            ? null
            : json["is_subcategory_exits"],
        isFilterExits:
            json["is_filter_exits"] == null ? null : json["is_filter_exits"],
        subcategoryCount: json["subcategory_count"] == null
            ? null
            : json["subcategory_count"],
        subcategory: json["subcategory"] == null
            ? null
            : List<Response>.from(
                json["subcategory"].map((x) => Response.fromJson(x))),
        subSubcategoryCount: json["sub_subcategory_count"] == null
            ? null
            : json["sub_subcategory_count"],
        subSubcategory: json["sub_subcategory"] == null
            ? null
            : List<Response>.from(
                json["sub_subcategory"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "cat_slug": catSlug == null ? null : catSlug,
        "category_name": categoryName == null ? null : categoryName,
        "category_img": categoryImg == null ? null : categoryImg,
        "product_count": productCount == null ? null : productCount,
        "is_subcategory_exits":
            isSubcategoryExits == null ? null : isSubcategoryExits,
        "is_filter_exits": isFilterExits == null ? null : isFilterExits,
        "subcategory_count": subcategoryCount == null ? null : subcategoryCount,
        "subcategory": subcategory == null
            ? null
            : List<dynamic>.from(subcategory.map((x) => x.toJson())),
        "sub_subcategory_count":
            subSubcategoryCount == null ? null : subSubcategoryCount,
        "sub_subcategory": subSubcategory == null
            ? null
            : List<dynamic>.from(subSubcategory.map((x) => x.toJson())),
      };
}
