import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/theme/dark_theme.dart';
import 'package:todo_app/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  static late SharedPreferences _sharePrefObject;
  bool _isLight = true;
  bool get isLight => _isLight;
  ThemeData get themeColor {
    _isLight = _sharePrefObject.getBool("themeData")!;
    return _isLight ? lightTheme : darkTheme;
  }

  void toogleTheme() {
    _isLight = !_isLight;
    saveThemeToSharedPref(_isLight);
    notifyListeners();
  }

  Future<void> createSharedPrefObject() async {
    _sharePrefObject = await SharedPreferences.getInstance();
  }

  void saveThemeToSharedPref(bool value) {
    _sharePrefObject.setBool("themeData", value);
  }

  void loadThemeFromSharedPref() async {
    await createSharedPrefObject();
    _isLight = _sharePrefObject.getBool("themeData") ?? true;
    /*  if (_sharePrefObject.getBool("themeData") == null) {
      _isLight = true;
    } else {
      _isLight = _sharePrefObject.getBool("themeData")!;
    } */
  }
}
