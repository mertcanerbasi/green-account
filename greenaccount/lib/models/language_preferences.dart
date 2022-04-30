import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const prefKey = "lang_key";

  setLang(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(prefKey, value);
  }

  getLang() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefKey) ?? "tr";
  }
}
