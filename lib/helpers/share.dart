import 'package:shared_preferences/shared_preferences.dart';

class Share {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _preferences;

  // set available at the first time
  static void init() async {
    _preferences = await _prefs;
  }

  // delete all key in shared preference
  static void dispose() {
    _prefs = null;
    _preferences = null;
  }

  // clear all keys shared preference
  static Future<bool> clear() async {
    var instance = await _prefs;
    return instance.clear();
  }

  // function get data from key
  static Set<String> getAllKeys() {
    return _preferences.getKeys();
  }

  static dynamic getDynamic(String key) {
    return _preferences.get(key);
  }

  static bool getBool(String key) {
    if (_preferences == null || _preferences.getBool(key) == null) {
      return false;
    } else {
      return _preferences.getBool(key);
    }
  }

  static int getInt(String key) {
    return _preferences.getInt(key);
  }

  static double getDouble(String key) {
    return _preferences.getDouble(key);
  }

  static String getString(String key) {
    if (_preferences == null || _preferences.getString(key) == null) {
      return "";
    } else {
      return _preferences.getString(key);
    }
  }

  static List<String> getList(String key) {
    return _preferences.getStringList(key);
  }

  // function set value by key into preference
  static Future<bool> setBool(String key, bool value) async {
    var instance = await _prefs;
    return instance.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    var instance = await _prefs;
    return instance.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    var instance = await _prefs;
    return instance.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    var instance = await _prefs;
    return instance.setString(key, value);
  }

  static Future<bool> setList(String key, List<String> value) async {
    var instance = await _prefs;
    return instance.setStringList(key, value);
  }
}
