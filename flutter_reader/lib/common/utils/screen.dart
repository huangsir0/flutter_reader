import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Screen {
  //一些固定的配置参数
  static final double width = 1080;//px
  static final double height = 1920;//px
  static final bool allowFontScaling = false;


  ///当前设备宽度 dp
  static  double _screenWidthDp;
  ///当前设备高度 dp
  static double _screenHeightDp;

  ///设备的像素密度
  static double _screenPixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  static double _topSafeHeight;
  ///底部安全区距离 dp
  static double _bottomSafeHeight;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double _textScaleFactory;

  static void init(){
    MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);
    _screenWidthDp=mediaQueryData.size.width;
    _screenHeightDp=mediaQueryData.size.height;
    _screenPixelRatio=mediaQueryData.devicePixelRatio;
    _topSafeHeight=mediaQueryData.padding.top;
    _bottomSafeHeight=mediaQueryData.padding.bottom;
    _textScaleFactory=mediaQueryData.textScaleFactor;
  }

  ///当前设备宽度 dp
  static double get screenWidthDp =>_screenWidthDp;

  ///当前设备高度 dp
  static double get screenHeightDp =>_screenHeightDp;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidthDp * _screenPixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeightDp * _screenPixelRatio;

  ///设备的像素密度
  static double get screenPixelRatio =>_screenPixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  static double get topSafeHeight=>_topSafeHeight;

  ///底部安全区距离 dp
  static double get bottomSafeHeight =>_bottomSafeHeight;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory =>_textScaleFactory;

  ///ToolBarHeight +status高度
  static double get navigationBarHeight =>_topSafeHeight+toolBarHeight;

  ///TooBar高度
  static double get toolBarHeight =>kToolbarHeight;


  ///实际的dp与设计稿px 的比例

  static get scaleWidth => screenWidthDp / width;

  static get scaleHeight => screenHeightDp / height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  static setWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  static setHeight(double height) => height * scaleHeight;
  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  static setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / textScaleFactory;


}
