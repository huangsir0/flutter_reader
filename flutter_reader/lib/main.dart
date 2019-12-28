import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/common/utils/screen.dart';
import 'package:flutter_reader/pages/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'common/global_stage.dart';
import 'common/redux/theme_redux.dart';
import 'common/utils/settings.dart';

void main() async {
  final value = await AppSetting.instance.getAppColor();

  print("value=${value}");

  Store<GlobalStage> store = new Store<GlobalStage>(appReducer,
      initialState: new GlobalStage(
          themeData: ThemeData(
              primaryColor: (value == null || value == 0)
                  ? Colors.deepPurpleAccent
                  : Color(value))));
  runApp(MyApp(
    store: store,
  ));
  Screen.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatelessWidget {
  final Store<GlobalStage> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreBuilder<GlobalStage>(
          builder: (context, stage) {
            return MaterialApp(
              title: 'Flutter Reader',
              theme: store.state.themeData,
              home: HomePage(),
              routes: <String, WidgetBuilder>{},
            );
          },
        ));
  }
}
