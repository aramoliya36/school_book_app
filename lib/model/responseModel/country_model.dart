class CountryModel {
  int status;
  String message;
  int count;
  List<Response> response;

  CountryModel({this.status, this.message, this.count, this.response});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      response = new List<Response>();
      json['response'].forEach((v) {
        response.add(new Response.fromJson(v));
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

class Response {
  String countryId;
  String name;
  String sortname;

  Response({this.countryId, this.name, this.sortname});

  Response.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    sortname = json['sortname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['sortname'] = this.sortname;
    return data;
  }
}
