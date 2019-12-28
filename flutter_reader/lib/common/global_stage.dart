import 'package:flutter/material.dart';
import 'package:flutter_reader/common/redux/theme_redux.dart';

class GlobalStage {
  ThemeData themeData;

  GlobalStage({this.themeData});
}

GlobalStage appReducer(GlobalStage stage, action) {
  return new GlobalStage(themeData: ThemeDataReducer(stage.themeData, action));
}
