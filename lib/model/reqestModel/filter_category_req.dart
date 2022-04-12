class FilterCategoryReq {
  String userId;
  String catSlug;
  String boolCount;
  String perPage;
  String page;
  String filters;

  FilterCategoryReq(
      {this.filters,
      this.page,
      this.perPage,
      this.boolCount,
      this.userId,
      this.catSlug});
  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "cat_slug": catSlug,
      "count": boolCount,
      "per_page": perPage,
      "page": page,
      "filters": filters
    };
  }
}
