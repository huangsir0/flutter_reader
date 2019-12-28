import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
]);

class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}

///定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, RefreshThemeDataAction action) {
  themeData = action.themeData;
  return themeData;
}
