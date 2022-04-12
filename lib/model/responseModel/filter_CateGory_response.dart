import 'dart:convert';

CategoryFilterModelResponse categoryFilterModelResponseFromJson(String str) =>
    CategoryFilterModelResponse.fromJson(json.decode(str));

String categoryFilterModelResponseToJson(CategoryFilterModelResponse data) =>
    json.encode(data.toJson());

class CategoryFilterModelResponse {
  CategoryFilterModelResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CategoryFilterModelResponse.fromJson(Map<String, dynamic> json) =>
      CategoryFilterModelResponse(
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
    this.subCategory,
    this.product,
  });

  List<Category> category;
  List<Category> subCategory;
  List<dynamic> product;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        category: json["category"] == null
            ? null
            : List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
        subCategory: json["sub_category"] == null
            ? null
            : List<Category>.from(
                json["sub_category"].map((x) => Category.fromJson(x))),
        product: json["product"] == null
            ? null
            : List<dynamic>.from(json["product"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x.toJson())),
        "product":
            product == null ? null : List<dynamic>.from(product.map((x) => x)),
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
  int subSubcategoryCount;
  List<Category> subSubcategory;

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
        subSubcategoryCount: json["sub_subcategory_count"] == null
            ? null
            : json["sub_subcategory_count"],
        subSubcategory: json["sub_subcategory"] == null
            ? null
            : List<Category>.from(
                json["sub_subcategory"].map((x) => Category.fromJson(x))),
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
        "sub_subcategory_count":
            subSubcategoryCount == null ? null : subSubcategoryCount,
        "sub_subcategory": subSubcategory == null
            ? null
            : List<dynamic>.from(subSubcategory.map((x) => x.toJson())),
      };
}
