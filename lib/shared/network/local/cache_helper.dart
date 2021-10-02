import 'package:shared_preferences/shared_preferences.dart';




class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

  static getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static clearData() {
    return sharedPreferences.clear();
  }
}