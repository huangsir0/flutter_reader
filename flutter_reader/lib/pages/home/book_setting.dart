import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/blocs/setting_bloc.dart';
import 'package:flutter_reader/common/global_stage.dart';
import 'package:flutter_reader/common/redux/theme_redux.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/common/utils/settings.dart';
import 'package:flutter_reader/plugins/colorpicker/material_color_picker.dart';
import 'package:flutter_reader/widgets/dialog_base.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BookSettingPage extends StatefulWidget {
  @override
  _BookSettingPageState createState() => _BookSettingPageState();
}

class _BookSettingPageState extends State<BookSettingPage> {
  GlobalKey<MaterialColorPickerState> _key =
      new GlobalKey<MaterialColorPickerState>();

  List<String> _contents = ["主题", "语言", "清除缓存", "关注以下公众号一起学习Flutter知识。。。"];

  //主题颜色
  Color _themeColor = Colors.deepPurpleAccent;
  SettingBloc _settingBloc =  new SettingBloc();

  @override
  void deactivate() {
    //_settingBloc?.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                  child:SingleChildScrollView(
                    child:  ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return index == _contents.length - 1
                              ? _getLastWidget(_contents[index])
                              : InkWell(
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  _contents[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                            onTap: () {
                              _onItemClick(context, _contents[index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                        itemCount: _contents.length),
                  ),
                )
              ],
            )),
        onWillPop: () async {
          //_settingBloc?.dispose();
          return true;
        });
  }

  Widget _themeDialog() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  StreamBuilder(
                      stream: _settingBloc.setting,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> shot) {
                        if (shot.hasData) {
                          print("shot.hasData${shot.data}");

                          return shot.data
                              ? Positioned(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                      ),
                                      onPressed: () {
                                        _key.currentState.onBack();
                                        _settingBloc.changeBackState(false);
                                      }),
                                  left: 0,
                                  top: 6,
                                )
                              : Container();
                        }

                        return Container();
                      }),
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: MaterialColorPicker(
                key: _key,
                onColorChange: (Color color) {
                  // Handle color changes
                  _themeColor = color;
                },
                shrinkWrap: true,
                onMainColorChange: (swach) {
                  print("swach");
                  _settingBloc.changeBackState(true);
                },
                selectedColor: Colors.red,
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                  Colors.deepPurple,
                ],
              ),
            )
          ],
        ),
        StoreBuilder<GlobalStage>(
          builder: (context, store) {
            return InkWell(
                onTap: () {
                  //_settingBloc.dispose();
                  AppSetting.instance.setAppTheme(_themeColor.value);
                  ThemeData themeData =
                      store.state.themeData.copyWith(primaryColor: _themeColor);
                  store.dispatch(new RefreshThemeDataAction(themeData));
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
                    "应用",
                    style: TextStyle(letterSpacing: 3, color: Colors.white),
                  ),
                ));
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _settingBloc?.dispose();
  }

  void _onItemClick(BuildContext context, String content) {
    if (content != _contents[0]) {
      toast("敬请期待\"$content\"", Theme.of(context).primaryColor);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BaseDialog(
              _themeDialog(), 250, MediaQuery.of(context).size.width * 0.6);
        });
  }

  Widget _getLastWidget(String label) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset(
              "assets/images/flutter_mark.jpg",
              width: 160,
              height: 160,
            ),
          ),
        ],
      ),
    );
  }
}
