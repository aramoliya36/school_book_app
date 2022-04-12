// To parse this JSON data, do
//
//     final mainCategoriesSubcategoriesProductFilterResponse = mainCategoriesSubcategoriesProductFilterResponseFromJson(jsonString);

import 'dart:convert';

MainCategoriesSubcategoriesProductFilterResponse
    mainCategoriesSubcategoriesProductFilterResponseFromJson(String str) =>
        MainCategoriesSubcategoriesProductFilterResponse.fromJson(
            json.decode(str));

String mainCategoriesSubcategoriesProductFilterResponseToJson(
        MainCategoriesSubcategoriesProductFilterResponse data) =>
    json.encode(data.toJson());

class MainCategoriesSubcategoriesProductFilterResponse {
  MainCategoriesSubcategoriesProductFilterResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory MainCategoriesSubcategoriesProductFilterResponse.fromJson(
          Map<String, dynamic> json) =>
      MainCategoriesSubcategoriesProductFilterResponse(
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
  List<Product> product;

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
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x.toJson())),
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toJson())),
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
    this.allProductsCount,
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
  String allProductsCount;
  int subSubcategoryCount;
  List<dynamic> subSubcategory;

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
        allProductsCount: json["all_products_count"] == null
            ? null
            : json["all_products_count"],
        subSubcategoryCount: json["sub_subcategory_count"] == null
            ? null
            : json["sub_subcategory_count"],
        subSubcategory: json["sub_subcategory"] == null
            ? null
            : List<dynamic>.from(json["sub_subcategory"].map((x) => x)),
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
        "all_products_count":
            allProductsCount == null ? null : allProductsCount,
        "sub_subcategory_count":
            subSubcategoryCount == null ? null : subSubcategoryCount,
        "sub_subcategory": subSubcategory == null
            ? null
            : List<dynamic>.from(subSubcategory.map((x) => x)),
      };
}

class Product {
  Product({
    this.productId,
    this.productSlug,
    this.vendorSlug,
    this.schoolSlug,
    this.type,
    this.productType,
    this.variation,
    this.additionalSet,
    this.categoryName,
    this.howManyVariation,
    this.productImg,
    this.productImgs,
    this.productName,
    this.language,
    this.bookType,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productAdditionalSetTotalPrice,
    this.quantity,
    this.productStockStatus,
    this.productSpecification,
    this.productDescription,
    this.showDisclaimer,
    this.showDisclaimerText,
    this.vendorCompanyName,
    this.productInUserWishlist,
    this.productInUserCart,
    this.productInUserCartQuantity,
    this.productInUserCartId,
    this.productShareLink,
    this.filters,
    this.variationsDetails,
    this.additionalSetDetails,
    this.booksetDetails,
  });

