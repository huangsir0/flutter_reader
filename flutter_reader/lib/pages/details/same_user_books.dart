import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/widgets/same_user_bookitem.dart';

class SameUserBooksPage extends StatelessWidget {
 final List<SameUserBooks> sameUserBooksBeans;

  SameUserBooksPage(this.sameUserBooksBeans);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("作者还写过"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return sameUserBookItem(context, index, sameUserBooksBeans[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return new Divider(
            height: 1.0,
            color: Colors.black12,
          );
        },
        itemCount: sameUserBooksBeans.length,
      ),
    );
  }
}
