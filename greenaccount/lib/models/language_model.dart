import 'package:flutter/material.dart';
import 'package:greenaccount/models/language_preferences.dart';

class LanguageModel extends ChangeNotifier {
  late String _lang;
  late LanguagePreferences _preferences;
  String get lang => _lang;

  LanguageModel() {
    _lang = "tr";
    _preferences = LanguagePreferences();
    getPreferences();
  }

  //Switching themes in the flutter apps - Flutterant
  set lang(String value) {
    _lang = value;
    _preferences.setLang(value);
    notifyListeners();
  }

  getPreferences() async {
    _lang = await _preferences.getLang();
    notifyListeners();
  }
}
