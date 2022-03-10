// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> setData({required key, required value}) async {
    return await sharedPreferences.setString(key, value);
  }
}
