import 'package:shared_preferences/shared_preferences.dart';

class AppSetting{
  //需要存储值的Key
  static const app_theme_color = "appThemeColor";

  static AppSetting get instance => _getInstance();

  //带下划线的是私有变量
  static AppSetting _instance;

  // 构造
  AppSetting._internal() {}

  static _getInstance() {
    if (null == _instance) _instance = AppSetting._internal();
    return _instance;
  }


  Future<void> setAppTheme(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(app_theme_color, value);

    return null;
  }


  Future<int> getAppColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(app_theme_color);
  }




}