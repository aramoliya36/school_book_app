class FilterDataRequest {
  String userId;
  String catSlug;
  String count;
  String perpage;
  String page;
  String filter;
  FilterDataRequest(
      {this.filter,
      this.userId,
      this.count,
      this.catSlug,
      this.page,
      this.perpage});

  Map<String, dynamic> toJson() {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "user_id": userId,
      "cat_slug": catSlug,
      "count": count,
      "per_page": perpage,
      "page": page,
      "filters": filter
    };
  }
}
