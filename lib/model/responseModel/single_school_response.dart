// To parse this JSON data, do
//
//     final singleSchoolResponse = singleSchoolResponseFromJson(jsonString);

import 'dart:convert';

SingleSchoolResponse singleSchoolResponseFromJson(String str) =>
    SingleSchoolResponse.fromJson(json.decode(str));

String singleSchoolResponseToJson(SingleSchoolResponse data) =>
    json.encode(data.toJson());

class SingleSchoolResponse {
  SingleSchoolResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory SingleSchoolResponse.fromJson(Map<String, dynamic> json) =>
      SingleSchoolResponse(
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
    this.school,
    this.schoolCat,
    this.schoolCatProduct,
    this.schoolAllProduct,
  });

  List<School> school;
  List<SchoolCat> schoolCat;
  List<SchoolCatProduct> schoolCatProduct;
  List<dynamic> schoolAllProduct;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        school: json["school"] == null
            ? null
            : List<School>.from(json["school"].map((x) => School.fromJson(x))),
        schoolCat: json["school_cat"] == null
            ? null
            : List<SchoolCat>.from(
                json["school_cat"].map((x) => SchoolCat.fromJson(x))),
        schoolCatProduct: json["school_cat_product"] == null
            ? null
            : List<SchoolCatProduct>.from(json["school_cat_product"]
                .map((x) => SchoolCatProduct.fromJson(x))),
        schoolAllProduct: json["school_all_product"] == null
            ? null
            : List<dynamic>.from(json["school_all_product"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "school": school == null
            ? null
            : List<dynamic>.from(school.map((x) => x.toJson())),
        "school_cat": schoolCat == null
            ? null
            : List<dynamic>.from(schoolCat.map((x) => x.toJson())),
        "school_cat_product": schoolCatProduct == null
            ? null
            : List<dynamic>.from(schoolCatProduct.map((x) => x.toJson())),
        "school_all_product": schoolAllProduct == null
            ? null
            : List<dynamic>.from(schoolAllProduct.map((x) => x)),
      };
}

class School {
  School({
    this.schoolId,
    this.schoolSlug,
    this.schoolLogo,
    this.schoolName,
    this.board,
    this.address,
    this.countries,
    this.state,
    this.city,
    this.pincode,
    this.landmark,
    this.isSchoolSecure,
    this.schoolBanners,
  });

  String schoolId;
  String schoolSlug;
  String schoolLogo;
  String schoolName;
  String board;
  String address;
  String countries;
  String state;
  String city;
  String pincode;
  String landmark;
  String isSchoolSecure;
  List<SchoolBanner> schoolBanners;

