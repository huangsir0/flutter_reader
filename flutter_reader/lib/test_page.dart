import 'package:flutter/material.dart';
import 'package:flutter_reader/blocs/setting_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/plugins/colorpicker/material_color_picker.dart';
import 'package:flutter_reader/widgets/dialog_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  SettingBloc _settingBloc = new SettingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 10),
                height: kToolbarHeight + 20,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "设置",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                  ],
                )),
            Expanded(
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BaseDialog(_themeDialog(), 250, 320);
                        });
                  },
                  child: Text("Test"),
                ),
              ),
            )
          ],
        ));
  }

  Widget _themeDialog() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: _settingBloc.setting,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> shot) {
                  if (shot.hasData) {
                    print("shot.hasData= ${shot.hasData}");
                    return Container(
                      height: 60,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          shot.data
                              ? Positioned(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                      ),
                                      onPressed: () {
                                        _settingBloc.changeBackState(false);
                                      }),
                                  left: 0,
                                  top: 6,
                                )
                              : Container(),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "主题设置",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("shot.hasData forever true")),
            RaisedButton(
              onPressed: () {
                _settingBloc.changeBackState(true);
              },
              child: Text("Change State"),
            )
          ],
        ),
        InkWell(
            onTap: () {
              Navigator.of(context).pop(this);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).primaryColor
                  ]),
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor),
              child: Text(
                "apply",
                style: TextStyle(letterSpacing: 3, color: Colors.white),
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _settingBloc.dispose();
  }
}
