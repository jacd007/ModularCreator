// ignore_for_file: file_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
// get Map item to shared
  static Future<Map<String, dynamic>?> getMap(String key) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    try {
      final str = prefS.getString(key) ?? '';
      final map = jsonDecode(str);
      return map;
    } on Exception catch (_) {
      return null;
    }
  }

  // get Map item to shared
  static Future<bool> setMap(String key, Object? mapValue) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    try {
      final map = jsonEncode(mapValue);
      return prefS.setString(key, map);
    } on Exception catch (_) {
      return false;
    }
  }

  // delete item to shared
  static Future<void> remove(String key) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    prefS.remove(key);
  }

  // clean all data to shared
  static Future<void> clear() async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    prefS.clear();
  }

  // getters

  static Future<String> getString(String key, [String strDefault = ""]) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    return prefS.getString(key) ?? strDefault;
  }

  static Future<int> getInt(String key, [int strDefault = -1]) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    return prefS.getInt(key) ?? strDefault;
  }

  static Future<bool> getBool(String key, [bool strDefault = false]) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    return prefS.getBool(key) ?? strDefault;
  }

  static Future<double?> getDouble(String key, [double? strDefault]) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    return prefS.getDouble(key) ?? strDefault;
  }

  static Future<List<String>> getListString(List<String> keys) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    List<String> list = [];
    for (var key in keys) {
      final value = prefS.getString(key) ?? "";
      if (value.isNotEmpty) {
        list.add(value);
      }
    }
    return list;
  }

  // setters

  static Future<void> setString(String key, String value) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    await prefS.setString(key, value);
  }

  static Future<void> setInt(String key, var value) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    await prefS.setInt(key, value);
  }

  static Future<void> setBool(String key, var value) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    await prefS.setBool(key, value);
  }

  static Future<void> setDouble(String key, var value) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    await prefS.setDouble(key, value);
  }

  static Future<void> setListString(Map<String, String> map) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    for (var i = 0; i < map.length; i++) {
      await prefS.setString(map.keys.elementAt(i), map.values.elementAt(i));
    }
  }

  // toggle
  static Future<bool> toggleKey(String key, [bool? strDefault]) async {
    SharedPreferences prefS = await SharedPreferences.getInstance();
    final value = prefS.getBool(key) ?? strDefault ?? false;
    await prefS.setBool(key, !value);
    return !value;
  }
}