  factory School.fromJson(Map<String, dynamic> json) => School(
        schoolId: json["school_id"] == null ? null : json["school_id"],
        schoolSlug: json["school_slug"] == null ? null : json["school_slug"],
        schoolLogo: json["school_logo"] == null ? null : json["school_logo"],
        schoolName: json["school_name"] == null ? null : json["school_name"],
        board: json["board"] == null ? null : json["board"],
        address: json["address"] == null ? null : json["address"],
        countries: json["countries"] == null ? null : json["countries"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        isSchoolSecure:
            json["is_school_secure"] == null ? null : json["is_school_secure"],
        schoolBanners: json["school_banners"] == null
            ? null
            : List<SchoolBanner>.from(
                json["school_banners"].map((x) => SchoolBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "school_id": schoolId == null ? null : schoolId,
        "school_slug": schoolSlug == null ? null : schoolSlug,
        "school_logo": schoolLogo == null ? null : schoolLogo,
        "school_name": schoolName == null ? null : schoolName,
        "board": board == null ? null : board,
        "address": address == null ? null : address,
        "countries": countries == null ? null : countries,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "pincode": pincode == null ? null : pincode,
        "landmark": landmark == null ? null : landmark,
        "is_school_secure": isSchoolSecure == null ? null : isSchoolSecure,
        "school_banners": schoolBanners == null
            ? null
            : List<dynamic>.from(schoolBanners.map((x) => x.toJson())),
      };
}

class SchoolBanner {
  SchoolBanner({
    this.schoolImg,
  });

  String schoolImg;

  factory SchoolBanner.fromJson(Map<String, dynamic> json) => SchoolBanner(
        schoolImg: json["school_img"] == null ? null : json["school_img"],
      );

  Map<String, dynamic> toJson() => {
        "school_img": schoolImg == null ? null : schoolImg,
      };
}

class SchoolCat {
  SchoolCat({
    this.categoryId,
    this.categoryImg,
    this.categoryName,
    this.catSlug,
    this.productCount,
    this.isSubcategoryExits,
    this.isFilterExits,
    this.subSubcategoryCount,
    this.subSubcategory,
  });

  String categoryId;
  String categoryImg;
  String categoryName;
  String catSlug;
  String productCount;
  String isSubcategoryExits;
  String isFilterExits;
  int subSubcategoryCount;
  List<SchoolCat> subSubcategory;

  factory SchoolCat.fromJson(Map<String, dynamic> json) => SchoolCat(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryImg: json["category_img"] == null ? null : json["category_img"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        catSlug: json["cat_slug"] == null ? null : json["cat_slug"],
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
            : List<SchoolCat>.from(
                json["sub_subcategory"].map((x) => SchoolCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "category_img": categoryImg == null ? null : categoryImg,
        "category_name": categoryName == null ? null : categoryName,
        "cat_slug": catSlug == null ? null : catSlug,
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

class SchoolCatProduct {
  SchoolCatProduct({
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
  String productShareLink;
  List<dynamic> filters;
  List<dynamic> variationsDetails;
  List<dynamic> additionalSetDetails;
  List<dynamic> booksetDetails;

  factory SchoolCatProduct.fromJson(Map<String, dynamic> json) =>
      SchoolCatProduct(
        productId: json["product_id"] == null ? null : json["product_id"],
        productSlug: json["product_slug"] == null ? null : json["product_slug"],
        vendorSlug: json["vendor_slug"] == null ? null : json["vendor_slug"],
        schoolSlug: json["school_slug"] == null ? null : json["school_slug"],
        type: json["type"] == null ? null : json["type"],
        productType: json["product_type"] == null ? null : json["product_type"],
        variation: json["variation"] == null ? null : json["variation"],
        additionalSet:
            json["additional_set"] == null ? null : json["additional_set"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        howManyVariation: json["how_many_variation"] == null
            ? null
            : json["how_many_variation"],
        productImg: json["product_img"] == null ? null : json["product_img"],
        productImgs: json["product_imgs"] == null
            ? null
            : List<ProductImg>.from(
                json["product_imgs"].map((x) => ProductImg.fromJson(x))),
        productName: json["product_name"] == null ? null : json["product_name"],
        language: json["language"] == null ? null : json["language"],
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
            : json["show_disclaimer_text"],
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
        productShareLink: json["product_share_link"] == null
            ? null
            : json["product_share_link"],
        filters: json["filters"] == null
            ? null
            : List<dynamic>.from(json["filters"].map((x) => x)),
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
        "vendor_slug": vendorSlug == null ? null : vendorSlug,
        "school_slug": schoolSlug == null ? null : schoolSlug,
        "type": type == null ? null : type,
        "product_type": productType == null ? null : productType,
        "variation": variation == null ? null : variation,
        "additional_set": additionalSet == null ? null : additionalSet,
        "category_name": categoryName == null ? null : categoryName,
        "how_many_variation":
            howManyVariation == null ? null : howManyVariation,
        "product_img": productImg == null ? null : productImg,
        "product_imgs": productImgs == null
            ? null
            : List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "product_name": productName == null ? null : productName,
        "language": language == null ? null : language,
        "book_type": bookType == null ? null : bookType,
        "product_price": productPrice == null ? null : productPrice,
        "product_discount": productDiscount == null ? null : productDiscount,
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
        "show_disclaimer_text":
            showDisclaimerText == null ? null : showDisclaimerText,
        "vendor_company_name":
            vendorCompanyName == null ? null : vendorCompanyName,
        "product_in_user_wishlist":
            productInUserWishlist == null ? null : productInUserWishlist,
        "product_in_user_cart":
            productInUserCart == null ? null : productInUserCart,
        "product_in_user_cart_quantity": productInUserCartQuantity == null
            ? null
            : productInUserCartQuantity,
        "product_share_link":
            productShareLink == null ? null : productShareLink,
        "filters":
            filters == null ? null : List<dynamic>.from(filters.map((x) => x)),
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
