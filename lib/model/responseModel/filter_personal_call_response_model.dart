// To parse this JSON data, do
//
//     final filterPerosonalCallRespons = filterPerosonalCallResponsFromJson(jsonString);

import 'dart:convert';

FilterPerosonalCallRespons filterPerosonalCallResponsFromJson(String str) =>
    FilterPerosonalCallRespons.fromJson(json.decode(str));

String filterPerosonalCallResponsToJson(FilterPerosonalCallRespons data) =>
    json.encode(data.toJson());

class FilterPerosonalCallRespons {
  FilterPerosonalCallRespons({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory FilterPerosonalCallRespons.fromJson(Map<String, dynamic> json) =>
      FilterPerosonalCallRespons(
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
    this.category,
    this.filters,
    this.subCategory,
  });

  List<Category> category;
  List<Filter> filters;
  List<dynamic> subCategory;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        category: json["category"] == null
            ? null
            : List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
        filters: json["filters"] == null
            ? null
            : List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
        subCategory: json["sub_category"] == null
            ? null
            : List<dynamic>.from(json["sub_category"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
        "filters": filters == null
            ? null
            : List<dynamic>.from(filters.map((x) => x.toJson())),
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x)),
      };
}

class Category {
  Category({
    this.categoryId,
    this.catSlug,
    this.categoryName,
    this.categoryImg,
    this.productCount,
    this.isSubcategoryExits,
    this.isFilterExits,
  });

  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;
  String productCount;
  String isSubcategoryExits;
  String isFilterExits;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
      };
}

class Filter {
  Filter({
    this.filterTypeName,
    this.filterTypeSlug,
    this.filterData,
  });

  String filterTypeName;
  String filterTypeSlug;
  List<FilterDatum> filterData;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        filterTypeName:
            json["filter_type_name"] == null ? null : json["filter_type_name"],
        filterTypeSlug:
            json["filter_type_slug"] == null ? null : json["filter_type_slug"],
        filterData: json["filter_data"] == null
            ? null
            : List<FilterDatum>.from(
                json["filter_data"].map((x) => FilterDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filter_type_name": filterTypeName == null ? null : filterTypeName,
        "filter_type_slug": filterTypeSlug == null ? null : filterTypeSlug,
        "filter_data": filterData == null
            ? null
            : List<dynamic>.from(filterData.map((x) => x.toJson())),
      };
}

class FilterDatum {
  FilterDatum({
    this.filterId,
    this.filterSlug,
    this.filterName,
    this.filterImg,
    this.filterType,
  });

  String filterId;
  String filterSlug;
  String filterName;
  String filterImg;
  String filterType;

  factory FilterDatum.fromJson(Map<String, dynamic> json) => FilterDatum(
        filterId: json["filter_id"] == null ? null : json["filter_id"],
        filterSlug: json["filter_slug"] == null ? null : json["filter_slug"],
        filterName: json["filter_name"] == null ? null : json["filter_name"],
        filterImg: json["filter_img"] == null ? null : json["filter_img"],
        filterType: json["filter_type"] == null ? null : json["filter_type"],
      );

  Map<String, dynamic> toJson() => {
        "filter_id": filterId == null ? null : filterId,
        "filter_slug": filterSlug == null ? null : filterSlug,
        "filter_name": filterName == null ? null : filterName,
        "filter_img": filterImg == null ? null : filterImg,
        "filter_type": filterType == null ? null : filterType,
      };
}
