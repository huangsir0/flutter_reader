import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/comment_bean.dart';

import 'package:intl/intl.dart';

Widget commentItem(BuildContext context, CommentsBean comment) {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: CachedNetworkImage(
                    imageUrl: comment.passport.imgUrl,
                    width: 60,
                    height: 60,
                    errorWidget: (context, url, error) => Icon(
                          Icons.account_circle,
                          size: 60,
                        )),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      comment.passport.nickname,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd  HH:mm:ss').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              comment.createTime)),
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              comment.content,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14.0),
            ),
          )
        ],
      ),
    ),
  );
}
