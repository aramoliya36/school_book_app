import 'package:dio/dio.dart' as dio;

class ImageUploadReq {
  String img;

  ImageUploadReq({
    this.img,
  });
  Future<Map<String, dynamic>> toJson() async {
    return {
      "client_key": "1595922666X5f1fd8bb5f662",
      "device_type": "MOB",
      "file": await dio.MultipartFile.fromFile(img),
      "folder_name": "profile"
    };
  }
}
