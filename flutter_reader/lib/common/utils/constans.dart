import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppColors {


  static const DayModeMenuBgColor = Color(0xffccb992);
  static const NightModeMenuBgColor = Colors.grey;

  static const DayModeIconTitleButtonColor = Color(0xff986600);
  static const NightModeIconTitleButtonColor = Colors.white;

  static const DayModeActiveTrackColor = Color(0xff986600);
  static const NightModeActiveTrackColor = Colors.white;

  static const DayModeInactiveTrackColor = Color(0xffdbcba8);
  static const NightModeInactiveTrackColor = Colors.grey;

  static const DayModeBgColor = Color(0xffdbcba8);
  static const NightModeBgColor = Color(0xff0d0c0d);

  static const DayModeTextColor = Colors.black87;
  static const NightModeTextColor = Colors.white70;
}

class MyIcons {
  static const IconData shelfIcon = Icons.book;
  static const IconData storeIcon = Icons.store;
  static const IconData rankIcon = Icons.insert_chart;
  static const IconData foundIcon = Icons.navigation;
  static const IconData shelfManageIcon = Icons.more_vert;
  static const IconData shelfUserIcon = Icons.account_circle;
  static const IconData backIcon = Icons.arrow_back_ios;
  static const IconData searchIcon = Icons.search;
  static const IconData nextIcon = Icons.navigate_next;

  static const IconData home_setting =Icons.settings;
}



class StringConstants {

  static const String image_base_url =
      "http://www.apporapp.cc/BookFiles/BookImages/";
  static const String image_base_url2 =
      "https://imgapi.jiaston.com/BookFiles/BookImages/";
  static const String image_base_url3 = "http://statics.zhuishushenqi.com/";

  static const List<String> categoryImages = [
    "taigushenwang",
    "yinianyongheng",
    "nitiantoushiyan",
    "daming1617",
    "maoshanzhuoguiren",
    "wangyouzhizuiqiangwaigua",
    "yulingnvdao",
    "shijiancaokongshi",
  ];
}


String getCompleteImgUrl(String url) {
  if (url.contains(StringConstants.image_base_url) ||
      url.contains(StringConstants.image_base_url2) ||
      url.contains(StringConstants.image_base_url3))
    return url;
  else
    return StringConstants.image_base_url2 + url;
}


toast(String msg,Color color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      // ignore: undefined_identifier
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

