import 'package:flutter/material.dart';
class VerticalWidget extends StatelessWidget {
  final bool isSelect;
  final String label;
  final Color selectedColor;
  final ValueChanged<bool> onSelected;

  const VerticalWidget(
      {Key key, this.isSelect, this.label, this.onSelected, this.selectedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isSelect
            ? Container(
          margin: EdgeInsets.only(left: 1),
          height: 30,
          color: selectedColor,
          width: 2,
        )
            : Container(),
        Expanded(
            child: Material(
              child: InkWell(
                onTap: () {
                  if (null != this.onSelected) onSelected(true);
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 2),
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: isSelect ? Colors.white : Colors.grey[200],
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                        color: isSelect ? selectedColor : Colors.black,
                        letterSpacing: 5,
                        fontSize: 14),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}