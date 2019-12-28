import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/widgets/same_category_book_item.dart';


class SameCategoryBooksPage extends StatelessWidget {
 final List<SameCategoryBooks> sameCategoryBooks;

  SameCategoryBooksPage(this.sameCategoryBooks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("同类型推荐"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return sameCategoryBookItem(context, index, sameCategoryBooks[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return new Divider(
            height: 1.0,
            color: Theme.of(context).primaryColor,
          );
        },
        itemCount: sameCategoryBooks.length,
      ),
    );
  }
}