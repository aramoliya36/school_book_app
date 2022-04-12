// To parse this JSON data, do
//
//     final getHomePageResponse = getHomePageResponseFromJson(jsonString);

import 'dart:convert';

GetHomePageResponse getHomePageResponseFromJson(String str) =>
    GetHomePageResponse.fromJson(json.decode(str));

String getHomePageResponseToJson(GetHomePageResponse data) =>
    json.encode(data.toJson());

class GetHomePageResponse {
  GetHomePageResponse({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetHomePageResponse.fromJson(Map<String, dynamic> json) =>
      GetHomePageResponse(
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
    this.homeBanner,
    this.category,
    this.product,
    this.school,
    this.schoolBanner,
    this.publisher,
    this.responseClass,
    this.subject,
    this.brand,
    this.maintenanceScreen,
    this.popupScreen,
    this.appScreen,
    this.appConfig,
  });

  List<HomeBanner> homeBanner;
  List<Category> category;
  List<Product> product;
  List<School> school;
  List<School> schoolBanner;
  List<Brand> publisher;
  List<Brand> responseClass;
  List<Brand> subject;
  List<Brand> brand;
  List<Screen> maintenanceScreen;
  List<Screen> popupScreen;
  List<Screen> appScreen;
  List<AppConfig> appConfig;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        homeBanner: List<HomeBanner>.from(
            json["home_banner"].map((x) => HomeBanner.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        school:
            List<School>.from(json["school"].map((x) => School.fromJson(x))),
        schoolBanner: List<School>.from(
            json["school_banner"].map((x) => School.fromJson(x))),
        publisher:
            List<Brand>.from(json["publisher"].map((x) => Brand.fromJson(x))),
        responseClass:
            List<Brand>.from(json["class"].map((x) => Brand.fromJson(x))),
        subject:
            List<Brand>.from(json["subject"].map((x) => Brand.fromJson(x))),
        brand: List<Brand>.from(json["brand"].map((x) => Brand.fromJson(x))),
        maintenanceScreen: List<Screen>.from(
            json["maintenance_screen"].map((x) => Screen.fromJson(x))),
        popupScreen: List<Screen>.from(
            json["popup_screen"].map((x) => Screen.fromJson(x))),
        appScreen: List<Screen>.from(
            json["app_screen"].map((x) => Screen.fromJson(x))),
        appConfig: List<AppConfig>.from(
            json["app_config"].map((x) => AppConfig.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home_banner": List<dynamic>.from(homeBanner.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "school": List<dynamic>.from(school.map((x) => x.toJson())),
        "school_banner":
            List<dynamic>.from(schoolBanner.map((x) => x.toJson())),
        "publisher": List<dynamic>.from(publisher.map((x) => x.toJson())),
        "class": List<dynamic>.from(responseClass.map((x) => x.toJson())),
        "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
        "brand": List<dynamic>.from(brand.map((x) => x.toJson())),
        "maintenance_screen":
            List<dynamic>.from(maintenanceScreen.map((x) => x.toJson())),
        "popup_screen": List<dynamic>.from(popupScreen.map((x) => x.toJson())),
        "app_screen": List<dynamic>.from(appScreen.map((x) => x.toJson())),
        "app_config": List<dynamic>.from(appConfig.map((x) => x.toJson())),
      };
}

class AppConfig {
  AppConfig({
    this.perPage,
    this.multiFilter,
    this.multiFilterJoinString,
    this.email1,
    this.email2,
    this.mobile1,
    this.mobile2,
    this.address,
    this.termsAndConditionsLink,
    this.privacyPolicyLink,
    this.refundPolicyLink,
    this.faqLink,
    this.otherLink,
  });

  String perPage;
  String multiFilter;
  String multiFilterJoinString;
  String email1;
  String email2;
  String mobile1;
  String mobile2;
  String address;
  String termsAndConditionsLink;
  String privacyPolicyLink;
  String refundPolicyLink;
  String faqLink;
  String otherLink;

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        perPage: json["per_page"],
        multiFilter: json["multi_filter"],
        multiFilterJoinString: json["multi_filter_join_string"],
        email1: json["email1"],
        email2: json["email2"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
        address: json["address"],
        termsAndConditionsLink: json["terms_and_conditions_link"],
        privacyPolicyLink: json["privacy_policy_link"],
        refundPolicyLink: json["refund_policy_link"],
        faqLink: json["faq_link"],
        otherLink: json["other_link"],
      );

  Map<String, dynamic> toJson() => {
        "per_page": perPage,
        "multi_filter": multiFilter,
        "multi_filter_join_string": multiFilterJoinString,
        "email1": email1,
        "email2": email2,
        "mobile1": mobile1,
        "mobile2": mobile2,
        "address": address,
        "terms_and_conditions_link": termsAndConditionsLink,
        "privacy_policy_link": privacyPolicyLink,
        "refund_policy_link": refundPolicyLink,
        "faq_link": faqLink,
        "other_link": otherLink,
      };
}

class Screen {
  Screen({
    this.show,
    this.img,
    this.message,
    this.title,
  });

  String show;
  String img;
  String message;
  String title;

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
        show: json["show"],
        img: json["img"],
        message: json["message"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "show": show,
        "img": img,
        "message": message,
        "title": title == null ? null : title,
      };
}

class Brand {
  Brand({
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

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        filterId: json["filter_id"],
        filterSlug: json["filter_slug"],
        filterName: json["filter_name"],
        filterImg: json["filter_img"],
        filterType: filterTypeValues.map[json["filter_type"]],
      );

  Map<String, dynamic> toJson() => {
        "filter_id": filterId,
        "filter_slug": filterSlug,
        "filter_name": filterName,
        "filter_img": filterImg,
        "filter_type": filterTypeValues.reverse[filterType],
      };
}

enum FilterType { BRAND, CLASS, PUBLISHER, SUBJECT }

final filterTypeValues = EnumValues({
  "brand": FilterType.BRAND,
  "class": FilterType.CLASS,
  "publisher": FilterType.PUBLISHER,
  "subject": FilterType.SUBJECT
});

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
        categoryId: json["category_id"],
        catSlug: json["cat_slug"],
        categoryName: json["category_name"],
        categoryImg: json["category_img"],
        productCount: json["product_count"],
        isSubcategoryExits: json["is_subcategory_exits"],
        isFilterExits: json["is_filter_exits"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "cat_slug": catSlug,
        "category_name": categoryName,
        "category_img": categoryImg,
        "product_count": productCount,
        "is_subcategory_exits": isSubcategoryExits,
        "is_filter_exits": isFilterExits,
      };
}

class HomeBanner {
  HomeBanner({
    this.homeBannerId,
    this.img,
    this.action,
    this.slug,
    this.text,
    this.link,
  });

  String homeBannerId;
  String img;
  String action;
  String slug;
  String text;
  String link;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
        homeBannerId: json["home_banner_id"],
        img: json["img"],
        action: json["action"],
        slug: json["slug"],
        text: json["text"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "home_banner_id": homeBannerId,
        "img": img,
        "action": action,
        "slug": slug,
        "text": text,
        "link": link,
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
  List<dynamic> filters;
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
        filters: List<dynamic>.from(json["filters"].map((x) => x)),
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
        "filters": List<dynamic>.from(filters.map((x) => x)),
        "variations_details":
            List<dynamic>.from(variationsDetails.map((x) => x)),
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "bookset_details": List<dynamic>.from(booksetDetails.map((x) => x)),
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

class School {
  School({
    this.schoolId,
    this.schoolSlug,
    this.schoolLogo,
    this.schoolName,
    this.board,
    this.isSchoolSecure,
    this.schoolBanners,
    this.schoolBanner,
  });

  String schoolId;
  String schoolSlug;
  String schoolLogo;
  String schoolName;
  String board;
  String isSchoolSecure;
  List<SchoolBanner> schoolBanners;
  String schoolBanner;

  factory School.fromJson(Map<String, dynamic> json) => School(
        schoolId: json["school_id"],
        schoolSlug: json["school_slug"],
        schoolLogo: json["school_logo"],
        schoolName: json["school_name"],
        board: json["board"],
        isSchoolSecure: json["is_school_secure"],
        schoolBanners: json["school_banners"] == null
            ? null
            : List<SchoolBanner>.from(
                json["school_banners"].map((x) => SchoolBanner.fromJson(x))),
        schoolBanner:
            json["school_banner"] == null ? null : json["school_banner"],
      );

  Map<String, dynamic> toJson() => {
        "school_id": schoolId,
        "school_slug": schoolSlug,
        "school_logo": schoolLogo,
        "school_name": schoolName,
        "board": board,
        "is_school_secure": isSchoolSecure,
        "school_banners": schoolBanners == null
            ? null
            : List<dynamic>.from(schoolBanners.map((x) => x.toJson())),
        "school_banner": schoolBanner == null ? null : schoolBanner,
      };
}

class SchoolBanner {
  SchoolBanner({
    this.schoolImg,
  });

  String schoolImg;

  factory SchoolBanner.fromJson(Map<String, dynamic> json) => SchoolBanner(
        schoolImg: json["school_img"],
      );

  Map<String, dynamic> toJson() => {
        "school_img": schoolImg,
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
