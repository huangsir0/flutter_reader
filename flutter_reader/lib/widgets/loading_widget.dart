import 'package:flutter/material.dart';

import 'delay_tween.dart';

class WaitingWidget extends StatefulWidget  {

  final Color color;

  const WaitingWidget({Key key, this.color}) : super(key: key);

  @override
  _WaitingWidgetState createState() => _WaitingWidgetState();
}



class _WaitingWidgetState extends State<WaitingWidget> with SingleTickerProviderStateMixin{

  AnimationController animationController;

  double size=50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=new AnimationController(vsync: this,duration: Duration(seconds: 2))..repeat();
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    animationController.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(size*2, size*1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _itemWidget('W',0),
            _itemWidget('a',0.2),
            _itemWidget('i',0.4),
            _itemWidget('t',0.6),
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(String char, double delay) {
    final _size=size*0.5;
    return ScaleTransition(scale: DelayTween(
      begin: 0.0,end: 1.0,delay: delay
    ).animate(animationController),
    child: SizedBox.fromSize(
      size: Size(_size, _size*2),
      child: Container(
        alignment: Alignment.center,
        child: Text(char,style: TextStyle(fontSize: 20,color: this.widget.color),),
      ),
    ),
    );
  }
}
