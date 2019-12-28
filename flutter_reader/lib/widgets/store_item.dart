import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/store_sex_bean.dart';

import 'book_item_card.dart';

Widget storeItem(BuildContext context, String title, List<Books> books) {
  return (books==null|| books.length == 0)
      ? Container()
      : Card(
    margin: EdgeInsets.all(5.0),
    child: Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 25, top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18,color: Theme.of(context).primaryColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context,books[0]),
                      bookItemCard(context,books[1]),
                      bookItemCard(context,books[2]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context,books[3]),
                      bookItemCard(context,books[4]),
                      bookItemCard(context,books[5]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
