import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/blocs/book_info_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/pages/details/read_page.dart';
import 'package:flutter_reader/pages/details/same_category_books.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

import 'catalog_page.dart';
import 'comment.dart';

class InfoPage extends StatefulWidget {
  final String bookName;

  final int bookId;

  const InfoPage({Key key, this.bookName, this.bookId}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  BookInfoBean _bookInfo;

  bool _isExpanded = false;

  BookInfoBloc _bookInfoBloc = new BookInfoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookInfoBloc.fetchBookInfo(widget.bookId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookInfoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<BookInfoBean> content) {
        if (content.hasData) {
          _bookInfo = content.data;
          _bookInfoBloc.queryIsAdd(_bookInfo.data.id);
          return _buildNestedScrollView(content.data);
        } else {
          return Center(
              child: WaitingWidget(
            color: Theme.of(context).primaryColor,
          ));
        }
      },
      stream: _bookInfoBloc.storeSexData,
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  NestedScrollView _buildNestedScrollView(BookInfoBean book) {
    return NestedScrollView(headerSliverBuilder: _sliverBuilder, body: _body());
  }

  List<Widget> _sliverBuilder(BuildContext contrxt, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        expandedHeight: 220,
        floating: false,
        pinned: true,
        title: Text("${_bookInfo.data.name}详情"),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: CachedNetworkImageProvider(_bookInfo.data.img),
                  fit: BoxFit.cover,
                )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              Positioned(
                child: _info(),
                left: 40,
                top: 120,
              ),
            ],
          ),
        ),
      )
    ];
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _desc(),
              _catalog(),
              _author(),
              _category(),
              _comment(),
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot<bool> isAdd) {
                    if (isAdd.hasData) {
                      return GestureDetector(
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              isAdd.data
                                  ? Icon(Icons.check,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))
                                  : Icon(
                                      Icons.add,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8),
                                    ),
                              isAdd.data
                                  ? Text(
                                      "已添加",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.8)),
                                    )
                                  : Text(
                                      "加入书架",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.8)),
                                    ),
                            ],
                          ),
                        ),
                        onTap: isAdd.data
                            ? () {
                                print("删除");
                                _bookInfoBloc.removeBook(_bookInfo.data.id);
                              }
                            : () {
                                print("添加");

                                _bookInfoBloc.addBook(_bookInfo);
                              },
                      );
                    } else {
                      return Container();
                    }
                  },
                  stream: _bookInfoBloc.addStoreState,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ReadPage(widget.bookId);
                    }));
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    child: Center(
                      child: Text(
                        "立即阅读",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottom: 0,
        ),
      ],
    );
  }

  Widget _info() {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: widget.bookId,
            child: CachedNetworkImage(
              imageUrl: _bookInfo.data.img,
              width: 90,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  _bookInfo.data.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _infoText(_bookInfo.data.author),
                    Icon(
                      Icons.fiber_manual_record,
                      size: 6,
                      color: Colors.white,
                    ),
                    _infoText(_bookInfo.data.cName),
                    Icon(
                      Icons.fiber_manual_record,
                      size: 6,
                      color: Colors.white,
                    ),
                    _infoText(_bookInfo.data.bookStatus),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoText(String content) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 14.0,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _desc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            "作品简介",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Card(
              elevation: 0,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _bookInfo.data.desc,
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.black54,
                            fontSize: 18.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: _isExpanded ? 1000 : 3,
                      ),
                    ),
                    _isExpanded
                        ? Container()
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.expand_more,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _catalog() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return CatalogPage(_bookInfo.data.id);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(
                  "目录",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _bookInfo.data.lastChapter,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        _bookInfo.data.lastTime,
                        style: TextStyle(
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
          ),
        ),
      ),
    );
  }

  Widget _author() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return SameCategoryBooksPage(_bookInfo.data.sameCategoryBooks);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "作者 - ${_bookInfo.data.author}",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                Text(
                    "共有${_bookInfo.data.sameUserBooks.length.toString()}本作者相关书籍"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return SameCategoryBooksPage(_bookInfo.data.sameCategoryBooks);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "类型 - ${_bookInfo.data.cName}",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                    "共有${_bookInfo.data.sameCategoryBooks.length.toString()}本同类型推荐书籍"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comment() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CommentPage(bookInfo: _bookInfo);
          }));
        },
        child: Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "查看评论",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                IconButton(
                  icon: Icon(MyIcons.nextIcon),
                  onPressed: () {
                    toast("。。。", Theme.of(context).primaryColor);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
