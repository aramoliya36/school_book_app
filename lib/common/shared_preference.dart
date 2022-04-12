import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///fcm token
  static Future setFcmToken(String fcmToken) async {
    await getStorage.write("fcm_token", fcmToken);
  }

  static String getFcmToken() {
    return getStorage.read("fcm_token");
  }

  ///

  static Future setTokenId(String value) async {
    await getStorage.write("User_id", value);
  }

  static String getTokenId() {
    return getStorage.read("User_id");
  }

  ///fname

  static Future setFnameId(String value) async {
    await getStorage.write("fName", value);
  }

  static String getFnameId() {
    return getStorage.read("fName");
  }

  ///Lname

  static Future setLnameId(String value) async {
    await getStorage.write("lName", value);
  }

  static String getLnameId() {
    return getStorage.read("lName");
  }

  ///Lname

  static Future setEmailId(String value) async {
    await getStorage.write("Email", value);
  }

  static String getEmailId() {
    return getStorage.read("Email");
  }

  ///Mobile

  static Future setMobileId(String value) async {
    await getStorage.write("Mobile", value);
  }

  static String getMobileId() {
    return getStorage.read("Mobile");
  }

  ///app version

  static Future setAppVersion(String value) async {
    await getStorage.write("setAppVersion", value);
  }

  static String getAppVersion() {
    return getStorage.read("setAppVersion");
  }

  ///all erase
  static allClearPreferenceManager() {
    return getStorage.erase();
  }

  // static Future setPlatForm({bool value}) async{
  //   await getStorage.write("PlatForm", value);
  //
  // }
  // static getPlatForm(){
  //   return getStorage.read("PlatForm");
  // }
}
