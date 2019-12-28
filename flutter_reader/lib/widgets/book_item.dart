import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/pages/details/info_page.dart';

Widget bookItem(BuildContext context, Books book, bool isSearch) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return InfoPage(bookName: book.name, bookId: book.id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Hero(
              tag: book.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  imageUrl: book.img,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 100,
                ),
              )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 3,
                        bottom: 3,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: ShapeDecoration(
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        book.cName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: ShapeDecoration(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        book.author,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                Text(
                  book.desc,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                      fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )),
          isSearch
              ? IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                )
              : Container()
        ],
      ),
    ),
  );
}

Widget bookBeanItem(BuildContext context, BookBean book, bool isSearch) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return InfoPage(bookName: book.name, bookId: book.id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Hero(
              tag: book.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  imageUrl: book.img,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 100,
                ),
              )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: ShapeDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        book.author,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                Text(
                  book.desc,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black38,
                      fontSize: 12.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )),
          isSearch
              ? IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                )
              : Container()
        ],
      ),
    ),
  );
}
