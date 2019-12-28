import 'package:flutter/material.dart';

class ReloadWidget extends StatelessWidget {
  RefreshCallback refresh;

  ReloadWidget({Key key, @required this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          if (null != refresh) {
            refresh();
          }
        },
        child: Container(
          height: 200,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/images/loadfail.png",
                  width: 160,
                  height: 160,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text("点我重新加载")
            ],
          ),
        ),
      ),
    );
  }
}