  String productId;
  String productSlug;
  VendorSlug vendorSlug;
  String schoolSlug;
  Type type;
  String productType;
  String variation;
  AdditionalSet additionalSet;
  CategoryName categoryName;
  String howManyVariation;
  String productImg;
  List<ProductImg> productImgs;
  String productName;
  Language language;
  String bookType;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productAdditionalSetTotalPrice;
  String quantity;
  String productStockStatus;
  String productSpecification;
  String productDescription;
  String showDisclaimer;
  ShowDisclaimerText showDisclaimerText;
  String vendorCompanyName;
  String productInUserWishlist;
  String productInUserCart;
  String productInUserCartQuantity;
  String productInUserCartId;
  String productShareLink;
  List<Filter> filters;
  List<dynamic> variationsDetails;
  List<dynamic> additionalSetDetails;
  List<dynamic> booksetDetails;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"] == null ? null : json["product_id"],
        productSlug: json["product_slug"] == null ? null : json["product_slug"],
        vendorSlug: json["vendor_slug"] == null
            ? null
            : vendorSlugValues.map[json["vendor_slug"]],
        schoolSlug: json["school_slug"] == null ? null : json["school_slug"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        productType: json["product_type"] == null ? null : json["product_type"],
        variation: json["variation"] == null ? null : json["variation"],
        additionalSet: json["additional_set"] == null
            ? null
            : additionalSetValues.map[json["additional_set"]],
        categoryName: json["category_name"] == null
            ? null
            : categoryNameValues.map[json["category_name"]],
        howManyVariation: json["how_many_variation"] == null
            ? null
            : json["how_many_variation"],
        productImg: json["product_img"] == null ? null : json["product_img"],
        productImgs: json["product_imgs"] == null
            ? null
            : List<ProductImg>.from(
                json["product_imgs"].map((x) => ProductImg.fromJson(x))),
        productName: json["product_name"] == null ? null : json["product_name"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        bookType: json["book_type"] == null ? null : json["book_type"],
        productPrice:
            json["product_price"] == null ? null : json["product_price"],
        productDiscount:
            json["product_discount"] == null ? null : json["product_discount"],
        productSalePrice: json["product_sale_price"] == null
            ? null
            : json["product_sale_price"],
        productAdditionalSetTotalPrice:
            json["product_additional_set_total_price"] == null
                ? null
                : json["product_additional_set_total_price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        productStockStatus: json["product_stock_status"] == null
            ? null
            : json["product_stock_status"],
        productSpecification: json["product_specification"] == null
            ? null
            : json["product_specification"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        showDisclaimer:
            json["show_disclaimer"] == null ? null : json["show_disclaimer"],
        showDisclaimerText: json["show_disclaimer_text"] == null
            ? null
            : showDisclaimerTextValues.map[json["show_disclaimer_text"]],
        vendorCompanyName: json["vendor_company_name"] == null
            ? null
            : json["vendor_company_name"],
        productInUserWishlist: json["product_in_user_wishlist"] == null
            ? null
            : json["product_in_user_wishlist"],
        productInUserCart: json["product_in_user_cart"] == null
            ? null
            : json["product_in_user_cart"],
        productInUserCartQuantity: json["product_in_user_cart_quantity"] == null
            ? null
            : json["product_in_user_cart_quantity"],
        productInUserCartId: json["product_in_user_cart_id"] == null
            ? null
            : json["product_in_user_cart_id"],
        productShareLink: json["product_share_link"] == null
            ? null
            : json["product_share_link"],
        filters: json["filters"] == null
            ? null
            : List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
        variationsDetails: json["variations_details"] == null
            ? null
            : List<dynamic>.from(json["variations_details"].map((x) => x)),
        additionalSetDetails: json["additional_set_details"] == null
            ? null
            : List<dynamic>.from(json["additional_set_details"].map((x) => x)),
        booksetDetails: json["bookset_details"] == null
            ? null
            : List<dynamic>.from(json["bookset_details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "product_slug": productSlug == null ? null : productSlug,
        "vendor_slug":
            vendorSlug == null ? null : vendorSlugValues.reverse[vendorSlug],
        "school_slug": schoolSlug == null ? null : schoolSlug,
        "type": type == null ? null : typeValues.reverse[type],
        "product_type":
            productType == null ? null : productTypeValues.reverse[productType],
        "variation": variation == null ? null : variation,
        "additional_set": additionalSet == null
            ? null
            : additionalSetValues.reverse[additionalSet],
        "category_name": categoryName == null
            ? null
            : categoryNameValues.reverse[categoryName],
        "how_many_variation":
            howManyVariation == null ? null : howManyVariation,
        "product_img": productImg == null ? null : productImg,
        "product_imgs": productImgs == null
            ? null
            : List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "product_name": productName == null ? null : productName,
        "language": language == null ? null : languageValues.reverse[language],
        "book_type": bookType == null ? null : bookType,
        "product_price": productPrice == null ? null : productPrice,
        "product_discount": productDiscount == null
            ? null
            : productDiscountValues.reverse[productDiscount],
        "product_sale_price":
            productSalePrice == null ? null : productSalePrice,
        "product_additional_set_total_price":
            productAdditionalSetTotalPrice == null
                ? null
                : productAdditionalSetTotalPrice,
        "quantity": quantity == null ? null : quantity,
        "product_stock_status":
            productStockStatus == null ? null : productStockStatus,
        "product_specification":
            productSpecification == null ? null : productSpecification,
        "product_description":
            productDescription == null ? null : productDescription,
        "show_disclaimer": showDisclaimer == null ? null : showDisclaimer,
        "show_disclaimer_text": showDisclaimerText == null
            ? null
            : showDisclaimerTextValues.reverse[showDisclaimerText],
        "vendor_company_name":
            vendorCompanyName == null ? null : vendorCompanyName,
        "product_in_user_wishlist":
            productInUserWishlist == null ? null : productInUserWishlist,
        "product_in_user_cart":
            productInUserCart == null ? null : productInUserCart,
        "product_in_user_cart_quantity": productInUserCartQuantity == null
            ? null
            : productInUserCartQuantity,
        "product_in_user_cart_id":
            productInUserCartId == null ? null : productInUserCartId,
        "product_share_link":
            productShareLink == null ? null : productShareLink,
        "filters": filters == null
            ? null
            : List<dynamic>.from(filters.map((x) => x.toJson())),
        "variations_details": variationsDetails == null
            ? null
            : List<dynamic>.from(variationsDetails.map((x) => x)),
        "additional_set_details": additionalSetDetails == null
            ? null
            : List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "bookset_details": booksetDetails == null
            ? null
            : List<dynamic>.from(booksetDetails.map((x) => x)),
      };
}

enum AdditionalSet { NO }

final additionalSetValues = EnumValues({"NO": AdditionalSet.NO});

enum CategoryName { CBSE_BOOKS }

final categoryNameValues = EnumValues({"CBSE Books": CategoryName.CBSE_BOOKS});

class Filter {
  Filter({
    this.filterTypeName,
    this.filterTypeSlug,
    this.filterData,
  });

  FilterTypeName filterTypeName;
  FilterType filterTypeSlug;
  List<FilterDatum> filterData;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        filterTypeName: json["filter_type_name"] == null
            ? null
            : filterTypeNameValues.map[json["filter_type_name"]],
        filterTypeSlug: json["filter_type_slug"] == null
            ? null
            : filterTypeValues.map[json["filter_type_slug"]],
        filterData: json["filter_data"] == null
            ? null
            : List<FilterDatum>.from(
                json["filter_data"].map((x) => FilterDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filter_type_name": filterTypeName == null
            ? null
            : filterTypeNameValues.reverse[filterTypeName],
        "filter_type_slug": filterTypeSlug == null
            ? null
            : filterTypeValues.reverse[filterTypeSlug],
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
  FilterType filterType;

  factory FilterDatum.fromJson(Map<String, dynamic> json) => FilterDatum(
        filterId: json["filter_id"] == null ? null : json["filter_id"],
        filterSlug: json["filter_slug"] == null ? null : json["filter_slug"],
        filterName: json["filter_name"] == null ? null : json["filter_name"],
        filterImg: json["filter_img"] == null ? null : json["filter_img"],
        filterType: json["filter_type"] == null
            ? null
            : filterTypeValues.map[json["filter_type"]],
      );

  Map<String, dynamic> toJson() => {
        "filter_id": filterId == null ? null : filterId,
        "filter_slug": filterSlug == null ? null : filterSlug,
        "filter_name": filterName == null ? null : filterName,
        "filter_img": filterImg == null ? null : filterImg,
        "filter_type":
            filterType == null ? null : filterTypeValues.reverse[filterType],
      };
}

enum FilterType { PUBLISHER, CLASS, SUBJECT, AUTHOR, BRAND }

final filterTypeValues = EnumValues({
  "author": FilterType.AUTHOR,
  "brand": FilterType.BRAND,
  "class": FilterType.CLASS,
  "publisher": FilterType.PUBLISHER,
  "subject": FilterType.SUBJECT
});

enum FilterTypeName { PUBLISHER, CLASS, SUBJECT, AUTHOR, BRAND }

final filterTypeNameValues = EnumValues({
  "Author": FilterTypeName.AUTHOR,
  "Brand": FilterTypeName.BRAND,
  "Class": FilterTypeName.CLASS,
  "Publisher": FilterTypeName.PUBLISHER,
  "Subject": FilterTypeName.SUBJECT
});

enum Language { EMPTY, ENGLISH, HINDI }

final languageValues = EnumValues(
    {"": Language.EMPTY, "English": Language.ENGLISH, "Hindi": Language.HINDI});

enum ProductDiscount { THE_10, THE_175 }

final productDiscountValues = EnumValues(
    {"10%": ProductDiscount.THE_10, "17.5%": ProductDiscount.THE_175});

class ProductImg {
  ProductImg({
    this.productImg,
  });

  String productImg;

  factory ProductImg.fromJson(Map<String, dynamic> json) => ProductImg(
        productImg: json["product_img"] == null ? null : json["product_img"],
      );

  Map<String, dynamic> toJson() => {
        "product_img": productImg == null ? null : productImg,
      };
}

enum ProductType { SINGLE }

final productTypeValues = EnumValues({"Single": ProductType.SINGLE});

enum ShowDisclaimerText {
  COLOR_MAY_BE_VARY_PRODUCT_MAY_BE_DIFFER_FROM_ACTUAL_IMAGE,
  EMPTY
}

final showDisclaimerTextValues = EnumValues({
  "Color may be vary, Product may be differ from actual image":
      ShowDisclaimerText
          .COLOR_MAY_BE_VARY_PRODUCT_MAY_BE_DIFFER_FROM_ACTUAL_IMAGE,
  "": ShowDisclaimerText.EMPTY
});

enum Type { NORMAL }

final typeValues = EnumValues({"Normal": Type.NORMAL});

enum VendorSlug { ABC_SKOOLMONK }

final vendorSlugValues =
    EnumValues({"abc-skoolmonk": VendorSlug.ABC_SKOOLMONK});

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
