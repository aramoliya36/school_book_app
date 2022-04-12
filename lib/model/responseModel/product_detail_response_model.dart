// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) =>
    ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) =>
    json.encode(data.toJson());

class ProductDetailResponse {
  ProductDetailResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
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
    this.booksetCustomizeableType,
    this.booksetDetails,
    this.relatedProducts,
  });

  String productId;
  String productSlug;
  VendorSlug vendorSlug;
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
  List<dynamic> filters;
  List<VariationsDetail> variationsDetails;
  List<dynamic> additionalSetDetails;
  String booksetCustomizeableType;
  List<BooksetDetail> booksetDetails;
  List<Response> relatedProducts;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: vendorSlugValues.map[json["vendor_slug"]],
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
        filters: List<dynamic>.from(json["filters"].map((x) => x)),
        variationsDetails: List<VariationsDetail>.from(
            json["variations_details"]
                .map((x) => VariationsDetail.fromJson(x))),
        additionalSetDetails:
            List<dynamic>.from(json["additional_set_details"].map((x) => x)),
        booksetCustomizeableType: json["bookset_customizeable_type"] == null
            ? null
            : json["bookset_customizeable_type"],
        booksetDetails: List<BooksetDetail>.from(
            json["bookset_details"].map((x) => BooksetDetail.fromJson(x))),
        relatedProducts: json["related_products"] == null
            ? null
            : List<Response>.from(
                json["related_products"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlugValues.reverse[vendorSlug],
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
        "filters": List<dynamic>.from(filters.map((x) => x)),
        "variations_details":
            List<dynamic>.from(variationsDetails.map((x) => x.toJson())),
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "bookset_customizeable_type":
            booksetCustomizeableType == null ? null : booksetCustomizeableType,
        "bookset_details":
            List<dynamic>.from(booksetDetails.map((x) => x.toJson())),
        "related_products": relatedProducts == null
            ? null
            : List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
      };
}

class BooksetDetail {
  BooksetDetail({
    this.pbdId,
    this.productId,
    this.booksetId,
    this.booksetName,
    this.isMandatory,
    this.isCustomizeable,
    this.productIds,
    this.booksetProductCount,
    this.booksetProductQuantityCount,
    this.booksetProductCustomizeQuantityCount,
    this.booksetCustomizeableTypeSingleBooksetState,
    this.isMainBooksetShow,
    this.totalBooksetPrice,
    this.totalBooksetSalePrice,
    this.productInfo,
  });

  String pbdId;
  String productId;
  String booksetId;
  String booksetName;
  String isMandatory;
  String isCustomizeable;
  String productIds;
  String booksetProductCount;
  String booksetProductQuantityCount;
  String booksetProductCustomizeQuantityCount;
  String booksetCustomizeableTypeSingleBooksetState;
  String isMainBooksetShow;
  String totalBooksetPrice;
  String totalBooksetSalePrice;
  List<ProductInfo> productInfo;

