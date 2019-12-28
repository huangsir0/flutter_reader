import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/blocs/book_shelf_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/widgets/book_shelf_item.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf>
    with AutomaticKeepAliveClientMixin {
  BookShelfBloc _bookBloc = BookShelfBloc();

  bool _isInit = true;

  List<BookBean> _books = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isInit = true;
    _bookBloc.fetcherBooks();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40, left: 20,right: 10),
                height: kToolbarHeight + 20,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "书架",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(

                        MyIcons.searchIcon,
                        color:Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        toast("跳转到搜索页面。。。", Theme.of(context).primaryColor);
                      },
                    )
                  ],
                )),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: StreamBuilder(
                      stream: _bookBloc.bookShelf,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<BookBean>> content) {
                        if (content.hasData &&
                            content.data != null &&
                            content.data.length > 0) {
                          _books.clear();
                          _books.addAll(content.data);
                          if (_isInit) _onRefresh();
                          return RefreshIndicator(
                              displacement:20 ,
                              color: Theme.of(context).primaryColor,
                              child: ListView.separated(
                                  itemBuilder: (BuildContext context, int index) {
                                    return bookShelfItem(context,
                                        content.data[index], showAlertDartDialog);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      height: 2,
                                      color: Theme.of(context).primaryColor,
                                    );
                                  },
                                  itemCount: content.data.length),
                              onRefresh: _onRefresh);
                        } else {
                          return Center(
                            child: Text(
                              "这个人贼懒",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w200,
                                fontSize: 18.0,
                              ),
                            ),
                          );
                        }
                      }),
                )),
          ],
        ));
  }

  void showAlertDartDialog(BookBean book) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text("提示"),
              content: Text("是否删除${book.name}?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("返回")),
                FlatButton(
                    onPressed: () {
                      _bookBloc.deleteBook(book.id);
                      _isInit = false;
                      Navigator.of(context).pop();
                      _bookBloc.fetcherBooks();
                    },
                    child: Text("确定"))
              ],
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _bookBloc.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



  Future<void> _onRefresh() async {
    _books.forEach((book) {
      _bookBloc.updateBook(book.id);
    });
  }
}
