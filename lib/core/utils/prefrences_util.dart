import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String isDark = 'isDark';
  static const String languageCode = 'language_code';
}


class SharedPreferenceUtils {
  static SharedPreferences? prefs;

  static Future<SharedPreferences?> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static String? getString(String key) {
    try {
      return prefs!.getString(key);
    } catch (e) {
      return null;
    }
  }

  static int? getInt(String key) {
    try {
      return prefs!.getInt(key);
    } catch (e) {
      return null;
    }
  }

  static bool? getBool(String key) {
    try {
      return prefs!.getBool(key);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool?> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.setString(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool?> setInt(String key, int value) async {
    try {
      return prefs!.setInt(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      print(key);
      return await prefs!.setBool(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> putStringList(String key, List<String> list) async {
    return prefs!.setStringList(key, list);
  }

  static List<String>? getStringList(String key) {
    return prefs!.getStringList(key);
  }

  static Future<bool?> putObjectList(String key, List<Object> list) async {
    if (prefs == null) return null;
    List<String>? _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return prefs!.setStringList(key, _dataList);
  }

  static List<T>? getObjList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    if (prefs == null) return null;
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  static List<Map>? getObjectList(String key) {
    if (prefs == null) return null;
    List<String>? dataList = prefs?.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }
}