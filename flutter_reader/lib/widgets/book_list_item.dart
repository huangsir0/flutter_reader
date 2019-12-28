import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_item_bean.dart';
import 'package:flutter_reader/pages/details/list_detail_page.dart';

Widget bookListItem(BuildContext context, int index, BookItemBean book) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ListDetialPage(listId: book.ListId.toString());
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      height: 100.0,
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Hero(
              tag: book.ListId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  imageUrl: book.Cover,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 80,
                ),
              )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.Title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  book.Description,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                      fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          ))
        ],
      ),
    ),
  );
}