  factory BooksetDetail.fromJson(Map<String, dynamic> json) => BooksetDetail(
        pbdId: json["pbd_id"],
        productId: json["product_id"],
        booksetId: json["bookset_id"],
        booksetName: json["bookset_name"],
        isMandatory: json["is_mandatory"],
        isCustomizeable: json["is_customizeable"],
        productIds: json["product_ids"],
        booksetProductCount: json["bookset_product_count"],
        booksetProductQuantityCount: json["bookset_product_quantity_count"],
        booksetProductCustomizeQuantityCount:
            json["bookset_product_customize_quantity_count"],
        booksetCustomizeableTypeSingleBooksetState:
            json["bookset_customizeable_type_single_bookset_state"],
        isMainBooksetShow: json["is_main_bookset_show"],
        totalBooksetPrice: json["total_bookset_price"],
        totalBooksetSalePrice: json["total_bookset_sale_price"],
        productInfo: List<ProductInfo>.from(
            json["product_info"].map((x) => ProductInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pbd_id": pbdId,
        "product_id": productId,
        "bookset_id": booksetId,
        "bookset_name": booksetName,
        "is_mandatory": isMandatory,
        "is_customizeable": isCustomizeable,
        "product_ids": productIds,
        "bookset_product_count": booksetProductCount,
        "bookset_product_quantity_count": booksetProductQuantityCount,
        "bookset_product_customize_quantity_count":
            booksetProductCustomizeQuantityCount,
        "bookset_customizeable_type_single_bookset_state":
            booksetCustomizeableTypeSingleBooksetState,
        "is_main_bookset_show": isMainBooksetShow,
        "total_bookset_price": totalBooksetPrice,
        "total_bookset_sale_price": totalBooksetSalePrice,
        "product_info": List<dynamic>.from(productInfo.map((x) => x.toJson())),
      };
}

class ProductInfo {
  ProductInfo({
    this.productId,
    this.productSlug,
    this.vendorSlug,
    this.categoryName,
    this.productName,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productSalePriceOg,
    this.quantity,
    this.productStockStatus,
    this.productCheck,
  });

  String productId;
  String productSlug;
  VendorSlug vendorSlug;
  CategoryName categoryName;
  String productName;
  String productPrice;
  ProductDiscount productDiscount;
  String productSalePrice;
  String productSalePriceOg;
  String quantity;
  String productStockStatus;
  String productCheck;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: vendorSlugValues.map[json["vendor_slug"]],
        categoryName: categoryNameValues.map[json["category_name"]],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDiscount: productDiscountValues.map[json["product_discount"]],
        productSalePrice: json["product_sale_price"],
        productSalePriceOg: json["product_sale_price_og"],
        quantity: json["quantity"],
        productStockStatus: json["product_stock_status"],
        productCheck: json["product_check"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlugValues.reverse[vendorSlug],
        "category_name": categoryNameValues.reverse[categoryName],
        "product_name": productName,
        "product_price": productPrice,
        "product_discount": productDiscountValues.reverse[productDiscount],
        "product_sale_price": productSalePrice,
        "product_sale_price_og": productSalePriceOg,
        "quantity": quantity,
        "product_stock_status": productStockStatus,
        "product_check": productCheck,
      };
}

enum CategoryName { CBSE_BOOKS, PENS, SCHOOL_BAG }

final categoryNameValues = EnumValues({
  "CBSE Books": CategoryName.CBSE_BOOKS,
  "Pens": CategoryName.PENS,
  "School Bag": CategoryName.SCHOOL_BAG
});

enum ProductDiscount { THE_10, THE_175, THE_20 }

final productDiscountValues = EnumValues({
  "10%": ProductDiscount.THE_10,
  "17.5%": ProductDiscount.THE_175,
  "20%": ProductDiscount.THE_20
});

enum ProductStockStatus { IN }

final productStockStatusValues = EnumValues({"IN": ProductStockStatus.IN});

enum VendorSlug { ABC_SKOOLMONK }

final vendorSlugValues =
    EnumValues({"abc-skoolmonk": VendorSlug.ABC_SKOOLMONK});

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

class VariationsDetail {
  VariationsDetail({
    this.variationName,
    this.variationsDisplay,
    this.varValue,
  });

  String variationName;
  String variationsDisplay;
  List<VarValue> varValue;

  factory VariationsDetail.fromJson(Map<String, dynamic> json) =>
      VariationsDetail(
        variationName: json["variation_name"],
        variationsDisplay: json["variations_display"],
        varValue: List<VarValue>.from(
            json["var_value"].map((x) => VarValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "variation_name": variationName,
        "variations_display": variationsDisplay,
        "var_value": List<dynamic>.from(varValue.map((x) => x.toJson())),
      };
}

class VarValue {
  VarValue({
    this.variationName,
    this.variationsDataId,
    this.variationsOptionsName,
    this.productId,
    this.varImg,
  });

  String variationName;
  String variationsDataId;
  String variationsOptionsName;
  String productId;
  String varImg;

  factory VarValue.fromJson(Map<String, dynamic> json) => VarValue(
        variationName: json["variation_name"],
        variationsDataId: json["variations_data_id"],
        variationsOptionsName: json["variations_options_name"],
        productId: json["product_id"],
        varImg: json["var_img"],
      );

  Map<String, dynamic> toJson() => {
        "variation_name": variationName,
        "variations_data_id": variationsDataId,
        "variations_options_name": variationsOptionsName,
        "product_id": productId,
        "var_img": varImg,
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
