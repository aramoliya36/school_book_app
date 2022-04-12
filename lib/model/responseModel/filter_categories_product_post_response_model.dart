// To parse this JSON data, do
//
//     final filterCategoriesProductPostResponse = filterCategoriesProductPostResponseFromJson(jsonString);

import 'dart:convert';

FilterCategoriesProductPostResponse filterCategoriesProductPostResponseFromJson(
        String str) =>
    FilterCategoriesProductPostResponse.fromJson(json.decode(str));

String filterCategoriesProductPostResponseToJson(
        FilterCategoriesProductPostResponse data) =>
    json.encode(data.toJson());

class FilterCategoriesProductPostResponse {
  FilterCategoriesProductPostResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory FilterCategoriesProductPostResponse.fromJson(
          Map<String, dynamic> json) =>
      FilterCategoriesProductPostResponse(
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
    this.category,
    this.subCategory,
    this.filtersInfo,
    this.product,
  });

  List<dynamic> category;
  List<dynamic> subCategory;
  List<FiltersInfoElement> filtersInfo;
  List<Product> product;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        category: List<dynamic>.from(json["category"].map((x) => x)),
        subCategory: List<dynamic>.from(json["sub_category"].map((x) => x)),
        filtersInfo: List<FiltersInfoElement>.from(
            json["filters_info"].map((x) => FiltersInfoElement.fromJson(x))),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x)),
        "sub_category": List<dynamic>.from(subCategory.map((x) => x)),
        "filters_info": List<dynamic>.from(filtersInfo.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class FiltersInfoElement {
  FiltersInfoElement({
    this.filterId,
    this.filterSlug,
    this.filterName,
    this.filterImg,
    this.filterType,
    this.allProductsCount,
  });

  String filterId;
  String filterSlug;
  String filterName;
  String filterImg;
  String filterType;
  String allProductsCount;

  factory FiltersInfoElement.fromJson(Map<String, dynamic> json) =>
      FiltersInfoElement(
        filterId: json["filter_id"],
        filterSlug: json["filter_slug"],
        filterName: json["filter_name"],
        filterImg: json["filter_img"],
        filterType: json["filter_type"],
        allProductsCount: json["all_products_count"] == null
            ? null
            : json["all_products_count"],
      );

  Map<String, dynamic> toJson() => {
        "filter_id": filterId,
        "filter_slug": filterSlug,
        "filter_name": filterName,
        "filter_img": filterImg,
        "filter_type": filterType,
        "all_products_count":
            allProductsCount == null ? null : allProductsCount,
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
    this.productSalePriceOg,
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
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String additionalSet;
  String categoryName;
  String howManyVariation;
  String productImg;
  List<ProductImg> productImgs;
  String productName;
  String language;
  String bookType;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productSalePriceOg;
  String productAdditionalSetTotalPrice;
  String quantity;
  String productStockStatus;
  String productSpecification;
  String productDescription;
  String showDisclaimer;
  String showDisclaimerText;
  String vendorCompanyName;
  String productInUserWishlist;
  String productInUserCart;
  String productInUserCartQuantity;
  String productInUserCartId;
  String productShareLink;
  List<FilterElement> filters;
  List<dynamic> variationsDetails;
  List<dynamic> additionalSetDetails;
  List<dynamic> booksetDetails;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: json["vendor_slug"],
        schoolSlug: json["school_slug"],
        type: json["type"],
        productType: json["product_type"],
        variation: json["variation"],
        additionalSet: json["additional_set"],
        categoryName: json["category_name"],
        howManyVariation: json["how_many_variation"],
        productImg: json["product_img"],
        productImgs: List<ProductImg>.from(
            json["product_imgs"].map((x) => ProductImg.fromJson(x))),
        productName: json["product_name"],
        language: json["language"],
        bookType: json["book_type"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productSalePriceOg: json["product_sale_price_og"],
        productAdditionalSetTotalPrice:
            json["product_additional_set_total_price"],
        quantity: json["quantity"],
        productStockStatus: json["product_stock_status"],
        productSpecification: json["product_specification"],
        productDescription: json["product_description"],
        showDisclaimer: json["show_disclaimer"],
        showDisclaimerText: json["show_disclaimer_text"],
        vendorCompanyName: json["vendor_company_name"],
        productInUserWishlist: json["product_in_user_wishlist"],
        productInUserCart: json["product_in_user_cart"],
        productInUserCartQuantity: json["product_in_user_cart_quantity"],
        productInUserCartId: json["product_in_user_cart_id"],
        productShareLink: json["product_share_link"],
        filters: List<FilterElement>.from(
            json["filters"].map((x) => FilterElement.fromJson(x))),
        variationsDetails:
            List<dynamic>.from(json["variations_details"].map((x) => x)),
        additionalSetDetails:
            List<dynamic>.from(json["additional_set_details"].map((x) => x)),
        booksetDetails:
            List<dynamic>.from(json["bookset_details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlug,
        "school_slug": schoolSlug,
        "type": type,
        "product_type": productType,
        "variation": variation,
        "additional_set": additionalSet,
        "category_name": categoryName,
        "how_many_variation": howManyVariation,
        "product_img": productImg,
        "product_imgs": List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "product_name": productName,
        "language": language,
        "book_type": bookType,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_sale_price_og": productSalePriceOg,
        "product_additional_set_total_price": productAdditionalSetTotalPrice,
        "quantity": quantity,
        "product_stock_status": productStockStatus,
        "product_specification": productSpecification,
        "product_description": productDescription,
        "show_disclaimer": showDisclaimer,
        "show_disclaimer_text": showDisclaimerText,
        "vendor_company_name": vendorCompanyName,
        "product_in_user_wishlist": productInUserWishlist,
        "product_in_user_cart": productInUserCart,
        "product_in_user_cart_quantity": productInUserCartQuantity,
        "product_in_user_cart_id": productInUserCartId,
        "product_share_link": productShareLink,
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
        "variations_details":
            List<dynamic>.from(variationsDetails.map((x) => x)),
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "bookset_details": List<dynamic>.from(booksetDetails.map((x) => x)),
      };
}

class FilterElement {
  FilterElement({
    this.filterTypeName,
    this.filterTypeSlug,
    this.filterData,
  });

  String filterTypeName;
  String filterTypeSlug;
  List<FiltersInfoElement> filterData;

  factory FilterElement.fromJson(Map<String, dynamic> json) => FilterElement(
        filterTypeName: json["filter_type_name"],
        filterTypeSlug: json["filter_type_slug"],
        filterData: List<FiltersInfoElement>.from(
            json["filter_data"].map((x) => FiltersInfoElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filter_type_name": filterTypeName,
        "filter_type_slug": filterTypeSlug,
        "filter_data": List<dynamic>.from(filterData.map((x) => x.toJson())),
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
