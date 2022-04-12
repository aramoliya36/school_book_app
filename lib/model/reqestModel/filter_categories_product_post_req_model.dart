class FilterCategoriesProductRequest {
  String userId;
  String filterType;
  String filterSlug;

  String count;
  String perPage;
  String page;
  String filters;
  FilterCategoriesProductRequest(
      {this.filterSlug,
      this.userId,
      this.count,
      this.filterType,
      this.page,
      this.perPage,
      this.filters});

  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "filter_type": filterType,
      "filter_slug": filterSlug,
      "count": count,
      "per_page": perPage,
      "page": page,
      "filters": filters
    };
  }
}
