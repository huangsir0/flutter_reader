import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/beans/book_item_bean.dart';
import 'package:flutter_reader/blocs/map_bloc.dart';
import 'package:flutter_reader/widgets/book_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

class ListDetialPage extends StatefulWidget {
  final String listId;

  const ListDetialPage({Key key, this.listId}) : super(key: key);

  @override
  _ListDetialPageState createState() => _ListDetialPageState();
}

class _ListDetialPageState extends State<ListDetialPage>
    with AutomaticKeepAliveClientMixin {
  BookItemBean _bookItemBean;

  bool _isExpanded = false;

  List<BookBean> _books = List();

  MapBloc _mapBloc = new MapBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapBloc.fetchListDetailData(widget.listId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StreamBuilder(
        stream: _mapBloc.storeMap,
          builder: (BuildContext context, AsyncSnapshot<Map> content) {
        if (content.hasData) {
          if (content.data['data'] != null) {
            _bookItemBean = BookItemBean.fromMap(content.data['data']);
            for (int i = 0; i < content.data['data']['BookList'].length; i++) {
              _books.add(BookBean.fromListDetailMap(
                  content.data['data']['BookList'][i]));
            }
            return NestedScrollView(
              headerSliverBuilder: _sliverBuilder,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _desc(),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return new Divider(
                          height: 1.0,
                          color: Colors.black12,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return bookBeanItem(context, _books[index], false);
                      },
                      itemCount: _books.length,
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: WaitingWidget(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        } else {
          return Center(
            child: WaitingWidget(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      }),
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
                        _bookItemBean.Description,
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


  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        expandedHeight: 220.0,
        //展开高度200
        floating: false,
        //不随着滑动隐藏标题
        pinned: true,
        //固定在顶部
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    _bookItemBean.Cover,
                  ),
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
  Widget _info() {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: widget.listId,
            child: CachedNetworkImage(
              imageUrl: _bookItemBean.Cover,
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
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Text(
                  _bookItemBean.Title,
                  maxLines:1,
                  overflow: TextOverflow.ellipsis,
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
                    _infoText(_bookItemBean.UpdateTime),
                    Icon(
                      Icons.fiber_manual_record,
                      size: 6,
                      color: Colors.white,
                    ),
                    _infoText("共 ${_books.length.toString()} 本"),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapBloc.dispose();
  }
}
