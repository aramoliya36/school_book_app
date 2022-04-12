class SearchProductModel {
  int status;
  String message;
  int count;
  List<ProductResponse> response;

  SearchProductModel({this.status, this.message, this.count, this.response});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      response = new List<ProductResponse>();
      json['response'].forEach((v) {
        response.add(new ProductResponse.fromJson(v));
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

class ProductResponse {
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
  List<ProductImgs> productImgs;
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
  List<Filters> filters;
  List<String> variationsDetails;
  List<String> additionalSetDetails;
  List<String> booksetDetails;

  ProductResponse(
      {this.productId,
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
      this.booksetDetails});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSlug = json['product_slug'];
    vendorSlug = json['vendor_slug'];
    schoolSlug = json['school_slug'];
    type = json['type'];
    productType = json['product_type'];
    variation = json['variation'];
    additionalSet = json['additional_set'];
    categoryName = json['category_name'];
    howManyVariation = json['how_many_variation'];
    productImg = json['product_img'];
    if (json['product_imgs'] != null) {
      productImgs = new List<ProductImgs>();
      json['product_imgs'].forEach((v) {
        productImgs.add(new ProductImgs.fromJson(v));
      });
    }
    productName = json['product_name'];
    language = json['language'];
    bookType = json['book_type'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productSalePrice = json['product_sale_price'];
    productAdditionalSetTotalPrice = json['product_additional_set_total_price'];
    quantity = json['quantity'];
    productStockStatus = json['product_stock_status'];
    productSpecification = json['product_specification'];
    productDescription = json['product_description'];
    showDisclaimer = json['show_disclaimer'];
    showDisclaimerText = json['show_disclaimer_text'];
    vendorCompanyName = json['vendor_company_name'];
    productInUserWishlist = json['product_in_user_wishlist'];
    productInUserCart = json['product_in_user_cart'];
    productInUserCartQuantity = json['product_in_user_cart_quantity'];
    productShareLink = json['product_share_link'];
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
/*    if (json['variations_details'] != null) {
      variationsDetails = new List<Null>();
      json['variations_details'].forEach((v) {
        variationsDetails.add(new String.fromJson(v));
      });
    }
    if (json['additional_set_details'] != null) {
      additionalSetDetails = new List<Null>();
      json['additional_set_details'].forEach((v) {
        additionalSetDetails.add(new Null.fromJson(v));
      });
    }
    if (json['bookset_details'] != null) {
      booksetDetails = new List<Null>();
      json['bookset_details'].forEach((v) {
        booksetDetails.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_slug'] = this.productSlug;
    data['vendor_slug'] = this.vendorSlug;
    data['school_slug'] = this.schoolSlug;
    data['type'] = this.type;
    data['product_type'] = this.productType;
    data['variation'] = this.variation;
    data['additional_set'] = this.additionalSet;
    data['category_name'] = this.categoryName;
    data['how_many_variation'] = this.howManyVariation;
    data['product_img'] = this.productImg;
    if (this.productImgs != null) {
      data['product_imgs'] = this.productImgs.map((v) => v.toJson()).toList();
    }
    data['product_name'] = this.productName;
    data['language'] = this.language;
    data['book_type'] = this.bookType;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_sale_price'] = this.productSalePrice;
    data['product_additional_set_total_price'] =
        this.productAdditionalSetTotalPrice;
    data['quantity'] = this.quantity;
    data['product_stock_status'] = this.productStockStatus;
    data['product_specification'] = this.productSpecification;
    data['product_description'] = this.productDescription;
    data['show_disclaimer'] = this.showDisclaimer;
    data['show_disclaimer_text'] = this.showDisclaimerText;
    data['vendor_company_name'] = this.vendorCompanyName;
    data['product_in_user_wishlist'] = this.productInUserWishlist;
    data['product_in_user_cart'] = this.productInUserCart;
    data['product_in_user_cart_quantity'] = this.productInUserCartQuantity;
    data['product_share_link'] = this.productShareLink;
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
/*    if (this.variationsDetails != null) {
      data['variations_details'] =
          this.variationsDetails.map((v) => v.toJson()).toList();
    }
    if (this.additionalSetDetails != null) {
      data['additional_set_details'] =
          this.additionalSetDetails.map((v) => v.toJson()).toList();
    }
    if (this.booksetDetails != null) {
      data['bookset_details'] =
          this.booksetDetails.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class ProductImgs {
  String productImg;

  ProductImgs({this.productImg});

  ProductImgs.fromJson(Map<String, dynamic> json) {
    productImg = json['product_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_img'] = this.productImg;
    return data;
  }
}

class Filters {
  String filterTypeName;
  String filterTypeSlug;
  List<FilterData> filterData;

  Filters({this.filterTypeName, this.filterTypeSlug, this.filterData});

  Filters.fromJson(Map<String, dynamic> json) {
    filterTypeName = json['filter_type_name'];
    filterTypeSlug = json['filter_type_slug'];
    if (json['filter_data'] != null) {
      filterData = new List<FilterData>();
      json['filter_data'].forEach((v) {
        filterData.add(new FilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_type_name'] = this.filterTypeName;
    data['filter_type_slug'] = this.filterTypeSlug;
    if (this.filterData != null) {
      data['filter_data'] = this.filterData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterData {
  String filterId;
  String filterSlug;
  String filterName;
  String filterImg;
  String filterType;

  FilterData(
      {this.filterId,
      this.filterSlug,
      this.filterName,
      this.filterImg,
      this.filterType});

  FilterData.fromJson(Map<String, dynamic> json) {
    filterId = json['filter_id'];
    filterSlug = json['filter_slug'];
    filterName = json['filter_name'];
    filterImg = json['filter_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_id'] = this.filterId;
    data['filter_slug'] = this.filterSlug;
    data['filter_name'] = this.filterName;
    data['filter_img'] = this.filterImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}
