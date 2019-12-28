import 'package:flutter/material.dart';
class BaseDialog extends Dialog {
  final Widget widget;

  final double height;

  final double width;

  final EdgeInsets margin=null;

  BaseDialog(this.widget, this.height, this.width, {
    Key key,EdgeInsets margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Padding(
          padding:  const EdgeInsets.all(12.0),
          child: new Material(
            type: MaterialType.transparency,

            child: new Container(
                height:this.height,
                width:this.width,

                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ))),
                margin: margin==null? const EdgeInsets.all(10.0):margin,
                child: this.widget
            ),
          )),
    );
  }

}

