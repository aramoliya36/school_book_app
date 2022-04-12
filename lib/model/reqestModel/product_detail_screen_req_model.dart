class ProductDetailScreenModel {
  String productImg;
  String productDiscount;
  String productName;
  String productPrice;
  String productSalePrice;

  ProductDetailScreenModel._internal();

  static final ProductDetailScreenModel _singlePostRequestModel =
      ProductDetailScreenModel._internal();

  factory ProductDetailScreenModel() {
    return _singlePostRequestModel;
  }
}
