import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static writeString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String?> readString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key).toString();
  }
}
