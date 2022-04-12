class StateModel {
  int status;
  String message;
  int count;
  List<Response> response;

  StateModel({this.status, this.message, this.count, this.response});

  StateModel.fromJson(Map<String, dynamic> json) {
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
  String stateId;
  String name;
  String countryId;

  Response({this.stateId, this.name, this.countryId});

  Response.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}
