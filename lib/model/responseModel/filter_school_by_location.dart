class FilterSchoolByLocation {
  int status;
  String message;
  int count;
  List<Response> response;

  FilterSchoolByLocation(
      {this.status, this.message, this.count, this.response});

  FilterSchoolByLocation.fromJson(Map<String, dynamic> json) {
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
  List<SchoolBanners> schoolBanners;

  Response(
      {this.schoolId,
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
      this.schoolBanners});

  Response.fromJson(Map<String, dynamic> json) {
    schoolId = json['school_id'];
    schoolSlug = json['school_slug'];
    schoolLogo = json['school_logo'];
    schoolName = json['school_name'];
    board = json['board'];
    address = json['address'];
    countries = json['countries'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    isSchoolSecure = json['is_school_secure'];
    if (json['school_banners'] != null) {
      schoolBanners = new List<SchoolBanners>();
      json['school_banners'].forEach((v) {
        schoolBanners.add(new SchoolBanners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school_id'] = this.schoolId;
    data['school_slug'] = this.schoolSlug;
    data['school_logo'] = this.schoolLogo;
    data['school_name'] = this.schoolName;
    data['board'] = this.board;
    data['address'] = this.address;
    data['countries'] = this.countries;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['is_school_secure'] = this.isSchoolSecure;
    if (this.schoolBanners != null) {
      data['school_banners'] =
          this.schoolBanners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchoolBanners {
  String schoolImg;

  SchoolBanners({this.schoolImg});

  SchoolBanners.fromJson(Map<String, dynamic> json) {
    schoolImg = json['school_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school_img'] = this.schoolImg;
    return data;
  }
}
