import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_reader/beans/book_item_bean.dart';
import 'package:flutter_reader/blocs/book_list_bloc.dart';
import 'package:flutter_reader/common/utils/screen.dart';
import 'package:flutter_reader/widgets/book_list_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';
import 'package:flutter_reader/widgets/vertical_widget.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _kindsTitles = ["最新发布", "本周最热", "最多收藏", "小编推荐"];

  List<String> _Kinds = ["new", "hot", "collect", "commend"];

  //当前类别
  String _curKind = "new";

  //当前心别
  String _curSex = "man";

  //当前页
  int _curPage = 1;
  TabController _tabController;

  //标识是否加载更多
  bool _isLoadMore = false;

  BookListBloc _bookListBloc = new BookListBloc();

  List<BookItemBean> _books = List();

  final ScrollController _scrollController = new ScrollController();

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  Iterable<Widget> get kindSelects sync* {
    for (String kind in _Kinds) {
      yield VerticalWidget(
        selectedColor: Theme.of(context).primaryColor,
        label: _kindsTitles[_Kinds.indexOf(kind)],
        isSelect: _curKind == kind,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _isLoadMore = false;
              _curPage = 1;
              _curKind = kind;
              _bookListBloc.fetchBookList(_curSex, _curKind, _curPage);
              print(_curKind);
            }
          });
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        new TabController(length: _kindsTitles.length, vsync: this);
    _isLoadMore = false;
    _bookListBloc.fetchBookList(_curSex, _curKind, _curPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            width: 100,
            child: Column(
              children: kindSelects.toList(),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.white10,
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: Screen.screenWidth - 200,
                  child: CupertinoSegmentedControl(
                    borderColor: Colors.white10,
                    unselectedColor: Colors.grey[500],
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.8),
                    children: {
                      'man': Text(
                        "男生",
                        style: TextStyle(color: Colors.white),
                      ),
                      'lady': Text("女生", style: TextStyle(color: Colors.white))
                    },
                    onValueChanged: (key) {
                      setState(() {
                        _curSex = key;
                        _isLoadMore = false;
                        _bookListBloc.fetchBookList(
                            _curSex, _curKind, _curPage);
                        print(_curSex);
                      });
                    },
                    groupValue: _curSex,
                  ),
                ),
                StreamBuilder(
                    stream: _bookListBloc.bookListStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BookItemBean>> content) {
                      if (content.hasData) {
                        if (!_isLoadMore) {
                          _books.clear();
                        }
                        _books.addAll(content.data);
                        return Expanded(
                          child: EasyRefresh(
                            key: _easyRefreshKey,
                            child: ListView.separated(
                                controller: _scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return bookListItem(
                                      context, index, _books[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                    height: 10,
                                    color: Theme.of(context).primaryColor,
                                  );
                                },
                                itemCount: _books.length),
                            refreshHeader: ClassicsHeader(
                              moreInfoColor: Theme.of(context).primaryColor,
                              bgColor: Colors.white10,
                              textColor: Theme.of(context).primaryColor,
                              key: _headerKey,
                              refreshText: "用力一点",
                              refreshReadyText: "释放",
                              refreshingText: "刷新中",
                              refreshedText: "刷新完成",
                              moreInfo: "上次刷新: %T",
                              showMore: true,
                            ),
                            refreshFooter: ClassicsFooter(
                              moreInfoColor: Theme.of(context).primaryColor,
                              bgColor: Colors.white10,
                              textColor: Theme.of(context).primaryColor,
                              key: _footerKey,
                              loadText: "用力一点",
                              loadReadyText: "释放",
                              loadingText: "加载中",
                              loadedText: "加载完成",
                              moreInfo: "上次加载：%T",
                              showMore: true,
                            ),
                            onRefresh: () async {
                              _isLoadMore = false;
                              _curPage = 1;
                              _bookListBloc.fetchBookList(
                                  _curSex, _curKind, _curPage);
                            },
                            loadMore: () async {
                              _isLoadMore = true;
                              _curPage++;
                              _bookListBloc.fetchBookList(
                                  _curSex, _curKind, _curPage);
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: WaitingWidget(
                              color: Theme.of(context).primaryColor),
                        );
                      }
                    }),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
