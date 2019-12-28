import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/pages/details/read_page.dart';

Widget bookShelfItem(
    BuildContext context, BookBean book, ValueChanged<BookBean> longPress) {
  return InkWell(
    onLongPress: () {
      if (null != longPress) longPress(book);
    },
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ReadPage(book.id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      height: 100.0,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: book.img,
              width: 80,
              height: 120,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.author,
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.lastChapter,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                        fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.updateTime,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                        fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
